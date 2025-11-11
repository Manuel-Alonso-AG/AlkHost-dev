import fs from "fs";
import path from "path";
import mime from "mime-types";
import { php_port } from "../config.js";

const projectsPath = "./www";

class ProjectsController {
    async showAllProjects(req, res) {
        try {
            const files = fs.readdirSync(projectsPath, { withFileTypes: true });

            const projectsList = files
                .filter(file => {
                    return file.isDirectory() && !file.name.startsWith('.');
                })
                .map(file => {
                    const projectPath = path.join(projectsPath, file.name);
                    const stats = fs.statSync(projectPath);

                    const hasPhp = fs.existsSync(path.join(projectPath, 'index.php'));
                    const hasHtml = fs.existsSync(path.join(projectPath, 'index.html'));

                    return {
                        name: file.name,
                        type: hasPhp ? 'PHP' : hasHtml ? 'HTML' : 'Carpeta',
                        lastModified: stats.mtime.toLocaleDateString('es-ES', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric'
                        })
                    };
                });

            res.render("main", {
                title: "Servidor web AlkHost",
                projects: projectsList,
                totalProjects: projectsList.length
            });
        } catch (error) {
            console.error("Error al cargar proyectos:", error);
            res.status(500).render('error', {
                title: "Error al cargar la página principal",
                message: `No se pudieron cargar los proyectos: ${error.message}`,
                escapeHtml: false
            });
        }
    }

    async getProject(req, res, shouldRedirect) {
        console.log("🎯 --------------------");
        console.log("req.params:", req.params);

        const file = req.params.file;
        const subPath = Array.isArray(req.params.splat)
            ? req.params.splat.join('/')
            : (req.params.splat || '');

        const filePath = path.resolve(projectsPath, file);
        const fullPath = path.join(filePath, subPath);

        console.log("📂 Proyecto:", file);
        console.log("📄 Subpath:", subPath);
        console.log("🔍 Ruta completa:", fullPath);

        try {
            const stats = fs.statSync(fullPath);

            if (stats.isDirectory()) {
                if (shouldRedirect) {
                    console.log("🔄 Redirigiendo con slash...");
                    return res.redirect(301, req.path + '/');
                }

                return this.serveDirectory(res, fullPath, file);
            }

            else if (stats.isFile()) return this.serveFile(res, fullPath);

            else return this.serve404(res, file, fullPath);

        } catch (error) {
            if (error.code === "ENOENT")
                return this.serve404(res, file, fullPath);
            else
                res.status(500).json({
                    error: "Error interno del servidor",
                    details: error.message,
                });

        }
    }

    serveDirectory(res, dirPath, projectName) {
        const indexHtml = path.join(dirPath, "index.html");
        const indexPhp = path.join(dirPath, "index.php");

        console.log("🔍 Buscando index en:", dirPath);

        if (fs.existsSync(indexHtml)) {
            console.log("✅ Encontrado index.html");
            return this.serveFile(res, indexHtml, projectName, "index.html");
        }

        if (fs.existsSync(indexPhp)) {
            console.log("✅ Encontrado index.php");
            return this.servePhpFile(res, indexPhp, projectName, "index.php");
        }

        const relativeSubPath = path.relative(
            path.join(projectsPath, projectName),
            dirPath
        );

        console.log("📂 No se encontró index");
        return this.showDirectoryListing(res, dirPath, projectName, relativeSubPath);
    }

    showDirectoryListing(res, dirPath, projectName, subPath) {
        try {
            const content = fs.readdirSync(dirPath, { withFileTypes: true });

            const filtered = content.filter(item => !item.name.startsWith('.'))
                .sort((a, b) => {
                    if (a.isDirectory() && !b.isDirectory()) return -1;
                    if (!a.isDirectory() && b.isDirectory()) return 1;
                    return a.name.localeCompare(b.name);
                })

            const filesList = filtered.map(file => {
                const isDir = file.isDirectory();
                const urlPath = subPath && subPath !== '.' ? `/${projectName}/${subPath}/${file.name}` : `/${projectName}/${file.name}`;

                return {
                    name: file.name,
                    url: isDir ? urlPath + '/' : urlPath,
                    isDirectory: isDir,
                    icon: this.getIconFile(isDir)
                };
            });

            res.status(403).render('directoryListing', {
                filePath: subPath + '/' + projectName,
                filesList
            });
        } catch (error) {
            console.error("❌ Error generando listado:", error);
            res.status(500).render('error', {
                title: 'Error al listar directorio',
                message: `No se pudo generar el listado del directorio: ${error.message}`,
                escapeHtml: false
            });
        }
    }

    getIconFile(isDir) {
        if (isDir) return '🗂️';

        //* Agregar mas iconos para los tipos de archivos

        return '📄';
    }

    async serveFile(res, filePath, projectName, subPath) {
        const ext = path.extname(filePath).toLowerCase();

        if (ext == "php") return this.servePhpFile(res, filePath, projectName, subPath);

        const mimeType = mime.lookup(filePath) || "application/octet-stream";

        console.log("📤 Accediendo al archivo:", filePath);
        console.log("📤 Extension:", ext);
        console.log("📤 MIME type:", mimeType);

        res.setHeader("Content-Type", mimeType);
        res.setHeader("Cache-Control", "no-cache");

        if ([".html", ".css", ".js"].includes(ext))
            res.setHeader("X-Content-Type-Options", "nosniff");

        try {
            const fileContent = fs.readFileSync(filePath);
            res.send(fileContent);
        } catch (error) {
            console.error("❌ Error leyendo archivo:", error);
            res.status(500).send("Error leyendo archivo");
        }
    }

    async servePhpFile(res, filePath, projectName, subPath) {
        const relativePath = path.relative(projectsPath, filePath);

        try {
            const phpUrl = `http://php:8000/${relativePath}`;

            console.log("🐘 Ejecutando PHP:", phpUrl);

            const response = await fetch(phpUrl);

            if (!response.ok) {
                throw new Error(`PHP service responded with status: ${response.status}`);
            }

            const content = await response.text();

            console.log("✅ PHP ejecutado correctamente");

            res.setHeader("Content-Type", "text/html; charset=utf-8");
            res.send(content);
        } catch (error) {
            console.error("❌ Error ejecutando PHP:", error);
            res.status(500).render('error', {
                title: 'Error ejecutando PHP',
                message: `No se pudo ejecutar el archivo PHP: ${projectName}/${subPath} 
                <br><br>
                <strong>Error:</strong> ${error.message}
                <br><br>
                <em>Asegúrate de que el servicio PHP esté corriendo.</em>
                <br><br>
                <strong>Desde tu navegador puedes acceder a:</strong>
                <br>
                <a class="error-page-a" href="http://localhost:${php_port}/${relativePath}">
                    http://localhost:${php_port}/${relativePath}
                </a>`,
                escapeHtml: false
            });
        }
    }

    serve404(res, projectName, filePath) {
        res.status(404).render('error', {
            title: '404 - Archivo no encontrado',
            message: `No se pudo encontrar el archivo para el proyecto: ${projectName} <br>
                Ruta buscada: ${filePath}`,
            escapeHtml: false
        });
    }

}

export default new ProjectsController();