<?php

$DB_HOST='mysql';
$DB_USER='user';
$DB_PASS= 'password';
$DB_NAME= 'app_backend';

$conn = new mysqli(
    $DB_HOST, 
    $DB_USER, 
    $DB_PASS, 
    $DB_NAME);

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}
?>