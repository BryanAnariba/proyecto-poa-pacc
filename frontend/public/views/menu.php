<?php
    include('../partials/doctype.php');
?>
    <title>Menu Principal</title>
    <!--En esta zona podran poner estilos propios de la vista-->
    </head>
    <body id="body-pd">
        <?php include('../layouts/Nabvar.php'); ?>
        <?php include('../layouts/Sidebar.php'); ?>

        <div id="profile-card" class="container">
            <div class="card">
                <div class="card-header indigo darken-4 text-center text-white">
                    <h5 class="font-weight-bolder">Informacion usuario</h5>
                </div>
                <div class="card-body">
                    <div class="container">
                        <div class="row mx-auto">
                            <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12">
                                <div class="card-body d-flex flex-row">
                                    <img src="../img/menu/avatar-2.jpg" class="rounded-circle mx-auto img-fluid" height="128px" width="128px" alt="Foto Perfil">
                                </div>
                            </div>
                            <div class="col-xl-5 col-lg-5 col-md-6 col-sm-12 mr-auto">
                                <section class="mx-auto">
                                    <h4 class="card-title font-weight-bold mb-2">
                                        Bienvenido@ 
                                    </h4> 
                                    <p class="card-text font-weigth-bolder text-dark">Bryan Ariel Sanchez Anariba</p>
                                    <p class="card-text font-weigth-bolder text-dark">bsancheza@unah.hn</p>
                                    <p class="card-text font-weigth-bolder text-dark">IS-231233</p>
                                </section>
                            </div>
                            <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12">      
                                <section>
                                    <h4 class="card-title font-weight-bold mb-2">Datos de mi cargo</h4>
                                    <p class="card-text">Jefe Departamento</p>
                                    <p class="card-text">Ingenieria en Sistemas</p>
                                    <p class="card-text">IS</p>
                                </section>      
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer amber accent-4">

                </div>
            </div>


            <!--Opciones Segun rol-->
            <?php 
            $role = 'S_AD'; 
            switch($role): 
                case 'SG': // ROLE => Secretaria General -> AJAX PARA CARGAR GRAFICOS
            ?>
            <?php 
                break; 
            ?>
            <?php  
                case 'S_AD': // ROLE => Super Administrador -> AJAX PARA CARGAR REGISTROS
            ?>
            <?php 
                break; 
            ?>
            <?php 
                case 'DF': // ROLE => Decano Facultad
            ?>
                <div class="row mt-5">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header indigo darken-4 text-white">
                                <h5 class="font-weight-bolder text-center"> 
                                    Maneja el control de informes desde este panel
                                </h5>
                            </div>
                            <div class="card-body  blue lighten-5">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xl-2 col-lg-2 hidden-md-2 hidden-sm-down mb-3"> 
                                        </div>
                                        <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-3">
                                            <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                                <div class="card-header amber accent-4">
                                                    <div class="row">
                                                        <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                            <h6 class="text-white font-weight-bold">
                                                                Informes aprobados
                                                            </h6>
                                                        </div>
                                                        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Visualizar informes">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <br>
                                                    <div class="view overlay">
                                                        <img 
                                                            class="card-img-top" 
                                                            src="../img/menu/informes-aprobados.svg" 
                                                            alt="visualizar informes aprobados">
                                                    </div>
                                                    <hr>
                                                    <button 
                                                        type="button"
                                                        class="btn btn-indigo btn-block"  
                                                        data-toggle="modal" 
                                                        data-target="#modalInformesAprobados">
                                                        Ver Informes Aprobados
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-3">
                                            <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                                <div class="card-header amber accent-4">
                                                    <div class="row">
                                                        <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                            <h6 class="text-white font-weight-bold">
                                                                Informes pendientes
                                                            </h6>
                                                        </div>
                                                        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <br>
                                                    <div class="view overlay">
                                                        <img 
                                                            class="card-img-top" 
                                                            src="../img/menu/informes-pendientes.svg" 
                                                            alt="control informes">
                                                    </div>
                                                    <hr>
                                                    <button 
                                                        type="button"
                                                        class="btn btn-indigo btn-block"  
                                                        data-toggle="modal" 
                                                        data-target="#modalInformesPendientes">
                                                            Ver Informes Pendientes
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-2 hidden-md-2 hidden-sm-down mb-3"> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer amber accent-4">

                            </div>
                        </div>
                    </div>
                </div>
            <?php 
                break; 
            ?>
            <?php 
                case 'SE': // ROLE => Secretaria Estratega
            ?>
                <div class="row mt-5">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header indigo darken-4 text-white">
                                <h5 class="font-weight-bolder text-center"> 
                                    Maneja el control de informes desde este panel
                                </h5>
                            </div>
                            <div class="card-body  blue lighten-5">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xl-2 col-lg-2 hidden-md-2 hidden-sm-down mb-3"> 
                                        </div>
                                        <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-3">
                                            <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                                <div class="card-header amber accent-4">
                                                    <div class="row">
                                                        <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                            <h6 class="text-white font-weight-bold">
                                                                Informes aprobados
                                                            </h6>
                                                        </div>
                                                        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Visualizar informes">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <br>
                                                    <div class="view overlay">
                                                        <img 
                                                            class="card-img-top" 
                                                            src="../img/menu/informes-aprobados.svg" 
                                                            alt="visualizar informes aprobados">
                                                    </div>
                                                    <hr>
                                                    <button 
                                                        type="button"
                                                        class="btn btn-indigo btn-block"  
                                                        data-toggle="modal" 
                                                        data-target="#modalInformesAprobados">
                                                        Ver Informes Aprobados
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-3">
                                            <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                                <div class="card-header amber accent-4">
                                                    <div class="row">
                                                        <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                            <h6 class="text-white font-weight-bold">
                                                                Informes pendientes
                                                            </h6>
                                                        </div>
                                                        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <br>
                                                    <div class="view overlay">
                                                        <img 
                                                            class="card-img-top" 
                                                            src="../img/menu/informes-pendientes.svg" 
                                                            alt="control informes">
                                                    </div>
                                                    <hr>
                                                    <button 
                                                        type="button"
                                                        class="btn btn-indigo btn-block"  
                                                        data-toggle="modal" 
                                                        data-target="#modalInformesPendientes">
                                                            Ver Informes Pendientes
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-2 hidden-md-2 hidden-sm-down mb-3"> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer amber accent-4">

                            </div>
                        </div>
                    </div>
                </div>
            <?php 
                break; 
            ?>
            <?php case 
                'S_AC': // ROLE => Secretaria Academica
            ?>
                <div class="row mt-5">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header indigo darken-4 text-white">
                                <h5 class="font-weight-bolder text-center"> 
                                    Maneja el control de informes desde este panel
                                </h5>
                            </div>
                            <div class="card-body  blue lighten-5">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-xl-2 col-lg-2 hidden-md-2 hidden-sm-down mb-3"> 
                                        </div>
                                        <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-3">
                                            <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                                <div class="card-header amber accent-4">
                                                    <div class="row">
                                                        <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                            <h6 class="text-white font-weight-bold">
                                                                Informes aprobados
                                                            </h6>
                                                        </div>
                                                        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Visualizar informes">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <br>
                                                    <div class="view overlay">
                                                        <img 
                                                            class="card-img-top" 
                                                            src="../img/menu/informes-aprobados.svg" 
                                                            alt="visualizar informes aprobados">
                                                    </div>
                                                    <hr>
                                                    <button 
                                                        type="button"
                                                        class="btn btn-indigo btn-block"  
                                                        data-toggle="modal" 
                                                        data-target="#modalInformesAprobados">
                                                        Ver Informes Aprobados
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-3">
                                            <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                                <div class="card-header amber accent-4">
                                                    <div class="row">
                                                        <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                            <h6 class="text-white font-weight-bold">
                                                                Informes pendientes de enviar
                                                            </h6>
                                                        </div>
                                                        <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                            <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <br>
                                                    <div class="view overlay">
                                                        <img 
                                                            class="card-img-top" 
                                                            src="../img/menu/informes-pendientes.svg" 
                                                            alt="control informes">
                                                    </div>
                                                    <hr>
                                                    <button 
                                                        type="button"
                                                        class="btn btn-indigo btn-block"  
                                                        data-toggle="modal" 
                                                        data-target="#modalInformesPendientes">
                                                            Ver Informes pendientes de enviar
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xl-2 col-lg-2 hidden-md-2 hidden-sm-down mb-3"> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer amber accent-4">

                            </div>
                        </div>
                    </div>
                </div>
            <?php 
                break; 
            ?>
            <?php 
                case 'CD': // ROLE => Coordinador Departamento ESTA INFORMACION DEBE CARGARSE CON AJAX
            ?>
            <?php 
                break; 
            ?>
            <?php 
                case 'JD': // ROLE => Jefe Departamento Departamento ESTA INFORMACION DEBE CARGARSE CON AJAX
            ?>
            <?php 
                break; 
            ?>
            <?php endswitch; ?>
        </div>
        <!--En esta zona podran poner javascripts propios de la vista-->
<?php
    include('../partials/endDoctype.php');
?>