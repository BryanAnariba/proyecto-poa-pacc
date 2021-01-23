var pos=1;
let correlativoSeleccionado = null;
var arreglo2 = [
    {correlativo: "pendiente", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 1", noActividades:"4"},
    {correlativo: "llena", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 2", noActividades:"4"},
    {correlativo: "llena", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 3", noActividades:"4"},
    {correlativo: "pendiente", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 4", noActividades:"4"},
    {correlativo: "llena", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 5", noActividades:"4"},
    {correlativo: "pendiente", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 6", noActividades:"4"},
    {correlativo: "llena", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 7", noActividades:"4"},
    {correlativo: "pendiente", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 8", noActividades:"4"},
    {correlativo: "llena", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 9", noActividades:"4"},
    {correlativo: "pendiente", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 10", noActividades:"4"},
    {correlativo: "llena", objetivoInstitucional: "hola",area:"hola",actividad:"hola",monto:'400000',responsable:"Dimension 11", noActividades:"4"}];

// <<--- Inicializa todo lo de los select y el datatable, asi como tambien las funcionalidades del wizard --->>

function procesaValorTrimestreUno(object) {
    $('#calculaValorPT1').val((object.value/100)*$('#PresupuestoActividad').val());
    $('#SumaPorcentajes').val(Number.parseFloat(($('#PorcentPTrimestre').val()/100) + ($('#PorcentSTrimestre').val()/100) + ($('#PorcentTTrimestre').val()/100) + ($('#PorcentCTrimestre').val()/100)).toFixed(2));
}
function procesaValorTrimestreDos(object) {
    $('#calculaValorPT2').val((object.value/100)*$('#PresupuestoActividad').val());
    $('#SumaPorcentajes').val(Number.parseFloat(($('#PorcentPTrimestre').val()/100) + ($('#PorcentSTrimestre').val()/100) + ($('#PorcentTTrimestre').val()/100) + ($('#PorcentCTrimestre').val()/100)).toFixed(2));
}
function procesaValorTrimestreTres(object) {
    $('#calculaValorPT3').val((object.value/100)*$('#PresupuestoActividad').val());
    $('#SumaPorcentajes').val(Number.parseFloat(($('#PorcentPTrimestre').val()/100) + ($('#PorcentSTrimestre').val()/100) + ($('#PorcentTTrimestre').val()/100) + ($('#PorcentCTrimestre').val()/100)).toFixed(2));
}
function procesaValorTrimestreCuatro(object) {
    $('#calculaValorPT4').val((object.value/100)*$('#PresupuestoActividad').val());
    $('#SumaPorcentajes').val(Number.parseFloat(($('#PorcentPTrimestre').val()/100) + ($('#PorcentSTrimestre').val()/100) + ($('#PorcentTTrimestre').val()/100) + ($('#PorcentCTrimestre').val()/100)).toFixed(2));
}


$(document).ready(function(){
            $('#ActividadTabla').dataTable().fnDestroy();
            $('#ActividadTabla'+' tbody').html(``);
            for (let i=0;i<arreglo2.length; i++) {
                if(arreglo2[i]!=null){
                    $('#ActividadTabla tbody').append(`
                        <tr align="center">
                            <td>${ arreglo2[i].correlativo }</td>
                            <td>${ arreglo2[i].objetivoInstitucional }</td>
                            <td>${ arreglo2[i].area }</td>
                            <td>${ arreglo2[i].actividad }</td>
                            <td>${ arreglo2[i].monto }</td>
                            <td>${ arreglo2[i].responsable }</td>
                            <td>${ arreglo2[i].noActividades }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="modif()">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }
            }
            $('#ActividadTabla').DataTable({
                language: i18nEspaniol,
                retrieve: true
            });
            $('#Actividades').DataTable({
                language: i18nEspaniol,
                retrieve: true
            });
            var current_fs, next_fs, previous_fs; //fieldsets
            var opacity;
            
            $(".next").click(function(){
                console.log(pos);
                if(validar(pos)){
                    pos=pos+1
                    current_fs = $(this).parent();
                    next_fs = $(this).parent().next();
                    
                    //Add Class Active
                    $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
                    
                    //show the next fieldset
                    next_fs.show();
                    //hide the current fieldset with style
                    current_fs.animate({opacity: 0}, {
                    step: function(now) {
                    // for making fielset appear animation
                    opacity = 1 - now;
                    
                    current_fs.css({
                        'display': 'none',
                        'position': 'relative'
                    });
                        next_fs.css({'opacity': opacity});
                    },
                        duration: 600
                    });
                }
            });
            
            $(".previous").click(function(){
                pos=pos-1;
                current_fs = $(this).parent();
                previous_fs = $(this).parent().prev();
                
                //Remove class active
                $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");
                
                //show the previous fieldset
                previous_fs.show();
                
                //hide the current fieldset with style
                current_fs.animate({opacity: 0}, {
                step: function(now) {
                    // for making fielset appear animation
                    opacity = 1 - now;
                    
                    current_fs.css({
                        'display': 'none',
                        'position': 'relative'
                    });
                        previous_fs.css({'opacity': opacity});
                    },
                        duration: 600
                });
            });
            
            $('.radio-group .radio').click(function(){
            $(this).parent().find('.radio').removeClass('selected');
            $(this).addClass('selected');
            });
            
            $(".submit").click(function(){
            return false;
            });
            $("#save").click(function(){
                //$('#modalLlenadoActividades').modal('hide');
                pos=1;
                current_fs = $(this).parent();
                for(let i=1;i<5;i++){
                    $("#progressbar li").eq(i).removeClass("active");
                };
                current_fs.animate({opacity: 0}, {
                step: function(now) {
                    // for making fielset appear animation
                    opacity = 1 - now;
                    
                    current_fs.css({
                        'display': 'none',
                        'position': 'relative'
                    });
                        $("#primero").css({'opacity': opacity});
                    },
                        duration: 600
                });
                $("#primero").show();
                $("#msform")[0].reset();
                $("form").trigger("change");
                resetW();
            });
            $("#close").click(function(){
                pos=1;
                $('#modalLlenadoActividades').modal('hide');
                for(let i=1;i<5;i++){
                    $("#progressbar li").eq(i).removeClass("active");
                };
                $("#segundo").css({'display': 'none','position': 'relative'});
                $("#tercero").css({'display': 'none','position': 'relative'});
                $("#cuarto").css({'display': 'none','position': 'relative'});
                $("#quinto").css({'display': 'none','position': 'relative'});
                $("#primero").css({'opacity': 1});
                $("#primero").show();
                $("#msform")[0].reset();
                $("#foote-modal").css({'display': 'block','position': ''});
                $("#foote-modal").show();
                resetW();
            });
            $('#bot').click(function(){
                $('#modalActividad').modal('show');
                $('body').addClass('modal-open');
            });
            $("body").click(function(){
                $('#modalActividad').on('hidden.bs.modal', function () {
                    $('#modalLlenadoActividades').modal('show');
                    $('body').addClass('modal-open');
                })
            });
            $('#ingresarAct').click(function(){
                agregarAct();
            });
            $('#closeAct').click(function(){
                vaciarAct();
            });
        });
        

// <<--- Funciones --->>

//localStorage.removeItem("Dimension");

const vaciarAct = () => {
    document.querySelector(`#labelCantidadPersonas`).classList.remove('text-danger')
    document.querySelector('#CantidadPersonas').classList.remove('text-danger');
    document.querySelector('#CantidadPersonas').classList.remove('is-invalid')
    document.querySelector(`#errorsCantidadPersonas`).classList.add('d-none');
    $("#CantidadPersonas").val("").trigger("change");
    document.querySelector(`#labelCantidad`).classList.remove('text-danger')
    document.querySelector('#Cantidad').classList.remove('text-danger');
    document.querySelector('#Cantidad').classList.remove('is-invalid')
    document.querySelector(`#errorsCantidad`).classList.add('d-none');
    $("#Cantidad").val("").trigger("change");
    document.querySelector(`#labelCosto`).classList.remove('text-danger')
    document.querySelector('#Costo').classList.remove('text-danger');
    document.querySelector('#Costo').classList.remove('is-invalid')
    document.querySelector(`#errorsCosto`).classList.add('d-none');
    $("#Costo").val("").trigger("change");
    document.querySelector(`#labelTipoPresupuesto`).classList.remove('text-danger')
    document.querySelector('#TipoPresupuesto').classList.remove('text-danger');
    document.querySelector('#TipoPresupuesto').classList.remove('is-invalid')
    document.querySelector(`#errorsTipoPresupuesto`).classList.add('d-none');
    $("#TipoPresupuesto").val("").trigger("change");
    document.querySelector(`#labelObjGasto`).classList.remove('text-danger')
    document.querySelector('#ObjGasto').classList.remove('text-danger');
    document.querySelector('#ObjGasto').classList.remove('is-invalid')
    document.querySelector(`#errorsObjGasto`).classList.add('d-none');
    $("#ObjGasto").val("").trigger("change");
    document.querySelector(`#labelMesRequerido`).classList.remove('text-danger')
    document.querySelector('#MesRequerido').classList.remove('text-danger');
    document.querySelector('#MesRequerido').classList.remove('is-invalid')
    document.querySelector(`#errorsMesRequerido`).classList.add('d-none');
    $("#MesRequerido").val("").trigger("change");

    document.querySelector(`#labelAreaBeca`).classList.remove('text-danger')
    document.querySelector('#AreaBeca').classList.remove('text-danger');
    document.querySelector('#AreaBeca').classList.remove('is-invalid')
    document.querySelector(`#errorsAreaBeca`).classList.add('d-none');
    $("#AreaBeca").val("").trigger("change");

    document.querySelector(`#labelMeses`).classList.remove('text-danger')
    document.querySelector('#Meses').classList.remove('text-danger');
    document.querySelector('#Meses').classList.remove('is-invalid')
    document.querySelector(`#errorsMeses`).classList.add('d-none');
    $("#Meses").val("").trigger("change");

    document.querySelector(`#labelProyecto`).classList.remove('text-danger')
    document.querySelector('#Proyecto').classList.remove('text-danger');
    document.querySelector('#Proyecto').classList.remove('is-invalid')
    document.querySelector(`#errorsProyecto`).classList.add('d-none');
    $("#Proyecto").val("").trigger("change");

    document.querySelector(`#labelTipoEquipoTecnologico`).classList.remove('text-danger')
    document.querySelector('#TipoEquipoTecnologico').classList.remove('text-danger');
    document.querySelector('#TipoEquipoTecnologico').classList.remove('is-invalid')
    document.querySelector(`#errorsTipoEquipoTecnologico`).classList.add('d-none');
    $("#TipoEquipoTecnologico").val("").trigger("change");
};

const resetW = () => {
    document.querySelector(`#labelResultadosInstitucional`).classList.remove('text-danger')
    document.querySelector('#ResultadosInstitucional').classList.remove('text-danger');
    document.querySelector('#ResultadosInstitucional').classList.remove('is-invalid')
    document.querySelector(`#errorsResultadosInstitucional`).classList.add('d-none');
    $("#ResultadosInstitucional").trigger("change");
    document.querySelector(`#labelResultadosDeUnidad`).classList.remove('text-danger')
    document.querySelector('#ResultadosDeUnidad').classList.remove('text-danger');
    document.querySelector('#ResultadosDeUnidad').classList.remove('is-invalid')
    document.querySelector(`#errorsResultadosDeUnidad`).classList.add('d-none');
    $("#ResultadosDeUnidad").trigger("change");
    document.querySelector(`#labelIndicador`).classList.remove('text-danger')
    document.querySelector('#Indicador').classList.remove('text-danger');
    document.querySelector('#Indicador').classList.remove('is-invalid')
    document.querySelector(`#errorsIndicador`).classList.add('d-none');
    $("#Indicador").trigger("change");
    document.querySelector(`#labelActividads`).classList.remove('text-danger')
    document.querySelector('#Actividads').classList.remove('text-danger');
    document.querySelector('#Actividads').classList.remove('is-invalid')
    document.querySelector(`#errorsActividads`).classList.add('d-none');
    $("#Actividads").trigger("change");
    document.querySelector(`#labelPorcentPTrimestre`).classList.remove('text-danger')
    document.querySelector('#PorcentPTrimestre').classList.remove('text-danger');
    document.querySelector('#PorcentPTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsPorcentPTrimestre`).classList.add('d-none');
    $("#PorcentPTrimestre").trigger("change");
    // document.querySelector(`#labelMontoPTrimestre`).classList.remove('text-danger')
    // document.querySelector('#MontoPTrimestre').classList.remove('text-danger');
    // document.querySelector('#MontoPTrimestre').classList.remove('is-invalid')
    // document.querySelector(`#errorsMontoPTrimestre`).classList.add('d-none');
    $("#MontoPTrimestre").trigger("change");
    document.querySelector(`#labelPorcentSTrimestre`).classList.remove('text-danger')
    document.querySelector('#PorcentSTrimestre').classList.remove('text-danger');
    document.querySelector('#PorcentSTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsPorcentSTrimestre`).classList.add('d-none');
    $("#PorcentSTrimestre").trigger("change");
    // document.querySelector(`#labelMontoSTrimestre`).classList.remove('text-danger')
    // document.querySelector('#MontoSTrimestre').classList.remove('text-danger');
    // document.querySelector('#MontoSTrimestre').classList.remove('is-invalid')
    // document.querySelector(`#errorsMontoSTrimestre`).classList.add('d-none');
    $("#MontoSTrimestre").trigger("change");
    document.querySelector(`#labelPorcentTTrimestre`).classList.remove('text-danger')
    document.querySelector('#PorcentTTrimestre').classList.remove('text-danger');
    document.querySelector('#PorcentTTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsPorcentTTrimestre`).classList.add('d-none');
    $("#PorcentTTrimestre").trigger("change");
    // document.querySelector(`#labelMontoTTrimestre`).classList.remove('text-danger')
    // document.querySelector('#MontoTTrimestre').classList.remove('text-danger');
    // document.querySelector('#MontoTTrimestre').classList.remove('is-invalid')
    // document.querySelector(`#errorsMontoTTrimestre`).classList.add('d-none');
    $("#MontoTTrimestre").trigger("change");
    document.querySelector(`#labelPorcentCTrimestre`).classList.remove('text-danger')
    document.querySelector('#PorcentCTrimestre').classList.remove('text-danger');
    document.querySelector('#PorcentCTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsPorcentCTrimestre`).classList.add('d-none');
    $("#PorcentCTrimestre").trigger("change");
    // document.querySelector(`#labelMontoCTrimestre`).classList.remove('text-danger')
    // document.querySelector('#MontoCTrimestre').classList.remove('text-danger');
    // document.querySelector('#MontoCTrimestre').classList.remove('is-invalid')
    // document.querySelector(`#errorsMontoCTrimestre`).classList.add('d-none');
    $("#MontoCTrimestre").trigger("change");
    document.querySelector(`#labelJustificacions`).classList.remove('text-danger')
    document.querySelector('#Justificacions').classList.remove('text-danger');
    document.querySelector('#Justificacions').classList.remove('is-invalid')
    document.querySelector(`#errorsJustificacions`).classList.add('d-none');
    $("#Justificacions").trigger("change");
    document.querySelector(`#labelMedio`).classList.remove('text-danger')
    document.querySelector('#Medio').classList.remove('text-danger');
    document.querySelector('#Medio').classList.remove('is-invalid')
    document.querySelector(`#errorsMedio`).classList.add('d-none');
    $("#Medio").trigger("change");
    document.querySelector(`#labelPoblacion`).classList.remove('text-danger')
    document.querySelector('#Poblacion').classList.remove('text-danger');
    document.querySelector('#Poblacion').classList.remove('is-invalid')
    document.querySelector(`#errorsPoblacion`).classList.add('d-none');
    $("#Poblacion").trigger("change");
    document.querySelector(`#labelResponsable`).classList.remove('text-danger')
    document.querySelector('#Responsable').classList.remove('text-danger');
    document.querySelector('#Responsable').classList.remove('is-invalid')
    document.querySelector(`#errorsResponsable`).classList.add('d-none');
    $("#Responsable").trigger("change");
    document.querySelector(`#labelPresupuestoActividad`).classList.remove('text-danger')
    document.querySelector('#PresupuestoActividad').classList.remove('text-danger');
    document.querySelector('#PresupuestoActividad').classList.remove('is-invalid')
    document.querySelector(`#errorsPresupuestoActividad`).classList.add('d-none');
};

const modif = () =>{
    $('#modalModificarActividades').modal('show');
};

const ag = () => {
    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    // console.log($('#DimEstrategica').val());
    // console.log($('#ObjInstitucional').val());
    // console.log($('#AreaEstrategica').val());

     // Tipando los atributos con los valores de la base de datos bueno algunos -> nP = nombrePersona
    let oE = { valorEtiqueta: ObjInstitucional, id: 'ObjInstitucional', name: 'Objetivo Institucional', type: 'select' };
    let aE = { valorEtiqueta: AreaEstrategica, id: 'AreaEstrategica', name: 'Area Estrategica' ,type: 'select' };
    

     // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidObjInstitucional = verificarSelect(oE);
    let isValidAreaE = verificarSelect(aE);

    // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
    if (
        (isValidAreaE === true) &&
        (isValidObjInstitucional === true) 
    ) {
        Swal.fire({
            icon: 'warning',
            text: 'Continuar llenando las actvividades para el objetivo institucional y area estrategica seleccionadada?',
            showCancelButton: true,
            cancelButtonColor: "#ff3547",
            confirmButtonColor: "#1A237E",
            confirmButtonText: "Continuar",
            cancelButtonText: "Cancelar",
        }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                
                $('#modalFormLlenadoDimension').modal('hide');
                $('#modalLlenadoActividades').modal('show');
                $('#ResultadosInstitucional').html(``);
                let parametros = {
                    idAreaEstrategica: parseInt($('#AreaEstrategica').val())
                };
                $.ajax(`${ API }/resultados-institucionales/listar-resultados-activos-por-area.php`, {
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        console.log(data);
                        $('#ResultadosInstitucional').append(`<option value="" selected>Seleccione Un Resultado Institucional</option>`);
                        for(let i=0; i<data.length; i++) {
                            $('#ResultadosInstitucional').append(`
                                <option value="${ data[i].idResultadoInstitucional }">${ data[i].resultadoInstitucional }</option>
                            `);
                        }
                    },
                    error:function(error) {
                        console.log(error.responseText);
                        const { status, data } = error.responseJSON;
                        if (status === 401) {
                            window.location.href = '../views/401.php';
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Ops...',
                                text: `${ data.message }`,
                                footer: '<b>Por favor recarge la pagina o comuniquese con el super administrador</b>'
                            });
                        }
                    }
                });
            } else if (result.isDenied) {
            }
        })
    } else { // caso contrario mostrar alerta y notificar al usuario 
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'Debe seleccionar el objetivo institucion y el area estrategica para continuar',
            footer: '<b>Por favor verifique los campos</b>'
        })
    }
}

const validar = (posicion) =>{
    switch(posicion) {
        case 1:
            let ResultadosDeUnidad = document.querySelector('#ResultadosDeUnidad');
            let Indicador = document.querySelector('#Indicador');
            let ResultadosInstitucional = document.querySelector('#ResultadosInstitucional');

            let rU = { valorEtiqueta: ResultadosDeUnidad, id: 'ResultadosDeUnidad', name: 'Resultados de la unidad', min: 1, max: 500, type: 'text' };
            let Ir = { valorEtiqueta: Indicador, id: 'Indicador', name: 'Indicador', min: 1, max: 200, type: 'text' };
            let Ri = { valorEtiqueta: ResultadosInstitucional, id: 'ResultadosInstitucional', name: 'Resultados Institucionales' ,type: 'select' };


            let isValidResultadosDeUnidad = verificarInputText(rU,letrasEspaciosCaracteresRegex);
            let isValidIndicador = verificarInputText(Ir,letrasEspaciosCaracteresRegex);
            let isValidResultadosInstitucional = verificarSelect(Ri);

            if (
                (isValidResultadosDeUnidad === true) &&
                (isValidIndicador === true) &&
                (isValidResultadosInstitucional === true) 
            ) {
                let parametros = { idDimension: parseInt($('#DimEstrategica').val()) };
                $.ajax(`${ API }/actividades/genera-correlativo-actividad.php`,{
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        console.log(data);
                        correlativoSeleccionado = data.correlativoActividad;
                        $('#CorrelativoGeneradoParaRegistrar').val(data.correlativoActividad);
                    },
                    error:function(error) {
                        console.log(error.responseText);
                        const { status, data } = error.responseJSON;
                        if (status === 401) {
                            window.location.href = '../views/401.php';
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Ops...',
                                text: `${ data.message }`,
                                footer: '<b>Por favor recarge la pagina o comuniquese con el super administrador</b>'
                            });
                        }
                    }
                });
                return true
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'No se puede avanzar',
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                })
                return false
            }
        break;
        case 2:
            let Actividad = document.querySelector('#Actividads');
            let Ac = { valorEtiqueta: Actividad, id: 'Actividads', name: 'Actividad', min: 1, max: 200, type: 'text' };
            let isValidActividad = verificarInputText(Ac,letrasEspaciosCaracteresRegex);
            if (
                (isValidActividad === true)
            ) {
                $.ajax(`${ API }/tipo-actividad/listar-tipo-costos-actividad.php`,{
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    success:function(response) {
                        const { data } = response;
                        console.log(data);
                        $('#TipoActividad').html(`<option value="" selected>Seleccione tipo costo actividad</option>`);
                        for(let i=0;i<data.length;i++) {
                            $('#TipoActividad').append(`<option value="${ data[i].idTipoActividad }">${ data[i].TipoActividad }</option>`);
                        }
                    },
                    error:function(error) {
                        console.log(error.responseText);
                        const { status, data } = error.responseJSON;
                        if (status === 401) {
                            window.location.href = '../views/401.php';
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Ops...',
                                text: `${ data.message }`,
                                footer: '<b>Por favor recarge la pagina o comuniquese con el super administrador</b>'
                            });
                        }
                    }
                });
                return true
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'No se puede avanzar',
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                })
                return false
            }
        break;
        case 3:
            $('#modalFormLlenadoDimension').modal('hide');
            $('#PresupuestoActividad').trigger('reset');
            let costoActividad = document.querySelector('#PresupuestoActividad');
            let cA = { valorEtiqueta: costoActividad, id: 'PresupuestoActividad', name: 'Costo Actividad', min: 1, max: 10, type: 'text' };
            let isValidCostoActividad = verificarInputText(cA, regexNumeroPositivoEnteroCalculo);
            let sumatoriaPorcentajes = ($('#PorcentPTrimestre').val()/100) + ($('#PorcentSTrimestre').val()/100) + ($('#PorcentTTrimestre').val()/100) + ($('#PorcentCTrimestre').val()/100);
            let presupuestoUtilizado = $('#PresupuestoUtilizado').val();
            let presupuestoTotal = $('#PresupuestoDisponible').val();
            let nuevoPresupuestoUtilizado = Number(presupuestoUtilizado) + Number(costoActividad.value);
            let tipoAct = document.querySelector('#TipoActividad');
            let tA = { valorEtiqueta: tipoAct, id: 'TipoActividad', name: 'Tipo Actividad', type: 'select' };
            let isValidTipoActividad = verificarSelect(tA);
            console.log(nuevoPresupuestoUtilizado);
            if ((isValidCostoActividad===true) && (sumatoriaPorcentajes === 1) && (Number(nuevoPresupuestoUtilizado) < presupuestoTotal) && (isValidTipoActividad === true)) { 
                let parametros = {
                    costoTotalActividad: Number($('#PresupuestoActividad').val()),
                    porcentajeTrimestre1: Number($('#PorcentPTrimestre').val()),
                    porcentajeTrimestre2: Number($('#PorcentSTrimestre').val()),
                    porcentajeTrimestre3: Number($('#PorcentTTrimestre').val()),
                    porcentajeTrimestre4: Number($('#PorcentCTrimestre').val())
                };
                console.log(parametros);
                $.ajax(`${ API }/actividades/verifica-costos-actividad.php`, {
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        console.log(data); 
                    },
                    error:function(error) {
                        console.log(error.responseText);
                        const { status, data } = error.responseJSON;
                        if (status === 401) {
                            window.location.href = '../views/401.php';
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Ops...',
                                text: `${ data.message }`,
                                footer: '<b>Verifique los datos del paso Metas Trimestrales Nuevamente</b>'
                            });
                        }
                    }
                });
                return true;
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'No puedes seguir, verifica que el costo de la actividad este correctamente escrito, o que la sumatoria de los porcentajes digitados de 1 o que el costo de la actividad no exceda el costo disponible del departamento',
                    footer: '<b>Por favor digite el presupuesto de la actividad</b>'
                });
            }
        break;
        case 4:
            return true
        break;
        default:
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'No se puede avanzar, la opcion no es valida',
                footer: '<b>Por favor verifique el formulario de registro</b>'
            });    
        break;
        // code block
    }
}
var valor;
const agregarAct = () => {
    console.log(idActividadSeleccionada);
    console.log(costoTotalActividadSeleccionada);

    // Campos que tienen en comun
    let Cantidad = document.querySelector('#Cantidad');
    let Costo = document.querySelector('#Costo');
    let CostoT = document.querySelector('#CostoT');
    let TipoPresupuesto = document.querySelector('#TipoPresupuesto');
    let ObjGasto = document.querySelector('#ObjGasto');
    let Mes = document.querySelector('#MesRequerido');

    // Campos que no tienen en comun
    let CantidadPersonas = document.querySelector('#CantidadPersonas');
    let meses = document.querySelector('#Meses');
    let tipoEquipoTecnologico = document.querySelector('#TipoEquipoTecnologico');
    let areaBeca = document.querySelector('#AreaBeca');
    let proyectos = document.querySelector('#Proyecto');
    
    let Ca = { valorEtiqueta: Cantidad, id: 'Cantidad', name: 'Cantidad', min: 1, max: 10, type: 'number' };
    let Co = { valorEtiqueta: Costo, id: 'Costo', name: 'Costo' ,min: 1, max: 13,type: 'number' };
    let CoT = { valorEtiqueta: CostoT, id: 'CostoT', name: 'Costo Total' ,min: 1, max: 13,type: 'number' };
    let Tp = { valorEtiqueta: TipoPresupuesto, id: 'TipoPresupuesto', name: 'TipoPresupuesto' ,type: 'select' };
    let oG = { valorEtiqueta: ObjGasto, id: 'ObjGasto', name: 'ObjGasto' ,type: 'select' };
    let M = { valorEtiqueta: Mes, id: 'MesRequerido', name: 'Mes Rquerido' ,type: 'select' };
    let CaP = { valorEtiqueta: CantidadPersonas, id: 'CantidadPersonas', name: 'Cantidad Personas', min: 1, max: 10, type: 'number' };
    let mes = { valorEtiqueta: meses, id: 'Meses', name: 'Meses', min: 1, max: 4, type: 'number' };
    let tET = { valorEtiqueta: tipoEquipoTecnologico, id: 'TipoEquipoTecnologico', name: 'Tipo Equipo Tecnologico', min: 1, max: 200, type: 'number' };
    let aB = { valorEtiqueta: areaBeca, id: 'AreaBeca', name: 'Area Beca', min: 1, max: 200, type: 'number' };
    let project = { valorEtiqueta: proyectos, id: 'Proyecto', name: 'Proyecto' ,type: 'select' };

    let isValidCantidad = verificarInputNumber(Ca,numerosRegex);
    let isValidCosto = verificarInputNumber(Co,numerosRegex);
    let isValidCostoT = verificarInputNumber(CoT,numerosRegex);
    let isValidTipoPresupuesto = verificarSelect(Tp);
    let isValidObjGasto = verificarSelect(oG);
    let isValidMes = verificarSelect(M);

        let parametros;
        switch(parseInt($('#DimensionAdministrativa').val())) {
            case  1:
                let isValidCantidadPersonas = verificarInputNumber(CaP,numerosRegex);
                if (
                    (isValidCantidad === true) &&
                    (isValidCosto === true) &&
                    (isValidCostoT === true) &&
                    (isValidTipoPresupuesto === true) &&
                    (isValidObjGasto === true) &&
                    (isValidMes === true) && 
                    (isValidCantidadPersonas === true) 
                ) { 
                    parametros = {
                        idActividad: parseInt(idActividadSeleccionada),
                        idObjetoGasto: parseInt(ObjGasto.value),
                        idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                        idDimension: parseInt(idDimensionSeleccionada),
                        cantidad: Cantidad.value,
                        costo:  Costo.value,
                        costoTotal: CostoT.value,
                        mesRequerido: Mes.value,
                        descripcion: { cantidadPersonas: CantidadPersonas.value }
                    }
                    console.log(parametros);
                    vaciarAct();
                } else { // caso contrario mostrar alerta y notificar al usuario 
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: 'El registro de la carrera no se pudo realizar',
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                }
            break;
            case  2:
                let isValidMeses = verificarInputNumber(mes,numerosRegex);
                if (
                    (isValidCantidad === true) &&
                    (isValidCosto === true) &&
                    (isValidCostoT === true) &&
                    (isValidTipoPresupuesto === true) &&
                    (isValidObjGasto === true) &&
                    (isValidMes === true) && 
                    (isValidMeses === true) 
                ) { 
                    parametros = {
                        idActividad: parseInt(idActividadSeleccionada),
                        idObjetoGasto: parseInt(ObjGasto.value),
                        idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                        idDimension: parseInt(idDimensionSeleccionada),
                        cantidad: Cantidad.value,
                        costo:  Costo.value,
                        costoTotal: CostoT.value,
                        mesRequerido: Mes.value,
                        descripcion: { meses: meses.value }
                    }
                    console.log(parametros);
                    vaciarAct();
                } else { // caso contrario mostrar alerta y notificar al usuario 
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: 'El registro de la carrera no se pudo realizar',
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                }
            break;
            case  3:
                if (
                    (isValidCantidad === true) &&
                    (isValidCosto === true) &&
                    (isValidCostoT === true) &&
                    (isValidTipoPresupuesto === true) &&
                    (isValidObjGasto === true) &&
                    (isValidMes === true)
                ) { 
                    parametros = {
                        idActividad: parseInt(idActividadSeleccionada),
                        idObjetoGasto: parseInt(ObjGasto.value),
                        idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                        idDimension: parseInt(idDimensionSeleccionada),
                        cantidad: Cantidad.value,
                        costo:  Costo.value,
                        costoTotal: CostoT.value,
                        mesRequerido: Mes.value,
                        descripcion: {}
                    }
                    console.log(parametros);
                    vaciarAct();
                } else { // caso contrario mostrar alerta y notificar al usuario 
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: 'El registro de la carrera no se pudo realizar',
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                }
            break;
            case  4:
                let isValidTipoEquipoTecnologico = verificarInputText(tET, letrasEspaciosCaracteresRegex);
                if (
                    (isValidCantidad === true) &&
                    (isValidCosto === true) &&
                    (isValidCostoT === true) &&
                    (isValidTipoPresupuesto === true) &&
                    (isValidObjGasto === true) &&
                    (isValidMes === true) &&
                    (isValidTipoEquipoTecnologico === true)
                ) { 
                    parametros = {
                        idActividad: parseInt(idActividadSeleccionada),
                        idObjetoGasto: parseInt(ObjGasto.value),
                        idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                        idDimension: parseInt(idDimensionSeleccionada),
                        cantidad: Cantidad.value,
                        costo:  Costo.value,
                        costoTotal: CostoT.value,
                        mesRequerido: Mes.value,
                        descripcion: { tipoEquipoTecnologico: tipoEquipoTecnologico.value }
                    }
                    console.log(parametros);
                    vaciarAct();
                } else { // caso contrario mostrar alerta y notificar al usuario 
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: 'El registro de la carrera no se pudo realizar',
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                }
            break;
            case  5:
                if (
                    (isValidCantidad === true) &&
                    (isValidCosto === true) &&
                    (isValidCostoT === true) &&
                    (isValidTipoPresupuesto === true) &&
                    (isValidObjGasto === true) &&
                    (isValidMes === true)
                ) { 
                    parametros = {
                        idActividad: parseInt(idActividadSeleccionada),
                        idObjetoGasto: parseInt(ObjGasto.value),
                        idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                        idDimension: parseInt(idDimensionSeleccionada),
                        cantidad: Cantidad.value,
                        costo:  Costo.value,
                        costoTotal: CostoT.value,
                        mesRequerido: Mes.value,
                        descripcion: {}
                    }
                    console.log(parametros);
                    vaciarAct();
                } else { // caso contrario mostrar alerta y notificar al usuario 
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: 'El registro de la carrera no se pudo realizar',
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                }
            break;
            case  6:
                let isValidaAreaBeca = verificarInputText(aB, letrasEspaciosCaracteresRegex);
                if (
                    (isValidCantidad === true) &&
                    (isValidCosto === true) &&
                    (isValidCostoT === true) &&
                    (isValidTipoPresupuesto === true) &&
                    (isValidObjGasto === true) &&
                    (isValidMes === true) &&
                    (isValidaAreaBeca === true)
                ) { 
                    parametros = {
                        idActividad: parseInt(idActividadSeleccionada),
                        idObjetoGasto: parseInt(ObjGasto.value),
                        idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                        idDimension: parseInt(idDimensionSeleccionada),
                        cantidad: Cantidad.value,
                        costo:  Costo.value,
                        costoTotal: CostoT.value,
                        mesRequerido: Mes.value,
                        descripcion: { areaBeca: areaBeca.value }
                    }
                    console.log(parametros);
                    vaciarAct();
                } else { // caso contrario mostrar alerta y notificar al usuario 
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: 'El registro de la carrera no se pudo realizar',
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                }
            break;
            case  7:
                let isValidProyecto = verificarSelect(project);
                if (
                    (isValidCantidad === true) &&
                    (isValidCosto === true) &&
                    (isValidCostoT === true) &&
                    (isValidTipoPresupuesto === true) &&
                    (isValidObjGasto === true) &&
                    (isValidMes === true) &&
                    (isValidProyecto === true)
                ) { 
                    parametros = {
                        idActividad: parseInt(idActividadSeleccionada),
                        idObjetoGasto: parseInt(ObjGasto.value),
                        idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                        idDimension: parseInt(idDimensionSeleccionada),
                        cantidad: Cantidad.value,
                        costo:  Costo.value,
                        costoTotal: CostoT.value,
                        mesRequerido: Mes.value,
                        descripcion: { proyecto: proyectos.value }
                    }
                    console.log(parametros);
                    vaciarAct();
                } else { // caso contrario mostrar alerta y notificar al usuario 
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: 'El registro de la carrera no se pudo realizar',
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                }
            break;
            case  8:
            //falta
            break;
            default:
            break;
        
    }
}

