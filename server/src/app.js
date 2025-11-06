import express from "express";
// import cors from "cors";
import morgan from "morgan";
import { port } from "./config.js";
import projectsRoutes from "./routes/projects.routes.js";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));

app.use(morgan("dev"));
app.use(express.json());

app.use((req, res, next) => {
    const systemPaths = [
        '/favicon.ico',
        '/.well-known',
        '/robots.txt',
        '/sitemap.xml'
    ];
    
    if (systemPaths.some(path => req.path.startsWith(path))) {
        return res.status(204).end();
    }
    
    next();
});

app.use('/', projectsRoutes);

app.listen(port, () => {
	console.log(`Servidor corriendo en http://localhost:${port}`);
});
