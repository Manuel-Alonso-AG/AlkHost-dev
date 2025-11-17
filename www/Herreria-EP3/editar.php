<?php

session_start();


if (!isset($_SESSION['usuario_id'])) {
    header("Location: index.php");
    exit();
}

include 'config/conexion.php';

$error = "";
$producto = null;


if (!isset($_GET['id']) || empty($_GET['id'])) {
    header("Location: home.php");
    exit();
}

$id = intval($_GET['id']);


$sql = "SELECT * FROM Productos WHERE id = '$id'";
$resultado = $conn->query($sql);

if ($resultado->num_rows == 0) {
    header("Location: home.php");
    exit();
}

$producto = $resultado->fetch_assoc();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    
    $nombre = $_POST['nombre'];
    $categoria = $_POST['categoria'];
    $descripcion = $_POST['descripcion'];
    $precio = $_POST['precio'];
    $tiempo = $_POST['tiempo_elaboracion'];
    $material = $_POST['material'];
    
    
    if (empty($nombre) || empty($categoria) || empty($precio)) {
        $error = "Los campos Nombre, Categoría y Precio son obligatorios";
        return;
    }
    
    $sql = "UPDATE Productos 
            SET nombre = '$nombre', categoria = '$categoria', descripcion = '$descripcion', precio = '$precio', 
                tiempo_elaboracion = '$tiempo', material = '$material' 
            WHERE id = '$id'";

    if ($conn->query($sql)) {
        header("Location: home.php?msg=actualizado");
        exit();
    } else {
        $error = "Error al actualizar el producto: " . $conn->error;
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Producto - Herrería Angel</title>
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
                    <?php echo htmlspecialchars($_SESSION['usuario_nombre']); ?>
                </span>
                <a href="home.php" class="btn btn-secondary btn-sm">← Volver</a>
                <a href="logout.php" class="btn btn-danger btn-sm">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="form-container">
            <h1>✏️ Editar Producto</h1>
            
            <?php if (!empty($error)): ?>
                <div class="alert alert-error">
                    <?php echo $error; ?>
                </div>
            <?php endif; ?>

            <form method="POST" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) . '?id=' . $id; ?>">
                <div class="form-group">
                    <label for="nombre">Nombre del Producto *</label>
                    <input type="text" id="nombre" name="nombre" required 
                           value="<?php echo htmlspecialchars($producto['nombre']); ?>">
                </div>

                <div class="form-group">
                    <label for="categoria">Categoría *</label>
                    <select id="categoria" name="categoria" required>
                        <option value="">Seleccione una categoría</option>
                        <option value="Puertas" <?php echo ($producto['categoria'] == 'Puertas') ? 'selected' : ''; ?>>Puertas</option>
                        <option value="Ventanas" <?php echo ($producto['categoria'] == 'Ventanas') ? 'selected' : ''; ?>>Ventanas</option>
                        <option value="Rejas" <?php echo ($producto['categoria'] == 'Rejas') ? 'selected' : ''; ?>>Rejas</option>
                        <option value="Portones" <?php echo ($producto['categoria'] == 'Portones') ? 'selected' : ''; ?>>Portones</option>
                        <option value="Escaleras" <?php echo ($producto['categoria'] == 'Escaleras') ? 'selected' : ''; ?>>Escaleras</option>
                        <option value="Barandales" <?php echo ($producto['categoria'] == 'Barandales') ? 'selected' : ''; ?>>Barandales</option>
                        <option value="Otros" <?php echo ($producto['categoria'] == 'Otros') ? 'selected' : ''; ?>>Otros</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea id="descripcion" name="descripcion" rows="4"><?php echo htmlspecialchars($producto['descripcion']); ?></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="precio">Precio (MXN) *</label>
                        <input type="number" id="precio" name="precio" step="0.01" min="0" required 
                               value="<?php echo $producto['precio']; ?>">
                    </div>

                    <div class="form-group">
                        <label for="tiempo_elaboracion">Tiempo de Elaboración</label>
                        <input type="text" id="tiempo_elaboracion" name="tiempo_elaboracion" 
                               value="<?php echo htmlspecialchars($producto['tiempo_elaboracion']); ?>">
                    </div>
                </div>

                <div class="form-group">
                    <label for="material">Material</label>
                    <input type="text" id="material" name="material" 
                           value="<?php echo htmlspecialchars($producto['material']); ?>">
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">💾 Actualizar Producto</button>
                    <a href="home.php" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>