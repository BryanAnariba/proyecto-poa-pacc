<?php
    include('../partials/doctype.php');;
?>
<title>Control de actividades</title>
<!--En esta zona podran poner estilos propios de la vista-->

<link rel="stylesheet" href="../css/Jefe-Coordinador/control-actividades2.css">
<link rel="stylesheet" href="../css/Jefe-Coordinador/llenado.css">
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">

<link rel="stylesheet" href="../js/data-tables/datatables.min.css">
<link rel="stylesheet" href="../js/data-tables/DataTables/css/dataTables.bootstrap4.min.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css">


</head>

<body id="body-pd">
    <?php include('../layouts/Nabvar.php'); ?>
    <?php include('../layouts/Sidebar.php'); ?>
    
    <div id="profile-card" class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder">Formulario de registro de actividades</h5>
                    </div>
                    <div class="card-body table-responsive">
                        <form id="formulario-registro-dimension" class="text-center" style="color: #757575;">
                            <div class="form-row col-12" style="margin-left: auto;margin-right:auto">
                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                    <div class="input-field col-12" style="padding-left:0" align="left">
                                        <label for="ObjInstitucional" id="labelObjInstitucional">Objetivo Institucional:</label>
                                        <select name="ObjInstitucional" id="ObjInstitucional" class="browser-default custom-select mb-4">
                                            <option value="" selected disabled></option>
                                            <option value="1">Opcion</option>
                                            <option value="2">Opcion</option>
                                            <option value="3">Opcion</option>
                                        </select>
                                        <span id="errorsObjInstitucional" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                </div>
                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                    <div class="input-field col-12" style="padding-left:0" align="left">
                                        <label for="AreaEstrategica" id="labelAreaEstrategica">Area Estrategica:</label>
                                        <select name="AreaEstrategica" id="AreaEstrategica" class="browser-default custom-select mb-4">
                                            <option value="" selected disabled></option>
                                            <option value="1">Opcion</option>
                                            <option value="2">Opcion</option>
                                            <option value="3">Opcion</option>
                                        </select>
                                        <span id="errorsAreaEstrategica" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                </div>
                                <div class="row col-12" style="margin-left:auto;margin-right:auto">
                                    <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4">
                                        <button 
                                            type="button"
                                            class="btn btn-indigo btn-block"  
                                            onclick="ag()">
                                            Agregar actividad
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="container">
                            <div class="row">
                                <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row>
                                    <label for="PresupuestoUtilizado">Presupuesto Utilizado (Lps.):</label>
                                    <input style="width:50%" type="text" id="PresupuestoUtilizado" class="form-control" placeholder="10,000" readonly disable>
                                </div>
                                <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row>
                                    <label for="PresupuestoDisponible">Presupuesto Disponible (Lps.):</label>
                                    <input style="width:50%" type="text" id="PresupuestoDisponible" class="form-control" placeholder="10,000" readonly disable>
                                </div>
                            </div>
                        </div>
                        <div class="tabla table-responsive">
                            <table id="ActividadTabla" class="table" cellspacing="0" width="100%">
                                <thead>
                                    <tr align="center">
                                        <th scope="col">correlativo</th>
                                        <th scope="col">objetivo institucional</th>
                                        <th scope="col">area</th>
                                        <th scope="col">actividad</th>
                                        <th scope="col">monto</th>
                                        <th scope="col">responsable</th>
                                        <th scope="col"># actividades</th>
                                        <th scope="col">accion</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer amber accent-4">
                        <div class="row col-12">
                            <div class="text-center" style="margin-left:auto">
                                <button 
                                    type="button" 
                                    class="btn btn-light-green btn-rounded btn-sm"
                                    disabled>
                                    Enviar
                                </button>
                            </div>
                            <div class="text-center">
                                <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

                                                    <!--modales-->
    <!--llenado de actividades-->
    <div 
        class="modal fade" 
        id="modalLlenadoActividades" 
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
                <div class="modal-body">
                    <div class="container-fluid" id="grad1">
                        <div class="row justify-content-center mt-0">
                            <div class="col-12 col-sm-12 col-md-12 col-lg-12 text-center p-0 mt-3 mb-2">
                                <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                                    <h2><strong>Formulario para registro actividades</strong></h2>
                                    <div class="row">
                                        <div class="col-md-12 mx-0">
                                            <form id="msform">
                                                <!-- progressbar -->
                                                <ul id="progressbar">
                                                    <li class="active" id="Resultados" ><strong>Resultados</strong></li>
                                                    <li id="Actividad"><strong>Actividad</strong></li>
                                                    <li id="MetasTrimestrales"><strong>Metas Trimestrales</strong></li>
                                                    <li id="Justificacion"><strong>Justificacion</strong></li>
                                                    <li id="ActividadeEspeciales"><strong>Actividade Especiales</strong></li>
                                                </ul> <!-- fieldsets -->
                                                <fieldset >
                                                    <div class="form-card" >
                                                        <h2 class="fs-title">Resultados</h2> 
                                                        <div class="col-12">
                                                            <div class="input-field">
                                                                <label for="ResultadosInstitucional" id="labelResultadosInstitucional">Resultados Institucionales:</label>
                                                                <select name="ResultadosInstitucional" id="ResultadosInstitucional" class="browser-default custom-select mb-4">
                                                                    <option value="" selected disabled></option>
                                                                    <option value="1">Opcion</option>
                                                                    <option value="2">Opcion</option>
                                                                </select>
                                                                <span id="errorsResultadosInstitucional" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div> 
                                                        <div class="col-12">
                                                            <div class="input-field">
                                                                <label for="ResultadosDeUnidad"id="labelResultadosDeUnidad">Resultados de la unidad:</label>
                                                                <textarea  type="text" id="ResultadosDeUnidad" class="form-control"></textarea >
                                                                <span id="errorsResultadosDeUnidad" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="input-field">
                                                                <label for="Indicador"id="labelIndicador">Indicador:</label>
                                                                <textarea  type="text" id="Indicador" class="form-control"></textarea >
                                                                <span id="errorsIndicador" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                    </div> 
                                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                                </fieldset>
                                                <fieldset>
                                                    <div class="form-card">
                                                        <h2 class="fs-title">Actividad</h2> 
                                                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                                            <div class="row" style="margin:auto">
                                                                <label for="Correlativo">Correlativo</label>
                                                                <div class="col-xl-4 col-lg-4 col-md-7 col-sm-8">
                                                                    <input type="text" id="Correlativo" class="form-control" readonly disabled>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="Actividads" class="form-control">
                                                                <span id="errorsActividads" class="text-danger text-small d-none"></span>
                                                                <label for="Actividads"id="labelActividads">Actividad</label>
                                                            </div>
                                                        </div>
                                                    </div> 
                                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" /> 
                                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                                </fieldset>
                                                <fieldset>
                                                    <div class="form-card">
                                                        <h2 class="fs-title">Metas trimestrales</h2>
                                                        <div class="row">
                                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="container">
                                                                        <label for="PTrimestre">Primer Trimestre:</label>
                                                                        <div id="PTrimestre" class="row">
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="PorcentPTrimestre" class="form-control">
                                                                                <span id="errorsPorcentPTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="PorcentPTrimestre"
                                                                                    id="labelPorcentPTrimestre"
                                                                                >
                                                                                %
                                                                                </label>
                                                                            </div>
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="MontoPTrimestre" class="form-control">
                                                                                <span id="errorsMontoPTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="MontoPTrimestre"
                                                                                    id="labelMontoPTrimestre"
                                                                                >
                                                                                Lps.
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="container">
                                                                        <label for="STrimestre">Segundo Trimestre:</label>
                                                                        <div id="STrimestre" class="row">
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="PorcentSTrimestre" class="form-control">
                                                                                <span id="errorsPorcentSTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="PorcentSTrimestre"
                                                                                    id="labelPorcentSTrimestre"
                                                                                >
                                                                                %
                                                                                </label>
                                                                            </div>
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="MontoSTrimestre" class="form-control">
                                                                                <span id="errorsMontoSTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="MontoSTrimestre"
                                                                                    id="labelMontoSTrimestre"
                                                                                >
                                                                                Lps.
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="container">
                                                                        <label for="TTrimestre">Tercer Trimestre:</label>
                                                                        <div id="TTrimestre" class="row">
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="PorcentTTrimestre" class="form-control">
                                                                                <span id="errorsPorcentTTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="PorcentTTrimestre"
                                                                                    id="labelPorcentTTrimestre"
                                                                                >
                                                                                %
                                                                                </label>
                                                                            </div>
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="MontoTTrimestre" class="form-control">
                                                                                <span id="errorsMontoTTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="MontoTTrimestre"
                                                                                    id="labelMontoTTrimestre"
                                                                                >
                                                                                Lps.
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="container">
                                                                        <label for="CTrimestre">Cuarto Trimestre:</label>
                                                                        <div id="CTrimestre" class="row">
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="PorcentCTrimestre" class="form-control">
                                                                                <span id="errorsPorcentCTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="PorcentCTrimestre"
                                                                                    id="labelPorcentCTrimestre"
                                                                                >
                                                                                %
                                                                                </label>
                                                                            </div>
                                                                            <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                                                <input type="number" id="MontoCTrimestre" class="form-control">
                                                                                <span id="errorsMontoCTrimestre" class="text-danger text-small d-none">
                                                                                </span>
                                                                                <label 
                                                                                    for="MontoCTrimestre"
                                                                                    id="labelMontoCTrimestre"
                                                                                >
                                                                                Lps.
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                                                    <div class="container input tabla" style="margin-top:1rem;border: 1px solid rgba(11, 3, 126, 0.13);">
                                                                        <table id="TablaTotal" class="table" cellspacing="0" width="100%">
                                                                            <thead>
                                                                                <tr align="center">
                                                                                    <th scope="col">Total(%)</th>
                                                                                    <th scope="col">Monto total</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <tr align="center">
                                                                                    <td>100</td>
                                                                                    <td>400</td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div> 
                                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" /> 
                                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                                </fieldset>
                                                <fieldset>
                                                    <div class="form-card" >
                                                        <h2 class="fs-title">Justificacion</h2> 
                                                        <div class="col-12">
                                                            <div class="form-outline">
                                                                <label class="form-label" for="Justificacions"id="labelJustificacions">Justificacion:</label>    
                                                                <textarea  type="text" id="Justificacions" class="form-control"></textarea >
                                                                <span id="errorsJustificacions" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div> 
                                                        <div class="col-12">
                                                            <div class="form-outline">
                                                                <label class="form-label" for="Medio"id="labelMedio">Medio de verificacion:</label>    
                                                                <textarea  type="text" id="Medio" class="form-control"></textarea >
                                                                <span id="errorsMedio" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="form-outline">
                                                                <label class="form-label" for="Poblacion"id="labelPoblacion">Poblacion Objetivo:</label>    
                                                                <textarea  type="text" id="Poblacion" class="form-control"></textarea >
                                                                <span id="errorsPoblacion" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="form-outline">
                                                                <label class="form-label" for="Responsable"id="labelResponsable">Responsable:</label>    
                                                                <textarea  type="text" id="Responsable" class="form-control"></textarea >
                                                                <span id="errorsResponsable" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" /> 
                                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                                </fieldset>
                                                <fieldset>
                                                    <div class="form-card" >
                                                        <h2 class="fs-title">Actividade Especiales</h2> 
                                                        <div class="container row">
                                                            <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4">
                                                                <button 
                                                                    type="button"
                                                                    class="btn btn-indigo btn-block"  
                                                                    onclick="agregarAct()">
                                                                    Agregar
                                                                </button>
                                                            </div>
                                                            <div class="col-xl-8 col-lg-8 col-md-8 col-sm-8">
                                                                
                                                            </div>
                                                        </div>
                                                        <div class="tabla table-responsive">
                                                            <table id="Actividades" class="table" cellspacing="0" width="100%">
                                                                <thead>
                                                                    <tr align="center">
                                                                        <th scope="col">Actividad</th>
                                                                        <th scope="col">cantidad</th>
                                                                        <th scope="col">costo</th>
                                                                        <th scope="col">costo total</th>
                                                                        <th scope="col">tipo de presupuesto</th>
                                                                        <th scope="col">objeto de gasto</th>
                                                                        <th scope="col">descripcion de la cuenta</th>
                                                                        <th scope="col">dimension estrategica</th>
                                                                        <th scope="col">mes requerido</th>
                                                                        <th scope="col">ver mas</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr align="center">
                                                                        <td>100</td>
                                                                        <td>400</td>
                                                                        <td>100</td>
                                                                        <td>400</td>
                                                                        <td>100</td>
                                                                        <td>400</td>
                                                                        <td>100</td>
                                                                        <td>400</td>
                                                                        <td>100</td>
                                                                        <td>
                                                                            <button type="button" class="btn btn-amber">
                                                                                <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                                                            </button>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" /> 
                                                    <input type="button" name="next" class="action-button" value="Continue" />
                                                </fieldset>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                </div>
            </div>
        </div>
    </div>

    <!--Modificar Actividades-->
    <div 
        class="modal fade" 
        id="modalModificarActividades" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Modificar Actividad</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    
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
    <script src="../js/data-tables/Buttons/js/buttons.html5.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    
    <script src="../js/config/config.js"></script>
    <script src="../js/validators/form-validator.js"></script>
    <script src="../js/Jefe-Coordinador/llenado.js"></script>

<?php
    include('../partials/endDoctype.php');
?>
