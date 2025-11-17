<?php

session_start();


if (!isset($_SESSION['usuario_id'])) {
    header("Location: index.php");
    exit();
}

include 'config/conexion.php';

if (!isset($_GET['id']) || empty($_GET['id'])) {
    header("Location: home.php");
    exit();
}

$id = intval($_GET['id']);

$sql = "SELECT id FROM Productos WHERE id = '$id'";
$resultado = $conn->query($sql);

if ($resultado->num_rows == 0) {
    header("Location: home.php");
    exit();
}

$sql = "DELETE FROM Productos WHERE id = '$id'";

if ($conn->execute_query($sql)) {
    header("Location: home.php?msg=eliminado");
} else {
    header("Location: home.php?error=no_eliminado");
}

exit();
?>