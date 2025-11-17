<?php

session_start();


if (!isset($_SESSION['usuario_id'])) {
    header("Location: index.php");
    exit();
}

include 'config/conexion.php';

$sql = "SELECT * FROM Productos ORDER BY fecha_creacion DESC";
$resultado = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Herrería Angel</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-brand">
                <h2>🔨 Herrería Angel</h2>
            </div>
            <div class="nav-menu">
                <span class="user-info">
                    Bienvenido, <strong><?php echo $_SESSION['usuario_nombre']; ?></strong>
                </span>
                <a href="logout.php" class="btn btn-danger btn-sm">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>Gestión de Productos</h1>
            <a href="agregar.php" class="btn btn-success">➕ Agregar Producto</a>
        </div>

        <?php if (isset($_GET['msg'])) { ?>
            <div class="alert alert-success">
                <?php 
                    if ($_GET['msg'] == 'agregado') echo "Producto agregado exitosamente";
                    if ($_GET['msg'] == 'actualizado') echo "Producto actualizado exitosamente";
                    if ($_GET['msg'] == 'eliminado') echo "Producto eliminado exitosamente";
                ?>
            </div>
        <?php } ?>

        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Categoría</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Tiempo</th>
                        <th>Material</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if ($resultado->num_rows > 0) { ?>
                        <?php while ($producto = $resultado->fetch_assoc()) { ?>
                            <tr>
                                <td><?php echo $producto['id']; ?></td>
                                <td><strong><?php echo $producto['nombre']; ?></strong></td>
                                <td>
                                    <span class="badge badge-<?php echo $producto['categoria']; ?>">
                                        <?php echo $producto['categoria']; ?>
                                    </span>
                                </td>
                                <td><?php echo $producto['descripcion']; ?></td>
                                <td><strong>$<?php echo $producto['precio']; ?></strong></td>
                                <td><?php echo $producto['tiempo_elaboracion']; ?></td>
                                <td><?php echo $producto['material']; ?></td>
                                <td class="actions">
                                    <a href="editar.php?id=<?php echo $producto['id']; ?>" 
                                       class="btn btn-warning btn-sm">✏️ Editar</a>
                                    <a href="eliminar.php?id=<?php echo $producto['id']; ?>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('¿Está seguro de eliminar este producto?')">
                                       🗑️ Eliminar
                                    </a>
                                </td>
                            </tr>
                        <?php } ?>
                    <?php } else { ?>
                        <tr>
                            <td colspan="8" class="text-center">No hay productos registrados</td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>
        </div>

        <div class="stats">
            <div class="stat-card">
                <h3><?php echo $resultado->num_rows; ?></h3>
                <p>Productos Totales</p>
            </div>
        </div>
    </div>
    
</body>
</html>