import express from 'express';
import DatabaseController from '../controllers/database.controller.js';

const router = express.Router();

router.get('/databases', DatabaseController.getDatabases);
router.get('/tables', DatabaseController.getTables);

export default router;