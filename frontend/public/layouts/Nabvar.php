<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    include('../partials/doctype.php');
    include('verifica-session.php');    
?>
<header class="header amber accent-4" id="header">
    <div class="header__toggle">
    <i class="fas fa-bars" id="header-toggle"></i>
    </div>
    <div class="ml-auto" id="navbarSupportedContent-555">
        <ul id="dropdown-lista" class="navbar-nav nav-flex-icons ">
            <li class="nav-item avatar dropdown dropdown-items">
                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-55" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <img src="../img/menu/email.svg" width="40" class="rounded-circle z-depth-0 " alt="avatar image">
                </a>
                <div id="dropdown-acciones" class="dropdown-menu dropdown-menu-lg-right dropdown-secondary" aria-labelledby="navbarDropdownMenuLink-55">
                    <a class="dropdown-item" href="#">Notificacion 1</a>
                    <a class="dropdown-item" href="#">Notificacion 2</a>
                    <a class="dropdown-item" href="#">Notificacion 3</a>
                </div>
            </li>
            <li class="nav-item avatar dropdown dropdown-items">
                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-55" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="text-white">bsancheza</span>
                    <img src="<?= ($_SESSION['avatarUsuario'] != null) ? $_SESSION['avatarUsuario'] : '../img/menu/usuario.svg'?>" width="40" class="rounded-circle z-depth-0 " alt="avatar image">
                </a>
                <div id="dropdown-acciones" class="dropdown-menu dropdown-menu-lg-right dropdown-secondary" aria-labelledby="navbarDropdownMenuLink-55">
                    <a class="dropdown-item" href="" data-toggle="modal" data-target="#modalMiPerfil">
                        <img src="../img/menu/user-icon.svg" alt="mi perfil">
                        Mi perfil
                    </a>
                    <a class="dropdown-item" href=""  data-toggle="modal" data-target="#modalAgregarFoto">
                        <img src="../img/menu/galeria.svg" alt="cambio fotografia">
                        Cambio de foto
                    </a>
                    <a class="dropdown-item" data-toggle="modal" data-target="#modalCambioClave" href="">
                        <img src="../img/menu/password-icon.svg" alt="cambio clave">
                        Cambio de clave
                    </a>
                    <a class="dropdown-item" data-toggle="modal" data-target="#modalCerrarSesion" href="">
                        <img src="../img/menu/cerrar-sesion.svg" alt="cambio fotografia">
                        Cerrar sesion
                    </a>
                </div>
            </li>
        </ul>
    </div>
</header>

<!--Zona de modales-->
<!--Cambio Clave-->
<div class="modal fade" id="modalCambioClave" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cascading-modal modal-avatar modal-md" role="document">
        <!--Content-->
        <div class="modal-content">

            <!--Header-->
            <div class="modal-header">
                <img src="<?= ($_SESSION['avatarUsuario'] != null) ? $_SESSION['avatarUsuario'] : '../img/menu/usuario.svg'?>" class="rounded-circle mx-auto img-fluid" height="128px" width="128px" alt="Foto Perfil">
            </div>
            <!--Body-->
            <div class="modal-body text-center mb-1">

                <h5 class="mt-1 mb-2"><?= $_SESSION['correoInstitucional']?></h5>

                <div class="md-form ml-0 mr-0">
                    <input type="password" type="text" id="password" class="form-control form-control-sm validate ml-0">
                    <label data-error="wrong" data-success="right" for="form29" class="ml-0">Digite la nueva clave</label>
                </div>
                <div class="md-form ml-0 mr-0">
                    <input type="password" type="text" id="newPassword" class="form-control form-control-sm validate ml-0">
                    <label data-error="wrong" data-success="right" for="form29" class="ml-0">Repita la nueva clave</label>
                </div>

                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-light-green btn-rounded">Guardar</button>
                            </div>
                        </div>
                        <div class="col">
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-danger btn-rounded" data-dismiss="modal" aria-label="Close">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer amber accent-4">
                
            </div>
        </div>
    </div>
</div>


<!--Cambio Fotografia-->
<div class="modal fade" id="modalAgregarFoto" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header indigo darken-4 text-white">
                <h5 class="modal-title" id="exampleModalLongTitle">Selecciona una foto de el ordenador</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
            <form class="md-form">
                <div class="file-field">
                    <div class="mb-4">
                        <img src="https://mdbootstrap.com/img/Photos/Others/placeholder-avatar.jpg"
                            class="rounded-circle z-depth-1-half avatar-pic mx-auto d-flex" alt="agregar foto perfil">
                        </div>
                        <div class="d-flex justify-content-center">
                        <div class="btn btn-mdb-color btn-rounded float-left">
                            <span>Agregar Foto</span>
                            <input type="file">
                        </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer amber accent-4">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-light-green btn-rounded">Guardar</button>
                            </div>
                        </div>
                        <div class="col">
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-danger btn-rounded" data-dismiss="modal" aria-label="Close">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--Modal Mi perfil-->
<div class="modal fade" id="modalMiPerfil" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog cascading-modal modal-avatar modal-md" role="document">
        <!--Content-->
        <div class="modal-content">

            <!--Header-->
            <div class="modal-header">
            <img src="<?= ($_SESSION['avatarUsuario'] != null) ? $_SESSION['avatarUsuario'] : '../img/menu/usuario.svg'?>" class="rounded-circle mx-auto img-fluid rounded-circle img-responsive" alt="Foto Perfil">
            </div>
            <!--Body-->
            <div class="modal-body text-center mb-1">
                <p class="font-weight-bolder"><h5>Nombre Completo:</h5><?=$_SESSION['nombrePersona']?> <?=$_SESSION['apellidoPersona']?></p>
                <p class="font-weight-bolder"><h5>Correo:</h5> <?=$_SESSION['correoInstitucional']?></p>
                <p class="font-weight-bolder"><h5>Cargo:</h5> <?=$_SESSION['tipoUsuario']?></p>
                <p class="font-weight-bolder"><h5>Departamento:</h5> <?=$_SESSION['abrev']?></p>
                <p class="font-weight-bolder"><h5>No Empleado:</h5> <?=$_SESSION['codigoEmpleado']?></p>
                <p class="font-weight-bolder"><h5>Presupuesto Departamento Disponible:</h5> 142,000 Lps</p>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-danger btn-rounded" data-dismiss="modal" aria-label="Close">Salir</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer amber accent-4">
                
            </div>

        </div>
    </div>
</div>

<!-- Modal para Cerrar sesion-->
<div class="modal fade" id="modalCerrarSesion" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header indigo darken-4 text-white">
                <h5 class="modal-title" id="exampleModalLongTitle">Esta seguro de salir de la plataforma ?</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-light-green btn-rounded"
                                    onclick="cerrarSesion()"
                                >Cerrar Sesion</button>
                            </div>
                        </div>
                        <div class="col">
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-danger btn-rounded" data-dismiss="modal" aria-label="Close">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer amber accent-4">
                
            </div>
        </div>
    </div>
</div>