import express from 'express';
import databaseController from '../controllers/database.controller.js';

const router = express.Router();

router.get('/databases', databaseController.getDatabases);
router.get('/databases/:database/tables', databaseController.getTables);

export default router;