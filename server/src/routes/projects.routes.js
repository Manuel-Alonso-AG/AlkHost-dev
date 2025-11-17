import express from "express";
import projectsController from '../controllers/projects.controller.js';

const router = express.Router();

router.get("/api/projects", (req, res) => {
	try {
		const projectsList = projectsController.allProjectsList();
		res.status(200).json({ projectsList });
	} catch (error) {
		res.send(500).json({
			success: false,
			error: error.message
		});
	}
})

router.get("/dashboard", (req, res) => projectsController.showAllProjects(req, res));

router.get("/:file/*splat", (req, res) => {
	projectsController.getProject(req, res, false)
});

router.get("/:file", (req, res) => {
	projectsController.getProject(req, res, !req.path.endsWith('/'))
});



export default router;
