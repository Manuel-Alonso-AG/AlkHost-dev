<?php
/**
 * Agregar Producto - Herrería Angel
 * Método HTTP: POST para envío de datos
 */
session_start();

// Proteger página con sesión
if (!isset($_SESSION['usuario_id'])) {
    header("Location: index.php");
    exit();
}

require_once 'config/conexion.php';

$error = "";
$success = false;

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
    
    $sql = "INSERT INTO Productos (nombre, categoria, descripcion, precio, tiempo_elaboracion, material) 
            VALUES ('$nombre', '$categoria', '$descripcion', '$precio', '$tiempo', '$material')";
    
    
    if ($conn->query($sql)) {
        header("Location: home.php?msg=agregado");
        exit();
    } else {
        $error = "Error al agregar el producto: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Producto - Herrería Angel</title>
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
                    <?php echo $_SESSION['usuario_nombre']; ?>
                </span>
                <a href="home.php" class="btn btn-secondary btn-sm">← Volver</a>
                <a href="logout.php" class="btn btn-danger btn-sm">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="form-container">
            <h1>➕ Agregar Nuevo Producto</h1>
            
            <?php if (!empty($error)) { ?>
                <div class="alert alert-error">
                    <?php echo $error; ?>
                </div>
            <?php } ?>

            <form method="POST" action="">
                <div class="form-group">
                    <label for="nombre">Nombre del Producto *</label>
                    <input type="text" id="nombre" name="nombre" required 
                           placeholder="Ej: Puerta Principal Modelo A"
                           value="<?php echo isset($_POST['nombre']) ? htmlspecialchars($_POST['nombre']) : ''; ?>">
                </div>

                <div class="form-group">
                    <label for="categoria">Categoría *</label>
                    <select id="categoria" name="categoria" required>
                        <option value="">Seleccione una categoría</option>
                        <option value="Puertas" <?php echo (isset($_POST['categoria']) && $_POST['categoria'] == 'Puertas') ? 'selected' : ''; ?>>Puertas</option>
                        <option value="Ventanas" <?php echo (isset($_POST['categoria']) && $_POST['categoria'] == 'Ventanas') ? 'selected' : ''; ?>>Ventanas</option>
                        <option value="Rejas" <?php echo (isset($_POST['categoria']) && $_POST['categoria'] == 'Rejas') ? 'selected' : ''; ?>>Rejas</option>
                        <option value="Portones" <?php echo (isset($_POST['categoria']) && $_POST['categoria'] == 'Portones') ? 'selected' : ''; ?>>Portones</option>
                        <option value="Escaleras" <?php echo (isset($_POST['categoria']) && $_POST['categoria'] == 'Escaleras') ? 'selected' : ''; ?>>Escaleras</option>
                        <option value="Barandales" <?php echo (isset($_POST['categoria']) && $_POST['categoria'] == 'Barandales') ? 'selected' : ''; ?>>Barandales</option>
                        <option value="Otros" <?php echo (isset($_POST['categoria']) && $_POST['categoria'] == 'Otros') ? 'selected' : ''; ?>>Otros</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="descripcion">Descripción</label>
                    <textarea id="descripcion" name="descripcion" rows="4" 
                              placeholder="Descripción detallada del producto"><?php echo isset($_POST['descripcion']) ? htmlspecialchars($_POST['descripcion']) : ''; ?></textarea>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="precio">Precio (MXN) *</label>
                        <input type="number" id="precio" name="precio" step="0.01" min="0" required 
                               placeholder="0.00"
                               value="<?php echo isset($_POST['precio']) ? htmlspecialchars($_POST['precio']) : ''; ?>">
                    </div>

                    <div class="form-group">
                        <label for="tiempo_elaboracion">Tiempo de Elaboración</label>
                        <input type="text" id="tiempo_elaboracion" name="tiempo_elaboracion" 
                               placeholder="Ej: 7-10 días"
                               value="<?php echo isset($_POST['tiempo_elaboracion']) ? htmlspecialchars($_POST['tiempo_elaboracion']) : ''; ?>">
                    </div>
                </div>

                <div class="form-group">
                    <label for="material">Material</label>
                    <input type="text" id="material" name="material" 
                           placeholder="Ej: Hierro forjado, Tubo rectangular"
                           value="<?php echo isset($_POST['material']) ? htmlspecialchars($_POST['material']) : ''; ?>">
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success">💾 Guardar Producto</button>
                    <a href="home.php" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>