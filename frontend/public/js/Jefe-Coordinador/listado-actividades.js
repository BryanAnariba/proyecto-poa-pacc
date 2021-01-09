var arreglo = [
    {Correlativo: "IS-2021-1-1", 
    DimensionEstrategica:"Extracurricular",
    ObjetivoInstitucional:"Extra",
    AreaEstrategica:"Curricular",
    TemaActividad:"ContratarPersonal",
    NumeroDeActividadesDefinidas:3},
    {Correlativo: "IS-2021-1-1", 
    DimensionEstrategica:"Extracurricular",
    ObjetivoInstitucional:"Extra",
    AreaEstrategica:"Curricular",
    TemaActividad:"ContratarPersonal",
    NumeroDeActividadesDefinidas:3}];

$(document).ready(function (){
    TablaInicio();
});

const TablaInicio = () => {
    $('#ObjetosTodas').dataTable().fnDestroy();
    $('#ObjetosTodas tbody').html(``);
    
    for (let i=0;i<arreglo.length; i++) {
        $('#ObjetosTodas tbody').append(`
            <tr align="center">
                <td scope="row">${ i + 1 }</td>
                <td>${ arreglo[i].Correlativo }</td>
                <td>${ arreglo[i].DimensionEstrategica }</td>
                <td>${ arreglo[i].ObjetivoInstitucional }</td>
                <td>${ arreglo[i].AreaEstrategica }</td>
                <td>${ arreglo[i].TemaActividad }</td>
                <td>${ arreglo[i].NumeroDeActividadesDefinidas }</td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('resultado')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('justificacion')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('presupuesto')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('actividades')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
            </tr>
        `)
    }
    $('#ObjetosTodas').DataTable({
        language: i18nEspaniol,
        //dom: 'Blfrtip',
        //buttons: botonesExportacion,
        retrieve: true
    });
};
const llenar = (vista) =>{
    switch(vista) {
        case 'resultado':
            $('#modalRegistosNoT').modal('show');
            $('.espacioLL').html(`<form class="text-center" style="color: #757575;" action="#!">
                                                    <div align="center"><h4>Resultados de la unidad</h4></div>
                                                    <div class="form-row">
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="correlativo" class="form-control" maxlength="80" readonly disabled>
                                                                </span>
                                                                <label 
                                                                    for="correlativo"
                                                                    id="labelcorrelativo"
                                                                >
                                                                correlativo
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="ResultadosU" class="form-control" maxlength="80" readonly disabled>
                                                                </span>
                                                                <label 
                                                                    for="ResultadosU"
                                                                    id="labelResultadosU"
                                                                >
                                                                Resultados de la unidad
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="Indicado" class="form-control" maxlength="80" readonly disabled>
                                                                </span>
                                                                <label 
                                                                    for="Indicado"
                                                                    id="labelIndicado"
                                                                >
                                                                Indicador de resultados
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>`);
            $("#correlativo").val(arreglo[0].Correlativo).trigger("change");
            $("#ResultadosU").val(arreglo[0].DimensionEstrategica).trigger("change");
            $("#Indicado").val(arreglo[0].DimensionEstrategica).trigger("change");
          break;
        case 'justificacion':
            $('#modalRegistosNoT').modal('show');
            $('.espacioLL').html(`<form class="text-center" style="color: #757575;" action="#!">
                                                    <div align="center"><h4>Justificacion</h4></div>
                                                    <div class="form-row">
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="Justificacion" class="form-control" maxlength="80" readonly disabled>
                                                                </span>
                                                                <label 
                                                                    for="Justificacion"
                                                                    id="labelJustificacion"
                                                                >
                                                                Justificacion
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="MediosdeV" class="form-control" maxlength="80" readonly disabled>
                                                                </span>
                                                                <label 
                                                                    for="MediosdeV"
                                                                    id="labelMediosdeV"
                                                                >
                                                                Medios de verificacion
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="PoblacionObjetivo" class="form-control" maxlength="80" readonly disabled>
                                                                </span>
                                                                <label 
                                                                    for="PoblacionObjetivo"
                                                                    id="labelPoblacionObjetivo"
                                                                >
                                                                Poblacion Objetivo
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="col-12">
                                                            <div class="md-form">
                                                                <input type="text" id="Responsable" class="form-control" maxlength="80" readonly disabled>
                                                                </span>
                                                                <label 
                                                                    for="Responsable"
                                                                    id="labelResponsable"
                                                                >
                                                                Responsable
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>`);
            $("#Justificacion").val(arreglo[0].Correlativo).trigger("change");
            $("#MediosdeV").val(arreglo[0].DimensionEstrategica).trigger("change");
            $("#PoblacionObjetivo").val(arreglo[0].ObjetivoInstitucional).trigger("change");
            $("#Responsable").val(arreglo[0].AreaEstrategica).trigger("change");
          break;
          case 'presupuesto':
            $('#modalRegistosNoT').modal('show');
            $('.espacioLL').html(`<form class="text-center" style="color: #757575;" action="#!"><div class="form-card">
            <div align="center"><h2 class="fs-title">Metas trimestrales</h2></div>
            <div class="row">
                <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                        <div class="container">
                            <label for="PTrimestre">Primer Trimestre:</label>
                            <div id="PTrimestre" class="row">
                                <div class="md-form col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                    <input type="number" id="PorcentPTrimestre" class="form-control" readonly disabled>
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
                                    <input type="number" id="MontoPTrimestre" class="form-control" readonly disabled>
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
                                    <input type="number" id="PorcentSTrimestre" class="form-control" readonly disabled>
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
                                    <input type="number" id="MontoSTrimestre" class="form-control" readonly disabled>
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
                                    <input type="number" id="PorcentTTrimestre" class="form-control" readonly disabled>
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
                                    <input type="number" id="MontoTTrimestre" class="form-control" readonly disabled>
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
                                    <input type="number" id="PorcentCTrimestre" class="form-control" readonly disabled>
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
                                    <input type="number" id="MontoCTrimestre" class="form-control" readonly disabled>
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
        </div></form>`);
        $("#PorcentPTrimestre").val(20000).trigger("change");
        $("#MontoPTrimestre").val(20).trigger("change");
        $("#PorcentSTrimestre").val(20000).trigger("change");
        $("#MontoSTrimestre").val(20).trigger("change");
        $("#PorcentTTrimestre").val(20000).trigger("change");
        $("#MontoTTrimestre").val(20).trigger("change");
        $("#PorcentCTrimestre").val(20000).trigger("change");
        $("#MontoCTrimestre").val(20).trigger("change");
          break;
        case 'actividades':
            $('#modalRegistros').modal('show');
            $('#RegistrosTodos').dataTable().fnDestroy();
            $('#RegistrosTodos tbody').html(``);
            $('#myModalLabel').html("Listado de actividades correspondientes");
            $('#RegistrosTodos thead').html(`<tr align="center">
                                                <th scope="col">#</th>
                                                <th scope="col">Objeto de gasto</th>
                                                <th scope="col">Descripcion de gasto</th>
                                                <th scope="col">Tipo de presupuesto</th>
                                                <th scope="col">Actividad</th>
                                                <th scope="col">Cantidad</th>
                                                <th scope="col">Costo</th>
                                                <th scope="col">Monto total</th>
                                                <th scope="col">Mes requerido</th>
                                                <th scope="col">Descripcion</th>
                                            </tr>`);
            for (let i=0;i<arreglo.length; i++) {
                $('#RegistrosTodos tbody').append(`
                    <tr align="center">
                        <td scope="row">${ i + 1 }</td>
                        <td>${ arreglo[i].Correlativo }</td>
                        <td>${ arreglo[i].DimensionEstrategica }</td>      
                        <td>${ arreglo[i].Correlativo }</td>
                        <td>${ arreglo[i].DimensionEstrategica }</td>    
                        <td>${ arreglo[i].Correlativo }</td>
                        <td>${ arreglo[i].DimensionEstrategica }</td>    
                        <td>${ arreglo[i].Correlativo }</td>
                        <td>${ arreglo[i].DimensionEstrategica }</td>
                        <td>${ arreglo[i].ObjetivoInstitucional }</td>     
                    </tr>
                `)
            }
          break;
        default:
            console.error("opcion no disponible");
    };
    $('#RegistrosTodos').DataTable({
        language: i18nEspaniol,
        "lengthMenu": [[3, 6, 9, -1], [3, 6, 9, "All"]],
        retrieve: true
    });
}