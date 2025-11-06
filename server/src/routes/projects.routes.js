import express from "express";
import projectsController from '../controllers/projects.controller.js';

const router = express.Router();

router.get("/dashboard", projectsController.showAllProjects);

router.get("/:file/*splat", (req, res) => {
	projectsController.getProject(req, res, false)
});

router.get("/:file", (req, res) => {
	projectsController.getProject(req, res, !req.path.endsWith('/'))
});


export default router;
