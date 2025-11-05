import express from "express";
// import cors from "cors";
import morgan from "morgan";
import { port } from "./config.js";
import projectsRoutes from "./routes/projects.routes.js";
import mainPage from "./pages/main.page.js"

const app = express();

//* Agregar cors para futuro frontend
// app.use(cors);
app.use(morgan("dev"));
app.use(express.json());

app.get("/", (req, res) => {
	res.send(mainPage);
});

app.use("/projects", projectsRoutes);

app.listen(port, () => {
	console.log(`Servidor corriendo en http://localhost:${port}`);
});
