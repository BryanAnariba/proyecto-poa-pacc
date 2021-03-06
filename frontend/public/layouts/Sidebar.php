<div class="l-navbar" id="nav-bar">
        <nav class="nav">
            <div>
                <a href="../views/menu.php" class="nav__logo">
                    <img src="../img/partial-sidebar/control-panel-icon.svg" alt="Menu Principal">
                    <span class="nav__logo-name">Menu Principal</span>
                </a>
                    <div class="nav__list">
                    <?php 
                        $role = 'S_AD'; 
                        switch($role): 
                            case 'SG': // ROLE => Secretaria General
                    ?>
                        <a href="../views/control-permisos.php" class="nav__link">
                            <img src="../img/partial-sidebar/permisos-icon.svg" alt="Control de Usuarios">
                            <span class="nav__name">Control Permisos</span>
                        </a>

                        <a href="../views/informes-anuales.php" class="nav__link">
                            <img src="../img/partial-sidebar/informes-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Informes Anuales</span>
                        </a>

                        <a href="../views/tramites-graduacion.php" class="nav__link">
                            <img src="../img/partial-sidebar/graduacion-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Tramites Graduacion</span>
                        </a>
                    <?php 
                        break; 
                    ?>
                    <?php 
                        case 'S_AD': // ROLE => Super Administrador
                    ?>
                        <a href="../views/usuarios.php" class="nav__link">
                            <img src="../img/partial-sidebar/usuarios-icon.svg" alt="Control de Usuarios">
                            <span class="nav__name">Control Usuarios</span>
                        </a>

                        <a href="../views/dimensiones.php" class="nav__link">
                            <img src="../img/partial-sidebar/dimensiones-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Control Dimensiones</span>
                        </a>

                        <a href="../views/departamentos.php" class="nav__link">
                        <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                            <span class="nav__name">Control Departamentos</span>
                        </a>

                        <a href="../views/carreras.php" class="nav__link">
                            <img src="../img/partial-sidebar/carreras-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Control Carreras</span>
                        </a>
                    <?php 
                        break; 
                    ?>
                    <?php 
                        case 'DF': // ROLE => Decano Facultad
                    ?>
                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Usuarios">
                            <span class="nav__name">Decano</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/presupuesto-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Presupuesto</span>
                        </a>

                        <a href="" class="nav__link">
                        <img src="../img/partial-sidebar/informes-icon.svg" alt="Control de Departamentos">
                            <span class="nav__name">Reportes</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/calendario-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Calendario Actividades</span>
                        </a>
                    <?php 
                        break; 
                    ?>
                    <?php 
                        case 'SE': // ROLE => Secretaria Estratega
                    ?>
                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Usuarios">
                            <span class="nav__name">Estratega</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/presupuesto-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Presupuesto</span>
                        </a>

                        <a href="" class="nav__link">
                        <img src="../img/partial-sidebar/informes-icon.svg" alt="Control de Departamentos">
                            <span class="nav__name">Reportes</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/calendario-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Calendario Actividades</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/envio-permiso-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Control Permisos</span>
                        </a>
                        </a>
                    <?php 
                        break; 
                    ?>
                    <?php case 
                        'S_AC': // ROLE => usuario administrativo
                    ?>
                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Usuarios">
                            <span class="nav__name">Depto Administrativo</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/presupuesto-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Presupuesto</span>
                        </a>

                        <a href="" class="nav__link">
                        <img src="../img/partial-sidebar/informes-icon.svg" alt="Control de Departamentos">
                            <span class="nav__name">Reportes</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/calendario-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Calendario Actividades</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/envio-permiso-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Control Permisos</span>
                        </a>
                    <?php 
                        break; 
                    ?>
                    <?php 
                        case 'CD': // ROLE => Coordinador Departamento
                    ?>
                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Usuarios">
                            <span class="nav__name">Administrativo</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/calendario-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Actividades</span>
                        </a>

                        <a href="" class="nav__link">
                        <img src="../img/partial-sidebar/informes-icon.svg" alt="Control de Departamentos">
                            <span class="nav__name">Graficos y Reportes</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/envio-permiso-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Permisos</span>
                        </a>
                    <?php 
                        break; 
                    ?>
                    <?php 
                        case 'JD': // ROLE => Jefe Departamento
                    ?>
                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Usuarios">
                            <span class="nav__name">Administrativo</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/calendario-icon.svg" alt="Control de Dimensiones">
                            <span class="nav__name">Actividades</span>
                        </a>

                        <a href="" class="nav__link">
                        <img src="../img/partial-sidebar/informes-icon.svg" alt="Control de Departamentos">
                            <span class="nav__name">Graficos y Reportes</span>
                        </a>

                        <a href="" class="nav__link">
                            <img src="../img/partial-sidebar/envio-permiso-icon.svg" alt="Control de Carreras">
                            <span class="nav__name">Permisos</span>
                        </a>
                    <?php 
                        break; 
                    ?>
                    <?php endswitch; ?>
                </div>
            </div>
        <a href="" class="nav__link" data-toggle="modal" data-target="#modalCerrarSesion">
            <img src="../img/partial-sidebar/cerrar-sesion-icon.svg" alt="Cerrar sesion">
            <span class="nav__name">Cerrar sesion</span>
        </a>
    </nav>
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
                                <button type="button" class="btn btn-light-green btn-rounded">Cerrar Sesion</button>
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