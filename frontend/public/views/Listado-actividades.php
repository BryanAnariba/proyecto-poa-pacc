<?php
    include('../partials/doctype.php');;
?>
<title>Control de actividades</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">
<script src="../js/libreria-bootstrap-mdb/jquery.min.js" type="text/javascript"></script>   

<link rel="stylesheet" href="../js/data-tables/datatables.min.css">
<link rel="stylesheet" href="../js/data-tables/DataTables/css/dataTables.bootstrap4.min.css">

<link href='../css/calendario-actividades/calendario.css' rel='stylesheet'>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css">

</head>

<body id="body-pd">
    <?php include('../layouts/Nabvar.php'); ?>
    <?php include('../layouts/Sidebar.php'); ?>
    
    <div id="profile-card" class="container">
        <div class="text-center mt-4">
            <button 
                type="button" 
                class="btn btn-light-green btn-rounded" 
                data-toggle="modal"                        
            >

                Listado de actividades consolidado
            </button>       
            <button 
                type="button" 
                class="btn btn-light-green btn-rounded" 
                data-toggle="modal" 
                data-target="#modalSeleccionDepart"
            >                     
                Listado de actividades por departamento
            </button>
            <button 
                type="button" 
                class="btn btn-light-green btn-rounded" 
                onclick= " location.href='Calendario-actividades.php' "
            >                     
                Ver calendario de actividades
            </button>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder">Listado de actividades</h5>
                    </div>
                    <div class="card-body  blue lighten-5">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="modal-body table-responsive tabla">
                                    <table id="ActividadesListado" class="table" cellspacing="0" width="100%">
                                        <thead>
                                            <tr align="center">
                                                <th scope="col">#</th>
                                                <th scope="col">Correlativo</th>
                                                <th scope="col">Departamento</th>
                                                <th scope="col">Dimension Estrategica</th>
                                                <th scope="col">Objetivo Institucional</th>
                                                <th scope="col">Area Estrategica</th>
                                                <th scope="col">Tema Actividad</th>
                                                <th scope="col">Numero de Actividades definidas</th>
                                                <th scope="col">Resultados</th>
                                                <th scope="col">Justificacion</th>
                                                <th scope="col">Presupuesto por trimestre</th>
                                                <th scope="col">ver actidades</th>
                                            </tr>
                                        </thead>
                                    </table>
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

                                                    <!--modales-->
    <!--Seleccion de departamento-->
    <div 
        class="modal fade" 
        id="modalSeleccionDepart" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Dimensiones Academicas pendientes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div>
                    <form class="text-center" style="color: #757575;" action="#!">
                        <div class="container" style="margin:20px">
                            <h4 align="center">Seleccione departamento a visualizar:</h4>
                            <div class="form-row container">
                                <div class="input-field col-12" align="left">
                                    <label>Seleccione un Departamento:</label>
                                    <select id="Departamento3" class="browser-default custom-select mb-4" onchange="">

                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center">
                        <button 
                            type="button" 
                            class="btn btn-light-green btn-rounded btn-sm" 
                        >
                            Visualizar actividades
                        </button>
                    </div>
                    <div class="text-center">
                        <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Visualizacion de -->
    <div 
        class="modal fade" 
        id="" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true"
    >
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div>
                    
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    
                </div>
            </div>
        </div>
    </div>

    <!--En esta zona podran poner javascripts propios de la vista-->
    
    <script src="../js/sweet-alert-two/sweetalert2.min.js"></script>
    <script src="../js/libreria-bootstrap-mdb/jquery.min.js"></script>
    
    <script src="../js/data-tables/datatables.min.js"></script>

    <script src="../js/data-tables/Buttons/js/dataTables.buttons.min.js"></script>
    <script src="../js/data-tables/JSZip/jszip.min.js"></script>
    <script src="../js/data-tables/pdfmake/pdfmake.min.js"></script>
    <script src="../js/data-tables/pdfmake/vfs_fonts.js"></script>
    <script src="../js/data-tables/Buttons/js/buttons.html5.min.js"></script>


    <script src="../js/config/config.js"></script>
    <script src="../js/Calendario-actividades/Listado-actividades2.js"></script>

<?php
    include('../partials/endDoctype.php');
?>
