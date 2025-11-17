# Backend EXPRESS


Se utilizó Node.js como backend para poder usar Express para hacer el entorno local para proyectos web.


## Configuración de uso


Para poder abrir tu proyecto desde http://localhost:3000/:nombre del proyecto.


- Crea una carpeta con el nombre del proyecto a guardar dentro de la carpeta www.


>[!IMPORTANT]
>No confundir la carpeta www con la que esta dentro de la carpeta server
>
> ```markdown
> ├── client
> │ └── README.md
> ├── server
> │ └── ...
> └── www <-- Esta es la carpeta donde se guardan los proyectos
> ```


- Puedes tener una previsualización de los proyectos subidos si ingresas a:
 - http://localhost:3000/dashboard


- Abre un navegador e ingresa http://localhost:3000/
- Después agrega el nombre junto con /
  - Ejemplo: http://localhost:3000/ex1/


- Para uso de PHP pueden tener problemas en el desarrollo de aplicaicones grandes, pro el momento se encontro problemas en el uso de la base de datos mysql. Una solucion es cambiar el puerto de localhost a 9000 para acceder a tus proyectos PHP, tienes que ingresar a: http://localhost:9000/[Nombre-del-proyecto]/ 

>[!NOTE]
>No se porque ocurre pero estare investigando la razon
> projects.controller.js:214

``` js
async servePhpFile(res, filePath, projectName, subPath) {
        const relativePath = path.relative(projectsPath, filePath);

        try {
            const phpUrl = `http://php:8000/${relativePath}`;

            console.log("🐘 Ejecutando PHP:", phpUrl);

            const response = await fetch(phpUrl);

            if (!response.ok) {
                throw new Error(`PHP service responded with status: ${response.status}`);
            }

            const content = await response.text();

            console.log("✅ PHP ejecutado correctamente");

            res.setHeader("Content-Type", "text/html; charset=utf-8");
            res.send(content);
        } catch (error) {
            console.error("❌ Error ejecutando PHP:", error);
            res.status(500).render('errorPhp', {
                projectName,
                subPath,
                error: error.message,
                linkProject: `http://localhost:${php_port}/${relativePath}`
            });
        }
    }
```


- Implementación de base de datos MySQL; para poder conectarse, utiliza:
  - host: localhost
  - port: 3308
  - user: user
  - password: password


>[!IMPORTANT]
>Para la conexión de MySQL con PHP, al estar ambos servicios en contenedores de docker el host sera el nombre del servicio que contiene MySQL:
> - host: mysql
