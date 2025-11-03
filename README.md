# Entorno de desarrollo web local

>[!IMPORTANT]
>Este proyecto se encuentra en desarrollo, para poder probarlo en su equipo se necesita tener node js y docker

Para poder arrancar con el programa se decesita de ingresar a docker e iniciarlo

Despues en una terminal ingresa:

```
cd server
docker compose up -d --build
```

Para ver los logs y verificar que no hay errores:

```
docker compose logs -f node
```

>[!NOTE]
>Este proyecto esta diseñado para abrir el archivo idex.html de tu proyecto. Sin embargo todavia no implemento la posibilidad de usar archivos .css, .js o .php para poder dar estilo o funcionalidad a su proyecto web
