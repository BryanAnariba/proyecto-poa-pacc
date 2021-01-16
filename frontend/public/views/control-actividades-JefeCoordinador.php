<?php
    include('../partials/doctype.php');;
?>
<title>Control de actividades</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/Jefe-Coordinador/control-actividades.css">
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
                        <h5 class="font-weight-bolder"> Maneja el llenado de las dimensiones desde este panel</h5>
                    </div>
                    <div class="card-body  blue lighten-5">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Dimensiones Academicas Pendientes
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
                                                    src="../img/jefe-coordinador/pending_approval.svg" 
                                                    alt="visualizar carrera">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalLlenadoDimension"
                                                onclick="llenar('DimensionesTabla')">
                                                Ir
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3" id="mda">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Modidificar Actividades
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="view overlay">
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/jefe-coordinador/Reviewed_docs.svg" 
                                                    alt="registrar carrera">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalModificarDimension"
                                                onclick="llenar('DimensionesTablaModificar')">
                                                Ir
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12 mb-3" id="aga">
                                    <div class="card border border-warning b-2 rounded mb-0 animate__animated animate__flipInY">
                                        <div class="card-header amber accent-4">
                                            <div class="row">
                                                <div class="col-xl-9 col-lg-9 col-md-9 col-sm-8">
                                                    <h6 class="text-white font-weight-bold">
                                                        Agregar actividad
                                                    </h6>
                                                </div>
                                                <div class="col-xl-3 col-lg-3 col-md-3 col-sm-4">
                                                    <img src="../img/partial-sidebar/departamentos-icon.svg" alt="Control de Departamentos">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="view overlay">
                                                <img 
                                                    class="card-img-top" 
                                                    src="../img/jefe-coordinador/add_file.svg"  
                                                    alt="Modificar carrera">
                                            </div>
                                            <hr>
                                            <button 
                                                type="button"
                                                class="btn btn-indigo btn-block"  
                                                data-toggle="modal" 
                                                data-target="#modalAgregarActividades"
                                                onclick="llenar('DimensionesTablaAgregar')">
                                                Ir
                                            </button>
                                        </div>
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

                                                    <!--modales-->
    <!--llenado de dimensiones-->
    <div 
        class="modal fade" 
        id="modalLlenadoDimension" 
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
                <div class="modal-body table-responsive">
                    <table id="DimensionesTabla" class="table" cellspacing="0" width="100%">
                        <thead>
                            <tr align="center">
                                <th scope="col">Estado</th>
                                <th scope="col">Dimension Academica</th>
                                <th scope="col">Llenar dimension</th>
                            </tr>
                        </thead>
                    </table>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                </div>
            </div>
        </div>
    </div>

    <!--Modificar Actividades-->
    <div 
        class="modal fade" 
        id="modalModificarDimension" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Listado de dimensiones a modificar</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="ventana1">
                        <div class="table-responsive">
                            <table id="DimensionesTablaModificar" class="table" cellspacing="0" width="100%">
                                <thead>
                                    <tr align="center">
                                        <th scope="col">Estado</th>
                                        <th scope="col">Dimension Academica</th>
                                        <th scope="col">Llenar dimension</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <div id="ventana2">
                        <form class="text-center" style="color: #757575;" action="#!">
                            <div class="tabla">
                                <h4 align="center">Seleccione lista de actividades que desea editar:</h4>
                                <div class="form-row">
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Dimension academica:</label>
                                        <select id="dimAc" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                    <div id="ObjSelM"  class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Objetivo institucional:</label>
                                        <select id="ObIn" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Area estrategica:</label>
                                        <select id="ArEs" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Utilizado (Lps.):</div>
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                <input type="text" id="PresupuestoUtilizado2M" class="form-control" placeholder="10,000" readonly disable>
                                            </div>
                                        </div>
                                        <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Disponible (Lps.):</div>
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                <input type="text" id="PresupuestoDisponible2M" class="form-control" placeholder="10,000" readonly disable>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div style="color: #757575;" class="tabla">
                            <h4 align="center">Listado de actividades:</h4>
                            <div class="table-responsive">
                                <table id="DimensionesTablaModificar3" class="table" cellspacing="0" width="100%">
                                    <thead>
                                        <tr align="center">
                                            <th scope="col">Estado</th>
                                            <th scope="col">Dimension Academica</th>
                                            <th scope="col">Llenar dimension</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="ventana3">
                        <div class="container tabla">    
                            <form class="text-center" style="color: #757575;" action="#!">
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="md-form">
                                            <input type="text" id="ActividadsM" class="form-control">
                                            <span id="errorsActividadsM" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="ActividadsM"
                                                id="labelActividadsM"
                                            >
                                            Actividad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="CantidadM" class="form-control">
                                            <span id="errorsCantidadM" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="CantidadM"
                                                id="labelCantidadM"
                                            >
                                            Cantidad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="CostoM" class="form-control">
                                            <span id="errorsCostoM" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="CostoM"
                                                id="labelCostoM"
                                            >
                                            Costo
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-6 row">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="CostoMT" class="form-control" readonly disabled>
                                            <label 
                                                for="CostoMT"
                                                id="labelCostoMT"
                                            >
                                            Costo Total
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-left:auto">
                                        <label for="TipoPresupuestoM" id="labelTipoPresupuestoM">Tipo de presupuesto:</label>
                                        <select name="TipoPresupuestoM" id="TipoPresupuestoM" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsTipoPresupuestoM" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-right:auto">
                                        <label for="ObjGastoM" id="labelObjGastoM">Objeto de Gasto:</label>
                                        <select name="ObjGastoM" id="ObjGastoM" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsObjGastoM" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DescripcionCuentaM" class="form-control">
                                        <span id="errorsDescripcionCuentaM" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DescripcionCuentaM"
                                            id="labelDescripcionCuentaM"
                                        >
                                        Descripcion de la cuenta
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DimensionEstrategicaSM" class="form-control">
                                        <span id="errorsDimensionEstrategicaSM" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DimensionEstrategicaSM"
                                            id="labelDimensionEstrategicaSM"
                                        >
                                        Dimension Estrategica
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="MesM" class="form-control">
                                        <span id="errorsMesM" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="MesM"
                                            id="labelMesM"
                                        >
                                        Mes requerido
                                        </label>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center foot-modif">
                        <button id="botonModif" type="button" class="btn btn-light-green btn-rounded btn-sm" onclick="" disabled>Guardar Cambios</button>
                    </div>
                    <div class="text-center foot-modif">
                        <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--Agregar Actividades-->
    <div 
        class="modal fade" 
        id="modalAgregarActividades" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Seccion para agregar actividad</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="ventanaA" class="table-responsive">
                        <table id="DimensionesTablaAgregar" class="table" cellspacing="0" width="100%">
                            <thead>
                                <tr align="center">
                                    <th scope="col">Estado</th>
                                    <th scope="col">Dimension Academica</th>
                                    <th scope="col">Llenar dimension</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div id="ventana1A">
                        <form class="text-center" style="color: #757575;" action="#!">
                            <div class="tabla">
                                <h4 align="center">Seleccione lista de actividades que desea editar:</h4>
                                <div class="form-row">
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Dimension academica:</label>
                                        <select id="DimensionAc" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                    <div id="ObjSelAg"  class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Objetivo institucional:</label>
                                        <select id="ObjInstitucionalAg" class="browser-default custom-select mb-4" onchange="">

                                        </select>
                                    </div>
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Area estrategica:</label>
                                        <select id="AreaEAg" class="browser-default custom-select mb-4" onchange="">
        
                                        </select>
                                    </div>
                                    <div class="input-field col-xl-6 col-lg-6 col-md-6 col-sm-12">
                                        <label>Actividad:</label>
                                        <select id="Activ" class="browser-default custom-select mb-4" onchange="">
        
                                        </select>
                                    </div>
                                    <div class="container">
                                        <div class="row">
                                            <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Utilizado (Lps.):</div>
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                    <input type="text" id="PresupuestoUtilizado2Ag" class="form-control" placeholder="10,000" readonly disable>
                                                </div>
                                            </div>
                                            <div class="input col-xl-5 col-lg-5 col-md-5 col-sm-5 row" style="margin:auto">
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">Presupuesto Disponible (Lps.):</div>
                                                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                    <input type="text" id="PresupuestoDisponible2Ag" class="form-control" placeholder="10,000" readonly disable>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="tabla">
                                <h4 align="center">Actividad: Contrtatacion personal</h4>
                                <div class="form-row">
                                    <div class="col-12">
                                        <div class="md-form">
                                            <input type="text" id="ActividadsAg" class="form-control">
                                            <span id="errorsActividadsAg" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="ActividadsAg"
                                                id="labelActividadsAg"
                                            >
                                            Actividad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="CantidadAg" class="form-control">
                                            <span id="errorsCantidadAg" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="CantidadAg"
                                                id="labelCantidadAg"
                                            >
                                            Cantidad
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-3">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="CostoAg" class="form-control">
                                            <span id="errorsCostoAg" class="text-danger text-small d-none">
                                            </span>
                                            <label 
                                                for="CostoAg"
                                                id="labelCostoAg"
                                            >
                                            Costo
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-6 row">
                                        <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                            <input type="number" id="CostoAgT" class="form-control" readonly disabled>
                                            <label 
                                                for="CostoAgT"
                                                id="labelCostoAgT"
                                            >
                                            Costo Total
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-left:auto">
                                        <label for="TipoPresupuestoAg" id="labelTipoPresupuestoAg">Tipo de presupuesto:</label>
                                        <select name="TipoPresupuestoAg" id="TipoPresupuestoAg" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsTipoPresupuestoAg" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                    <div class="input-field col-xl-4 col-lg-4 col-md-4 col-sm-12" style="padding-left:0;margin-right:auto">
                                        <label for="ObjGastoAg" id="labelObjGastoAg">Objeto de Gasto:</label>
                                        <select name="ObjGastoAg" id="ObjGastoAg" class="browser-default custom-select mb-4">

                                        </select>
                                        <span id="errorsObjGastoAg" class="text-danger text-small d-none">
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DescripcionCuentaAg" class="form-control">
                                        <span id="errorsDescripcionCuentaAg" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DescripcionCuentaAg"
                                            id="labelDescripcionCuentaAg"
                                        >
                                        Descripcion de la cuenta
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="DimensionEstrategicaSAg" class="form-control">
                                        <span id="errorsDimensionEstrategicaSAg" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="DimensionEstrategicaSAg"
                                            id="labelDimensionEstrategicaSAg"
                                        >
                                        Dimension Estrategica
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="MesAg" class="form-control">
                                        <span id="errorsMesAg" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="MesAg"
                                            id="labelMesAg"
                                        >
                                        Mes requerido
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="text-center foot-agr">
                        <button id="botonModif" type="button" class="btn btn-light-green btn-rounded btn-sm" onclick="" disabled>Guardar Cambios</button>
                    </div>
                    <div class="text-center foot-agr">
                        <button type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--formulario llenado de dimension-->
    <div 
        class="modal fade" 
        id="modalFormLlenadoDimension" 
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
                <div class="modal-body table-responsive">
                    <form id="formulario-registro-dimension" class="text-center" style="color: #757575;">
                        <div class="form-row col-12" style="margin-left: auto;margin-right:auto">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                <div class="input-field col-12" style="padding-left:0" align="left">
                                    <label for="DimEstrategica" id="labelDimEstrategica">Dimension Estrategica Seleccionada:</label>
                                    <select name="DimEstrategica" id="DimEstrategica" class="browser-default custom-select mb-4">
                                    </select>
                                    <span id="errorsObjInstitucional" class="text-danger text-small d-none">
                                    </span>
                                </div>
                            </div>
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                <div class="input-field col-12" style="padding-left:0" align="left">
                                    <label for="ObjInstitucional" id="labelObjInstitucional">Objetivo Institucional:</label>
                                    <select name="ObjInstitucional" id="ObjInstitucional" class="browser-default custom-select mb-4">
                                        
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
                                    </select>
                                    <span id="errorsAreaEstrategica" class="text-danger text-small d-none">
                                    </span>
                                </div>
                            </div>
                            <div class="row col-12" style="margin-left:auto;margin-right:auto">
                                <div class="col-xl-4 col-lg-4 col-md-4 col-sm-12" style="margin-top:2px">
                                    <button 
                                        type="button"
                                        class="btn btn-indigo btn-block"  
                                        onclick="ag()">
                                        Agregar actividad
                                    </button>
                                </div>
                                <div class="col-xl-5 col-lg-5 col-md-5 col-sm-12" style="margin-left:auto;margin-top:2px">
                                    <button 
                                        type="button"
                                        class="btn btn-indigo btn-block"  
                                        data-toggle="modal" 
                                        data-target="#modalActividadesPlanificadas">
                                        Ver planificación
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
                </div>
                <div class="modal-footer card-footer amber accent-4">
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

    <!--Actividades planificadas-->
    <div 
        class="modal fade" 
        id="modalActividadesPlanificadas" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Dimensiones Academicas pendientes</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
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
                <div class="modal-footer card-footer amber accent-4">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Cerrar</button>
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
                                                <fieldset id="primero">
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
                                                            <div class="md-form">
                                                                <label for="ResultadosDeUnidad"id="labelResultadosDeUnidad">Resultados de la unidad:</label>
                                                                <textarea  type="text" id="ResultadosDeUnidad" class="md-textarea form-control"></textarea >
                                                                <span id="errorsResultadosDeUnidad" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <label for="Indicador"id="labelIndicador">Indicador:</label>
                                                                <textarea  type="text" id="Indicador" class="md-textarea form-control"></textarea >
                                                                <span id="errorsIndicador" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                    </div> 
                                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                                </fieldset>
                                                <fieldset id="segundo">
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
                                                <fieldset id="tercero">
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
                                                <fieldset id="cuarto">
                                                    <div class="form-card" >
                                                        <h2 class="fs-title">Justificacion</h2> 
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <label class="form-label" for="Justificacions"id="labelJustificacions">Justificacion:</label>    
                                                                <textarea  type="text" id="Justificacions" class="md-textarea form-control"></textarea >
                                                                <span id="errorsJustificacions" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div> 
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <label class="form-label" for="Medio"id="labelMedio">Medio de verificacion:</label>    
                                                                <textarea  type="text" id="Medio" class="md-textarea form-control"></textarea >
                                                                <span id="errorsMedio" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <label class="form-label" for="Poblacion"id="labelPoblacion">Poblacion Objetivo:</label>    
                                                                <textarea  type="text" id="Poblacion" class="md-textarea form-control"></textarea >
                                                                <span id="errorsPoblacion" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <label class="form-label" for="Responsable"id="labelResponsable">Responsable:</label>    
                                                                <textarea  type="text" id="Responsable" class="md-textarea form-control"></textarea >
                                                                <span id="errorsResponsable" class="text-danger text-small d-none"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" /> 
                                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                                </fieldset>
                                                <fieldset id="quinto">
                                                    <div class="form-card" >
                                                        <h2 class="fs-title">Actividade Especiales</h2> 
                                                        <div class="container row">
                                                            <div class="col-xl-4 col-lg-4 col-md-4 col-sm-4">
                                                                <button 
                                                                    type="button"
                                                                    class="btn btn-indigo btn-block"  
                                                                    id="bot">
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
                                                    <input id="save" type="button" name="save" class="action-button" value="Aceptar" />
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
                    <div class="text-center" id="foote-modal">
                        <button id="close" type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!--Agregar Actividad-->
