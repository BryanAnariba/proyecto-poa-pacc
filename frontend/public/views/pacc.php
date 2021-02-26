<?php
session_start();
if (!isset($_SESSION['correoInstitucional'])) {
    header('Location: 401.php');
}
$superAdmin = 'S_AC';
if ($_SESSION['abrevTipoUsuario'] != $superAdmin) {
    header('Location: 401.php');
}
include('../partials/doctype.php');
//include('verifica-session.php');
?>
<title>Gestion PACC</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">


<link rel="stylesheet" href="https:use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
<link rel="stylesheet" href="../js/chartjs/css/Chart.css" />
<link rel="stylesheet" href="../js/chartjs/css/Chart.min.css" />

<link rel="stylesheet" href="../css/libreria-bootstrap-mdb/select2.min.css">

<script src="../js/chartjs/Chart.bundle.js"></script>
<script src="../js/chartjs/Chart.min.js"></script>
<script src="../js/chartjs/Chart.js"></script>
</head>

<body id="body-pd">
    <?php include('../layouts/Nabvar.php'); ?>
    <?php include('../layouts/Sidebar.php'); ?>

    <div id="profile-card" class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder">Control y Reporteria PACC</h5>
                    </div>
                    <div class="card-body blue lighten-5">
                        <div class="container-fluid">
                            <div class="row mt-2">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="display-5 text-center">
                                                Opciones para generar reporte pacc
                                            </h5>
                                        </div>
                                        <div class="card-body row">
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 mx-auto">
                                                <div class="text-center mt-4">
                                                    <button type="button" class="btn btn-light-green btn-rounded" data-toggle="modal" onclick="abrirModalReporteGeneral()">
                                                        <img src="../img/partial-sidebar/agregar-icon.svg" alt="">
                                                        Reporte Excel pacc General
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 mx-auto">
                                                <div class="text-center mt-4">
                                                    <button type="button" class="btn btn-light-green btn-rounded" data-toggle="modal" data-target="#modalRegistroDimension">
                                                        <img src="../img/partial-sidebar/agregar-icon.svg" alt="">
                                                        Reporte Excel por departamento
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-2">
                                <div class="col-12">
                                    <div class="card bg-primary mb-3 border-primary" style="max-width: 100%">
                                        <div class="card-header text-center text-white">Grafica de distribucion de presupuesto por departamentos</div>
                                        <div class="card-body bg-white">
                                            <canvas id="grafica-presupuestos-departamentos" width="400">

                                            </canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row card-body bg-white">
                                <div class="col-xl-3 col-lg-3 col-md-3 hidden-col-sm">
                                </div>
                                <div class="col-6">
                                    <div class="md-form">
                                        <input type="text" id="fechaPresupuesto" class="form-control" disabled />
                                        <label class="form-label" for="fechaPresupuesto">Año Presupuesto Abierto</label>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-lg-3 col-md-3 hidden-col-sm">
                                </div>
                                <div class="col-6">
                                    <div class="md-form">
                                        <input type="text" id="presupuestoAnual" class="form-control" disabled />
                                        <label class="form-label" for="presupuestoAnual">Presupuesto Anual Total</label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="md-form">
                                        <input type="text" id="presupuestoUtilizado" class="form-control" disabled />
                                        <label class="form-label" for="presupuestoUtilizado">Presupuesto Anual Utilizado</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer amber accent-4">

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalGeneraPaccGeneral" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Opciones para generar reporte</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="formulario-registro-dimension" class="text-center" style="color: #757575;">
                        <div class="md-form">
                            <select class="browser-default custom-select" id="FechaPresupuesto" required>
                            </select>
                        <span id="errorsFechaPresupuesto" class="text-danger text-small d-none">
                        </span>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <div class="text-center mt-4">
                        <button id="btn-registrar-dimension" type="button" class="btn btn-light-green btn-rounded" onclick="generarReporteGeneralPACC()">Generar Reporte</button>
                    </div>
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-danger btn-rounded" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/sweet-alert-two/sweetalert2.min.js"></script>
    <script src="../js/libreria-bootstrap-mdb/jquery.min.js"></script>

    <script src="../js/libreria-bootstrap-mdb/select2.min.js"></script>
    <script src="../js/config/config.js"></script>
    <script src="../js/validators/form-validator.js"></script>
    <script src="../js/pacc/controlador-pacc.js"></script>

    
    <?php
    include('../partials/endDoctype.php');
    ?>