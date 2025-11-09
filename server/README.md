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


- Para uso de PHP, cambia el puerto de localhost a 9000. Por el momento, para acceder a tus proyectos PHP, tienes que ingresar a: http://localhost:9000/[Nombre-del-proyecto]/


- Implementación de base de datos MySQL; para poder conectarse, utiliza:
  - host: localhost
  - port: 3308
  - user: user
  - password: password


>[!IMPORTANT]
>Para la conexión de MySQL con PHP, al estar ambos servicios en contenedores de docker el host sera el nombre del servicio que contiene MySQL:
> - host: mysql
