import express from "express";
import path from "path";
import fs from "fs";
import mime from "mime-types";
import notFoundPage from "../pages/notFound.page.js"
import projectsList from "../pages/projectsList.page.js"

const router = express.Router();
const projectsPath = "./www";

router.get("/", (req, res) => {
	const files = fs.readdirSync(projectsPath, { withFileTypes: true });
	
	projectsList.reloadHtml();
	
	for (const file of files) 
		if (file.isDirectory) projectsList.addProject(file.name);

	res.send(projectsList.projectListPage());
});

router.get("/:file/*splat", async (req, res) => {
	console.log("🎯 CAPTURADA POR /:file/*splat");
	console.log("req.params:", req.params);

	const file = req.params.file;
	
	//? Por tu culpa no sabia porque no cargaba los archivos .css
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

		if (stats.isFile()) serveFile(res, fullPath);
		
		else if (stats.isDirectory()) serveDirectory(res, fullPath);
		
		else serve404(res, file, fullPath);
		
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

router.get("/:file", async (req, res) => {
	console.log("🎯 CAPTURADA POR /:file");
	console.log("req.params:", req.params);
	const file = req.params.file;

	//? Como lo puedo redirigir a una URL que termine con /
	const filePath = path.join(path.resolve(projectsPath, file), "");


	console.log("📁 Proyecto raiz:", file);
	console.log("🔍 Ruta:", filePath);

	try {
		const stats = fs.statSync(filePath);

		if (stats.isDirectory()) serveDirectory(res, filePath);
		
		else if (stats.isFile()) await serveFile(res, filePath);
		
		else serve404(res, file, filePath);
		
	} catch (error) {
		if (error.code === "ENOENT") {
			return serve404(res, file, filePath);
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
	console.log("🔍 Buscando index en:", dirPath);
	
	try {
		if (fs.existsSync(indexPath))
			return serveFile(res, indexPath);
	} catch (error) {
		res.status(403).send("Acceso denegado");
	}
}

//! Falta la implementacion de php
async function serveFile(res, filePath) {
	const ext = path.extname(filePath).toLowerCase();
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

function serve404(res, projectName, filePath) {
	res.status(404).send(notFoundPage(projectName, filePath));
}

export default router;
