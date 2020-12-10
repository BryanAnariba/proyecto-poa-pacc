<!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="public/css/libreria-bootstrap-mdb/mdb.min.css" />
        <link rel="stylesheet" href="public/css/login/login.css" />
        <link rel="stylesheet" href="public/css/animaciones/animate.min.css" />
        <title>Inicio Sesion</title>
    </head>

    <body>
        <div class="container">
            <div class="forms-container animate__animated animate__flipInX">
                <div class="signin-signup">
                    <form class="sign-in-form">
                        <h2 class="title">Inicio de sesion</h2>
                        <div class="input-field ">
                            <i class="fas fa-user"></i>
                            <input type="text" placeholder="Correo Electronico UNAH" />
                        </div>
                        <div class="input-field ">
                            <i class="fas fa-lock"></i>
                            <input type="password" placeholder="Contraseña" />
                        </div>
                        <input type="button" value="Login" class="btn solid" alt="Login al sistema"/>
                    </form>
                </div>
            </div>

            <div class="panels-container">
                <div class="panel left-panel">
                    <div class="content animate__animated animate__fadeInTopLeft">
                        <h3>Bienvenido al sistema POA PACC</h3>
                        <p>
                            Para acceder al sistema deberas contar con las debidas credenciales de acceso.
                        </p>
                        <button type="button" class="btn solid btn-block" id="sign-up-btn" alt="Olvidaste tu contraseña">
                            Olvidaste tu contraseña
                        </button>
                    </div>
                    <img src="public/img/login/login-avatar.svg" class="image animate__animated animate__fadeInTopLeft" alt="login-avatar" />
                </div>
            </div>
        </div>
    </body>
</html>