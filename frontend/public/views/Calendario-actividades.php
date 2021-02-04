<?php
    include('../partials/doctype.php');;
?>
<title>Control de actividades</title>
<!--En esta zona podran poner estilos propios de la vista-->
<link rel="stylesheet" href="../css/sweet-alert-two/sweetalert2.min.css">

<link href='../css/calendar/fullcalendar4.css' rel='stylesheet'>
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

                Calendario de actividades consolidado
            </button>       
            <button 
                type="button" 
                class="btn btn-light-green btn-rounded" 
                data-toggle="modal" 
                data-target="#modalSeleccionDepart"
            >                     
                Calendario de actividades por departamento
            </button>
            <button 
                type="button" 
                class="btn btn-light-green btn-rounded" 
                onclick= " location.href='Listado-actividades.php' "
            >                     
                Ver listado de actividades
            </button>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header indigo darken-4 text-white">
                        <h5 class="font-weight-bolder">Calendario de actividades</h5>
                    </div>
                    <div class="card-body  blue lighten-5">
                        <div id="calendar" class="col-md-12 tabla"></div>
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

    <!--Visualizacion de actividades-->
    <div 
        class="modal fade" 
        id="modalSeleccionDepart" 
        tabindex="-1" role="dialog" 
        aria-labelledby="myModalLabel" 
        aria-hidden="true"
    >
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
                                    <select id="Departamento2" class="browser-default custom-select mb-4" onchange="">

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

    <!--modal al presionar body de la fecha-->
    <div class="modal fade" id="ModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
			<form class="form-horizontal">
			
			  <div class="modal-header indigo darken-4 text-white">
                <h4 class="modal-title" id="myModalLabel">Actividades correspondientes a la fecha</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  </div>
			  <div class="modal-body">
                    <form class="text-center" style="color: #757575;" action="#!">
                        <div class="container">
                            <div class="form-row container">
                                <div class="input-field mx-auto tabla align-self-center text-center">
                                    <select id="actividadFecha" class="browser-default custom-select" onchange="cambioAct()">
                                        <option value="" selected disabled>Seleccione la actividad:</option>
                                    </select>
                                </div>
                            </div>
                            <div class="container tabla" style="display:none">
                                <h4 align="center">Información de la actividad:</h4>
                                <div class=" container mx-auto row">
                                    <div class="row col-xl-5 col-lg-5 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                                        <div 
                                            class="
                                                col-xl-4 
                                                col-lg-4 
                                                col-md-4 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                        >
                                            Departamento:
                                        </div>
                                        <div 
                                            class="
                                                col-xl-8 
                                                col-lg-8 
                                                col-md-8 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                            style="border-bottom:1px solid black"
                                        >
                                            Ingenieria en Sistemas
                                        </div>
                                    </div>
                                    <div class="row col-xl-5 col-lg-5 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                                        <div class="tabla mx-auto">
                                            <div 
                                                class="
                                                    col-xl-4 
                                                    col-lg-4 
                                                    col-md-4 
                                                    col-sm-12 
                                                    col-xs-12 
                                                    align-self-center 
                                                    text-center" 
                                            >
                                                Cantidad:
                                            </div>
                                            <div 
                                                class="
                                                    col-xl-8 
                                                    col-lg-8 
                                                    col-md-8 
                                                    col-sm-12 
                                                    col-xs-12 
                                                    align-self-center 
                                                    text-center" 
                                                style="border-bottom:1px solid black"
                                            >
                                                3
                                            </div>
                                        </div>
                                        <div class="tabla mx-auto">
                                            <div 
                                                class="
                                                    col-xl-4 
                                                    col-lg-4 
                                                    col-md-4 
                                                    col-sm-12 
                                                    col-xs-12 
                                                    align-self-center 
                                                    text-center" 
                                            >
                                                Presupuesto <br> asignado:
                                            </div>
                                            <div 
                                                class="
                                                    col-xl-8 
                                                    col-lg-8 
                                                    col-md-8 
                                                    col-sm-12 
                                                    col-xs-12 
                                                    align-self-center 
                                                    text-center" 
                                                style="border-bottom:1px solid black"
                                            >
                                                10,000
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class=" container mx-auto row">
                                    <div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                                        <div 
                                            class="
                                                col-xl-4 
                                                col-lg-4 
                                                col-md-4 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                        >
                                            Actividad:
                                        </div>
                                        <div 
                                            class="
                                                col-xl-8 
                                                col-lg-8 
                                                col-md-8 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                            style="border-bottom:1px solid black"
                                        >
                                            Viáticos Nacionales Categoría III Zona 1 Periodo Corto
                                        </div>
                                    </div>
                                    <div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                                        <div 
                                            class="
                                                col-xl-4 
                                                col-lg-4 
                                                col-md-4 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                        >
                                            Justificacion:
                                        </div>
                                        <div 
                                            class="
                                                col-xl-8 
                                                col-lg-8 
                                                col-md-8 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                            style="border-bottom:1px solid black"
                                        >
                                            N.R.
                                        </div>
                                    </div>
                                    <div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                                        <div 
                                            class="
                                                col-xl-4 
                                                col-lg-4 
                                                col-md-4 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                        >
                                            Responsable:
                                        </div>
                                        <div 
                                            class="
                                                col-xl-8 
                                                col-lg-8 
                                                col-md-8 
                                                col-sm-12 
                                                col-xs-12 
                                                align-self-center 
                                                text-center" 
                                            style="border-bottom:1px solid black"
                                        >
                                            Subcomisión de Rediseño Curricular
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
			  </div>
			  <div class="modal-footer card-footer amber accent-4">
			  </div>
			</form>
			</div>
		  </div>
	</div>

    <div class="modal fade" id="ModalEdit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
			<form class="form-horizontal" method="POST" action="editEventTitle.php">
			  <div class="modal-header indigo darken-4 text-white">
                <h4 class="modal-title" id="myModalLabel">Modificar Evento</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  </div>
			  <div class="modal-body">
              <div class="container tabla">
                  <h4 align="center">Información de la actividad:</h4>
                  <div class=" container mx-auto row">
                      <div class="row col-xl-5 col-lg-5 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                          <div 
                              class="
                                  col-xl-4 
                                  col-lg-4 
                                  col-md-4 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                          >
                              Departamento:
                          </div>
                          <div 
                              class="
                                  col-xl-8 
                                  col-lg-8 
                                  col-md-8 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                              style="border-bottom:1px solid black"
                          >
                              Ingenieria en Sistemas
                          </div>
                      </div>
                      <div class="row col-xl-5 col-lg-5 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                          <div class="tabla mx-auto">
                              <div 
                                  class="
                                      col-xl-4 
                                      col-lg-4 
                                      col-md-4 
                                      col-sm-12 
                                      col-xs-12 
                                      align-self-center 
                                      text-center" 
                              >
                                  Cantidad:
                              </div>
                              <div 
                                  class="
                                      col-xl-8 
                                      col-lg-8 
                                      col-md-8 
                                      col-sm-12 
                                      col-xs-12 
                                      align-self-center 
                                      text-center" 
                                  style="border-bottom:1px solid black"
                              >
                                  3
                              </div>
                          </div>
                          <div class="tabla mx-auto">
                              <div 
                                  class="
                                      col-xl-4 
                                      col-lg-4 
                                      col-md-4 
                                      col-sm-12 
                                      col-xs-12 
                                      align-self-center 
                                      text-center" 
                              >
                                  Presupuesto <br> asignado:
                              </div>
                              <div 
                                  class="
                                      col-xl-8 
                                      col-lg-8 
                                      col-md-8 
                                      col-sm-12 
                                      col-xs-12 
                                      align-self-center 
                                      text-center" 
                                  style="border-bottom:1px solid black"
                              >
                                  10,000
                              </div>
                          </div>
                      </div>
                  </div>
                  <div class=" container mx-auto row">
                      <div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                          <div 
                              class="
                                  col-xl-4 
                                  col-lg-4 
                                  col-md-4 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                          >
                              Actividad:
                          </div>
                          <div 
                              class="
                                  col-xl-8 
                                  col-lg-8 
                                  col-md-8 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                              style="border-bottom:1px solid black"
                          >
                              Viáticos Nacionales Categoría III Zona 1 Periodo Corto
                          </div>
                      </div>
                      <div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                          <div 
                              class="
                                  col-xl-4 
                                  col-lg-4 
                                  col-md-4 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                          >
                              Justificacion:
                          </div>
                          <div 
                              class="
                                  col-xl-8 
                                  col-lg-8 
                                  col-md-8 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                              style="border-bottom:1px solid black"
                          >
                              N.R.
                          </div>
                      </div>
                      <div class="row col-xl-12 col-lg-12 col-md-12 col-sm-12 col-xs-12 tabla mx-auto">
                          <div 
                              class="
                                  col-xl-4 
                                  col-lg-4 
                                  col-md-4 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                          >
                              Responsable:
                          </div>
                          <div 
                              class="
                                  col-xl-8 
                                  col-lg-8 
                                  col-md-8 
                                  col-sm-12 
                                  col-xs-12 
                                  align-self-center 
                                  text-center" 
                              style="border-bottom:1px solid black"
                          >
                              Subcomisión de Rediseño Curricular
                          </div>
                      </div>
                  </div>
              </div>
			  </div>
			  <div class="modal-footer card-footer amber accent-4">
			  </div>
			</form>
			</div>
		  </div>
		</div>
    <!--En esta zona podran poner javascripts propios de la vista-->
    
    <script src="../js/sweet-alert-two/sweetalert2.min.js"></script>
    <script src="../js/libreria-bootstrap-mdb/jquery.min.js"></script>
    <script src='../js/jquery.js'></script>

    <!-- FullCalendar -->
	<script src='../js/moment.min.js'></script>
	<script src='../js/fullcalendar/fullcalendar.min.js'></script>
	<script src='../js/fullcalendar/fullcalendar.js'></script>
	<script src='../js/fullcalendar/locale/es.js'></script>


    <script src="../js/config/config.js"></script>
    <script src="../js/validators/form-validator.js"></script>
    <script src="../js/Calendario-actividades/Calendario-actividades6.js"></script>
    <script src="../js/Calendario-actividades/Calendario2.js"></script>
<?php
    include('../partials/endDoctype.php');
?>
