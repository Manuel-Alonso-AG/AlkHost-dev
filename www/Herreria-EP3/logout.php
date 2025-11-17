<?php
/**
 * Cerrar Sesión - Herrería Angel
 * Destruye la sesión y redirige al login
 */
session_start();

// Destruir todas las variables de sesión
$_SESSION = array();

// Destruir la sesión
session_destroy();

// Redirigir al login
header("Location: index.php");
exit();
?>