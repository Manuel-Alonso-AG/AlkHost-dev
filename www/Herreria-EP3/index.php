<?php
session_start();

if (isset($_SESSION['usuario_id'])) {
    header("Location: home.php");
    exit();
}

include 'config/conexion.php';

$error = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $email = $_POST['email'];
    $password = $_POST['password'];


    if (empty($email) || empty($password)) {
        $error = "Por favor, complete todos los campos";
    } else {
        $sql = "SELECT id, nombre, password FROM Usuarios WHERE email = '$email'";
        $result = $conn->query($sql);

        if (!$result->num_rows == 1) {
            $error = "Credenciales incorrectas";
            return;
        }

        $usuario = $result->fetch_assoc();

        if ($password !== $usuario['password']) {
            $error = "Credenciales incorrectas";
            return;
        }

        $_SESSION['usuario_id'] = $usuario['id'];
        $_SESSION['usuario_nombre'] = $usuario['nombre'];
        $_SESSION['usuario_email'] = $email;

        header("Location: home.php");
        exit();
    }
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión - Herrería Angel</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>

<body class="login-page">
    <div class="login-container">
        <div class="login-box">
            <div class="logo">
                <h1>🔨 Herrería Angel</h1>
                <p>Sistema de Gestión</p>
            </div>

            <form method="POST" action="">
                <h2>Iniciar Sesión</h2>

                <?php if (!empty($error)) { ?>
                    <div class="alert alert-error">
                        <?php echo $error; ?>
                    </div>
                <?php } ?>

                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" id="email" name="email" required
                        placeholder="admin@herreria.com"
                        value="<?php echo isset($_POST['email']) ?? ''; ?>">
                </div>

                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" name="password" required
                        placeholder="••••••••">
                </div>

                <button type="submit" class="btn btn-primary btn-block">
                    Ingresar
                </button>

                <div class="login-info">
                    <small>
                        <strong>Usuario de prueba:</strong><br>
                        Email: admin@herreria.com<br>
                        Contraseña: 1234567890
                    </small>
                </div>
            </form>
        </div>
    </div>
</body>

</html>