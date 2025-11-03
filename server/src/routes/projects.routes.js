import express from "express";
import path from "path";
import fs from "fs";
import mime from "mime-types";

const router = express.Router();
const projectsPath = "./www";

router.get("/", (req, res) => {
	const files = fs.readdirSync(projectsPath, { withFileTypes: true });
	let html = `
		<html>
            <head>
                <title>AlkHost</title>
				<style>
					body {
						font-family: Arial, sans-serif;
						background-color: #f4f4f4;
						color: #333;
						margin: 0;
						padding: 20px;
					}
					h1 {
						color: #192025ff;
					}
					p {
						margin: 10px 0;
					}
				</style>
            </head>
            <body>
                <h1>Listado de projectos</h1>
				<ul>
                `;

	for (const file of files) {
		if (file.isDirectory) {
			const dirFile = `http://localhost:3000/projects/${file.name}/`;
			html += `<li><a href = "${dirFile}">${dirFile}</a></li>`;
		}
	}

	html += `</ul></body></html>`;

	res.send(html);
});

//! Falta implementar la funcionalidad de lectura de archivos .css, .js, .php
router.get("/:file/{*splat}", async (req, res) => {
	const file = req.params.file;
	const subPath = req.params[0] || "";

	const filePath = path.resolve(projectsPath, file);
	const fullPath = path.join(filePath, subPath);

	console.log("Solicitud para el proyecto:", fullPath);

	try {
		const stats = fs.statSync(fullPath);

		if (stats.isDirectory()) {
			serveDirectory(res, fullPath);
		} else if (stats.isFile()) {
			serveFile(res, fullPath);
		} else {
			serve404(res, file, fullPath);
		}
	} catch (error) {
		if (error.code === "ENOENT") {
			return serve404(res, file, fullPath);
		} else {
			res.status(500).json({
				error: "Error interno del servidor",
				details: error.message,
			});
		}
	}
});

function serveDirectory(res, dirPath) {
	const indexPath = path.join(dirPath, "index.html");
	try {
		fs.accessSync(indexPath, fs.constants.R_OK);
		serveFile(res, indexPath);
	} catch (error) {
		res.status(403).send("Acceso denegado");
	}
}

function serveFile(res, filePath) {
	const ext = path.extname(filePath).toLowerCase();
	const mimeType = mime.lookup(filePath) || "application/octet-stream";

	res.setHeader("Content-Type", mimeType);
	res.setHeader("Cache-Control", "no-cache");

	if ([".html", ".css", ".js"].includes(ext)) {
		res.setHeader("X-Content-Type-Options", "nosniff");
	}

	const fileContent = fs.readFileSync(filePath);
	res.send(fileContent);
}

function serve404(res, projectName, filePath) {
	res.status(404).send(`
        <html>
            <head>
                <title>404 - Archivo no encontrado</title>
				<style>
					body {
						font-family: Arial, sans-serif;
						background-color: #f4f4f4;
						color: #333;
						margin: 0;
						padding: 20px;
					}
					h1 {
						color: #c00;
					}
					p {
						margin: 10px 0;
					}
				</style>
            </head>
            <body>
                <h1>404 - Archivo no encontrado</h1>
                <p>No se pudo encontrar el archivo para el proyecto: <strong>${projectName}</strong></p>
                <p>Ruta buscada: <strong>${filePath}</strong></p>
            </body>
        </html>
        `);
}

export default router;
