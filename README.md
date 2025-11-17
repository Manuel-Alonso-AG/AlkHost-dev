# Entorno de desarrollo web local


>[!IMPORTANT]
>Este proyecto se encuentra en desarrollo, para poder probarlo en su equipo se necesita tener node js y docker


Para poder arrancar con el programa, se necesita ingresar a Docker e iniciarlo.


Después, en una terminal ingresa:


```
cd server
docker compose up -d --build
```


Para ver los logs y verificar que no hay errores:


```
docker compose logs -f node
```

Con docker inicializado puedes abrir el panel de flutter
>[!IMPORTANT]
>Por el momento el panel como tal funciona para poder levantar o parar los servicios. Pero como este esta utilizaondo el backend de node para poder acceder a los servicios. Perimero se tiene que inicializar node desde docker. Se estara trabajando en una solucion.

>[!NOTE]
>Este proyecto esta diseñado para manejar paginas web estaticas y dinamicas utilizando php ademas de manejar base de datos MySQL

![Dashboard](localhost_3000_dashboard.png)
![!AlkHostManager](AlkHostClientDashboard.png)
![!AlkHostManagerProjects](AlkHostClientProjects.png)
![!AlkHostManagerDatabases](AlkHostClientDatabases.png)