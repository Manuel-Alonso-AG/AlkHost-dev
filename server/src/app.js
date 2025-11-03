import express from "express";
// import cors from "cors";
import morgan from "morgan";
import { port } from "./config.js";
import projectsRoutes from "./routes/projects.routes.js";

const app = express();

//* Agregar cors para futuro frontend
// app.use(cors);
app.use(morgan("dev"));
app.use(express.json());

app.get("/", (req, res) => {
	res.send(`
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
						color: #3365afff;
					}
					p {
						margin: 10px 0;
					}
				</style>
            </head>
            <body>
                <h1>AlkHost dev</h1>
                
				<p>Entorno de desarrollo local web</p>
				<p>Esta en desarrollo</p>

				<h2>Acciones</h2>

				<a href="projects/">Lista de Projectos</a>

				<h3>By -Alons</h3>
            </body>
        </html>
		`);
});

app.use("/projects", projectsRoutes);

app.listen(port, () => {
	console.log(`Servidor corriendo en http://localhost:${port}`);
});