<div
        class="modal fade" 
        id="modalActividad" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header indigo darken-4 text-white">
                    <h4 class="modal-title w-100" id="myModalLabel">Registro actividad</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container tabla">    
                        <form class="text-center" style="color: #757575;" action="#!">
                            <div class="form-row">
                                <div class="col-12">
                                    <div class="md-form">
                                        <input type="text" id="ActividadL" class="form-control">
                                        <span id="errorsActividadL" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="ActividadL"
                                            id="labelActividadL"
                                        >
                                        Actividad
                                        </label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                        <input type="number" id="Cantidad" class="form-control">
                                        <span id="errorsCantidad" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="Cantidad"
                                            id="labelCantidad"
                                        >
                                        Cantidad
                                        </label>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                        <input type="number" id="Costo" class="form-control">
                                        <span id="errorsCosto" class="text-danger text-small d-none">
                                        </span>
                                        <label 
                                            for="Costo"
                                            id="labelCosto"
                                        >
                                        Costo
                                        </label>
                                    </div>
                                </div>
                                <div class="col-6 row">
                                    <div class="md-form" style="width:50%; margin-left:auto;margin-right:auto;">
                                        <input type="number" id="CostoT" class="form-control" readonly disabled>
                                        <label 
                                            for="CostoT"
                                            id="labelCostoT"
                                        >
                                        Costo Total
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="input-field col-4" style="padding-left:0;margin-left:auto">
                                    <label for="TipoPresupuesto" id="labelTipoPresupuesto">Tipo de presupuesto:</label>
                                    <select name="TipoPresupuesto" id="TipoPresupuesto" class="browser-default custom-select mb-4">

                                    </select>
                                    <span id="errorsTipoPresupuesto" class="text-danger text-small d-none">
                                    </span>
                                </div>
                                <div class="input-field col-4" style="padding-left:0;margin-right:auto">
                                    <label for="ObjGasto" id="labelObjGasto">Objeto de Gasto:</label>
                                    <select name="ObjGasto" id="ObjGasto" class="browser-default custom-select mb-4">

                                    </select>
                                    <span id="errorsObjGasto" class="text-danger text-small d-none">
                                    </span>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="md-form">
                                    <input type="text" id="DescripcionCuenta" class="form-control">
                                    <span id="errorsDescripcionCuenta" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="DescripcionCuenta"
                                        id="labelDescripcionCuenta"
                                    >
                                    Descripcion de la cuenta
                                    </label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="md-form">
                                    <input type="text" id="DimensionEstrategicaS" class="form-control">
                                    <span id="errorsDimensionEstrategicaS" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="DimensionEstrategicaS"
                                        id="labelDimensionEstrategicaS"
                                    >
                                    Dimension Estrategica
                                    </label>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="md-form">
                                    <input type="date" id="Mes" class="form-control">
                                    <span id="errorsMes" class="text-danger text-small d-none">
                                    </span>
                                    <label 
                                        for="Mes"
                                        id="labelMes"
                                    >
                                    Mes requerido
                                    </label>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
                <div class="modal-footer card-footer amber accent-4">
                    <div class="row col-12">
                        <div class="text-center" style="margin-left:auto">
                            <button 
                                type="button" 
                                class="btn btn-light-green btn-rounded btn-sm"
                                id="ingresarAct">
                                Ingresar
                            </button>
                        </div>
                        <div class="text-center">
                            <button id="closeAct" type="button" class="btn btn-danger btn-rounded btn-sm" data-dismiss="modal" aria-label="Close">Cancelar</button>
                        </div>
                    </div>
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
    <script src="../js/validators/form-validator.js"></script>
    <script src="../js/Jefe-Coordinador/principal.js"></script>
    <script src="../js/Jefe-Coordinador/llenado.js"></script>

<?php
    include('../partials/endDoctype.php');
?>
