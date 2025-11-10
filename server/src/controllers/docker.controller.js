import Docker from 'dockerode';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);
const docker = new Docker({ socketPath: '/var/run/docker.sock' });

class DockerController {
    async getServicesStuatus(req, res) {
        try {
            const containers = await docker.listContainers({ all: true });

            const services = containers.filter(container => {
                return container.Names[0].includes('php_service') ||
                    container.Names[0].includes('mysql') ||
                    container.Names[0].includes('alkhost-node');
            })
                .map(container => ({
                    id: container.Id,
                    name: container.Names[0],
                    image: container.Image,
                    state: container.State,
                    status: container.Status,
                    ports: container.Ports,
                }))

            res.json({
                success: true,
                services,
                timestamp: new Date().toISOString()
            })
        } catch (error) {
            res.status(500).json({
                success: false,
                error: error.message
            })
        }
    }

    async startService(req, res) {
        try {
            const { serviceId } = req.params;
            const container = docker.getContainer(serviceId);

            await container.start();

            res.json({
                success: true,
                message: "Servicio iniciado correctamente",
                serviceId
            });
        } catch (error) {
            res.status(500).json({
                success: false,
                error: error.message
            })
        }
    }

    async stopService(req, res) {
        try {
            const { serviceId } = req.params;
            const container = docker.getContainer(serviceId);

            await container.stop();

            res.json({
                success: true,
                message: 'Servicio detenido correctamente',
                serviceId
            });
        } catch (error) {
            console.error('Error deteniendo servicio:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }

    async restartService(req, res) {
        try {
            const { serviceId } = req.params;
            const container = docker.getContainer(serviceId);

            await container.restart();

            res.json({
                success: true,
                message: 'Servicio reiniciado correctamente',
                serviceId
            });
        } catch (error) {
            console.error('Error reiniciando servicio:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }

    async getServiceLogs(req, res) {
        try {
            const { serviceId } = req.params;
            const { tail = 100 } = req.query;

            const container = docker.getContainer(serviceId);
            const logs = await container.logs({
                stdout: true,
                stderr: true,
                tail: parseInt(tail),
                timestamps: true
            });

            res.json({
                success: true,
                logs: logs.toString('utf8')
            });
        } catch (error) {
            console.error('Error obteniendo logs:', error);
            res.status(500).json({
                success: false,
                error: error.message
            });
        }
    }

    async startAllServices(req, res) {
        try {
            const { stdout, stderr } = await execAsync('docker-compose up -d');

            res.json({
                success: true,
                message: 'Todos los servicios iniciados',
                output: stdout
            });
        } catch (error) {
            console.error('Error iniciando servicios:', error);
            res.status(500).json({
                success: false,
                error: error.message,
                stderr: error.stderr
            });
        }
    }

    async stopAllServices(req, res) {
        try {
            const { stdout, stderr } = await execAsync('docker-compose down');

            res.json({
                success: true,
                message: 'Todos los servicios detenidos',
                output: stdout
            });
        } catch (error) {
            console.error('Error deteniendo servicios:', error);
            res.status(500).json({
                success: false,
                error: error.message,
                stderr: error.stderr
            });
        }
    }
}

export default new DockerController();