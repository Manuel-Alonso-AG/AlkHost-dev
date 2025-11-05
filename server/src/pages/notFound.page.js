function send(projectName, filePath) {
	return `
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
						color: #c00;
					}
					p {
						margin: 10px 0;
					}
				</style>
            </head>
            <body>
                <h1>404 - Archivo no encontrado</h1>
                <p>No se pudo encontrar el archivo para el proyecto: <strong>${projectName}</strong></p>
                <p>Ruta buscada: <strong>${filePath}</strong></p>
            </body>
        </html>
`;
}

export default send;