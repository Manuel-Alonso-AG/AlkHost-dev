import express from 'express';
import dockerController from '../controllers/docker.controller.js';

const router = express.Router();

router.get('/services', dockerController.getServicesStuatus);
router.get('/services/:serviceId/logs', dockerController.getServiceLogs);

router.post('/services/:serviceId/start', dockerController.startService);
router.post('/services/:serviceId/stop', dockerController.stopService);
router.post('/services/:serviceId/restart', dockerController.restartService);

router.post('/services/start-all', dockerController.startAllServices);
router.post('/services/stop-all', dockerController.stopAllServices);

export default router;