const insertaActividad = () => {
    let Justificacion = document.querySelector('#Justificacions');
            let Medio = document.querySelector('#Medio');
            let Poblacion = document.querySelector('#Poblacion');
            let Responsable = document.querySelector('#Responsable');

            let jC = { valorEtiqueta: Justificacion, id: 'Justificacions', name: 'Justificacion', min: 1, max: 255, type: 'text' };
            let mD = { valorEtiqueta: Medio, id: 'Medio', name: 'Medio', min: 1, max: 255, type: 'text' };
            let Pb = { valorEtiqueta: Poblacion, id: 'Poblacion', name: 'Poblacion', min: 1, max: 255, type: 'text' };
            let Rp = { valorEtiqueta: Responsable, id: 'Responsable', name: 'Responsable', min: 1, max: 255, type: 'text' };


            let isValidJustificacion = verificarInputText(jC,letrasEspaciosCaracteresRegex);
            let isValidMedio = verificarInputText(mD,letrasEspaciosCaracteresRegex);
            let isValidPoblacion = verificarInputText(Pb,letrasEspaciosCaracteresRegex);
            let isValidResponsable = verificarInputText(Rp,letrasEspaciosCaracteresRegex);

            if (
                (isValidJustificacion === true) &&
                (isValidMedio === true) &&
                (isValidPoblacion === true) &&
                (isValidResponsable === true)
            ) {
                let parametros = {
                    idDimension: parseInt($('#DimEstrategica').val()), 
                    idObjetivoInstitucional: parseInt($('#ObjInstitucional').val()),
                    idResultadoInstitucional: parseInt($('#ResultadosInstitucional').val()),
                    idAreaEstrategica: parseInt($('#AreaEstrategica').val()),
                    resultadosUnidad: $('#ResultadosDeUnidad').val(),
                    indicadoresResultado: $('#Indicador').val(),
                    actividad: $('#Actividads').val(),
                    idTipoActividad: parseInt($('#TipoActividad').val()),
                    correlativoActividad: correlativoSeleccionado,
                    porcentajeTrimestre1: Number($('#PorcentPTrimestre').val()/100),
                    porcentajeTrimestre2: Number($('#PorcentSTrimestre').val()/100),
                    porcentajeTrimestre3: Number($('#PorcentTTrimestre').val()/100),
                    porcentajeTrimestre4: Number($('#PorcentCTrimestre').val()/100),
                    justificacionActividad: $('#Justificacions').val(),
                    medioVerificacionActividad: $('#Medio').val(),
                    poblacionObjetivoActividad: $('#Poblacion').val(),
                    responsableActividad: $('#Responsable').val(),
                    costoTotal: $('#PresupuestoActividad').val(),
                };
                
                
                console.log(parametros);
                //$.ajax(`${ API }/actividades/insertar-actividad.php`, {
                //     type: 'POST',
                //     dataType: 'json',
                //     contentType: 'application/json',
                //     data: JSON.stringify(parametros),
                //     success:function(response) {
                //         const { data } = response;
                //         console.log(data);
                //         $('#modalFormLlenadoDimension').modal('hide');
                //         llenar('DimensionesTablaModificar');
                //         llenar('DimensionesTabla');
                //         $("#modalModificarDimension").modal('show');
                //         Swal.fire({
                //             icon: 'success',
                //             title: 'Accion realizada Exitosamente',
                //             text: `${ data.message }`,
                //         });
                //     },
                //     error:function(error) {
                //         console.log(error.responseText);
                //         const { status, data } = error.responseJSON;
                //         if (status === 401) {
                //             window.location.href = '../views/401.php';
                //         } else {
                //             Swal.fire({
                //                 icon: 'error',
                //                 title: 'Ops...',
                //                 text: `${ data.message }`,
                //                 footer: '<b>Verifique los datos del formulario</b>'
                //             });
                //         }
                //     }
                // });
                $('#modalLlenadoActividades').modal('hide');
                llenar('DimensionesTablaModificar');
                $("#modalModificarDimension").modal('show');
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'No se puede avanzar',
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                });
                return false
            }
}