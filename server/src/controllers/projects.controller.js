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
                .filter(file => file.isDirectory)
                .map(file => file.name)

            res.render("main", { title: "Servidor web AlkHost", projects: projectsList })
        } catch (error) {
            res.status(500).json({
                error: "Error Al cargar la pagina principal",
                details: error.message,
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

                return this.serveDirectory(res, fullPath, file, subPath);
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
        
        console.log("❌ No se encontró index");
        
        res.status(403).render('error', {
            title: 'Sin archivo index',
            message: `El proyecto ${projectName} no tiene un archivo index.html o index.php \n
                Por favor, crea uno de estos archivos en: ${dirPath}`
        });
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

    //! Falta verificacion de implementacion
    async servePhpFile(res, filePath, projectName, subPath) {
        try {
            const relativePath = path.relative(projectsPath, filePath);
            const phpUrl = `http://localhost:${php_port}/${relativePath}`;

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
                    Error: ${error.message}
                    Asegúrate de que el servicio PHP esté corriendo.`
            });
        }
    }

    serve404(res, projectName, filePath) {
        res.status(404).render('error', {
            title: '404 - Archivo no encontrado',
            message: `No se pudo encontrar el archivo para el proyecto: ${projectName} \n
                Ruta buscada: ${filePath}`
        });
    }

}

export default new ProjectsController();