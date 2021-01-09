let clientsArr =  JSON.parse(localStorage.getItem('Dimension')) || [];
var pos=1;
clientsArr.push({'hola':'bye'});
localStorage.setItem('Dimension', JSON.stringify(clientsArr));

var arreglo = [
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

$(document).ready(function(){
    $('#ActividadTabla').dataTable().fnDestroy();
    $('#ActividadTabla'+' tbody').html(``);
    for (let i=0;i<arreglo.length; i++) {
        if(arreglo[i]!=null){
            $('#ActividadTabla tbody').append(`
                <tr align="center">
                    <td>${ arreglo[i].correlativo }</td>
                    <td>${ arreglo[i].objetivoInstitucional }</td>
                    <td>${ arreglo[i].area }</td>
                    <td>${ arreglo[i].actividad }</td>
                    <td>${ arreglo[i].monto }</td>
                    <td>${ arreglo[i].responsable }</td>
                    <td>${ arreglo[i].noActividades }</td>
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
        "lengthMenu": [[3, 6, 9, -1], [3, 6, 9, "All"]],
        retrieve: true
    });
    $('#Actividades').DataTable({
        language: i18nEspaniol,
        "lengthMenu": [[3, 6, 9, -1], [3, 6, 9, "All"]],
        retrieve: true
    });
    var current_fs, next_fs, previous_fs; //fieldsets
    var opacity;
    
    $(".next").click(function(){
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
        pos=1;
        current_fs = $(this).parent();
        $('#modalLlenadoActividades').modal('hide');
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
    document.querySelector(`#labelActividadL`).classList.remove('text-danger')
    document.querySelector('#ActividadL').classList.remove('text-danger');
    document.querySelector('#ActividadL').classList.remove('is-invalid')
    document.querySelector(`#errorsActividadL`).classList.add('d-none');
    $("#ActividadL").val("").trigger("change");
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
    document.querySelector(`#labelDescripcionCuenta`).classList.remove('text-danger')
    document.querySelector('#DescripcionCuenta').classList.remove('text-danger');
    document.querySelector('#DescripcionCuenta').classList.remove('is-invalid')
    document.querySelector(`#errorsDescripcionCuenta`).classList.add('d-none');
    $("#DescripcionCuenta").val("").trigger("change");
    document.querySelector(`#labelDimensionEstrategicaS`).classList.remove('text-danger')
    document.querySelector('#DimensionEstrategicaS').classList.remove('text-danger');
    document.querySelector('#DimensionEstrategicaS').classList.remove('is-invalid')
    document.querySelector(`#errorsDimensionEstrategicaS`).classList.add('d-none');
    $("#DimensionEstrategicaS").val("").trigger("change");
    document.querySelector(`#labelMes`).classList.remove('text-danger')
    document.querySelector('#Mes').classList.remove('text-danger');
    document.querySelector('#Mes').classList.remove('is-invalid')
    document.querySelector(`#errorsMes`).classList.add('d-none');
    $("#Mes").val("").trigger("change");
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
    document.querySelector(`#labelMontoPTrimestre`).classList.remove('text-danger')
    document.querySelector('#MontoPTrimestre').classList.remove('text-danger');
    document.querySelector('#MontoPTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsMontoPTrimestre`).classList.add('d-none');
    $("#MontoPTrimestre").trigger("change");
    document.querySelector(`#labelPorcentSTrimestre`).classList.remove('text-danger')
    document.querySelector('#PorcentSTrimestre').classList.remove('text-danger');
    document.querySelector('#PorcentSTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsPorcentSTrimestre`).classList.add('d-none');
    $("#PorcentSTrimestre").trigger("change");
    document.querySelector(`#labelMontoSTrimestre`).classList.remove('text-danger')
    document.querySelector('#MontoSTrimestre').classList.remove('text-danger');
    document.querySelector('#MontoSTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsMontoSTrimestre`).classList.add('d-none');
    $("#MontoSTrimestre").trigger("change");
    document.querySelector(`#labelPorcentTTrimestre`).classList.remove('text-danger')
    document.querySelector('#PorcentTTrimestre').classList.remove('text-danger');
    document.querySelector('#PorcentTTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsPorcentTTrimestre`).classList.add('d-none');
    $("#PorcentTTrimestre").trigger("change");
    document.querySelector(`#labelMontoTTrimestre`).classList.remove('text-danger')
    document.querySelector('#MontoTTrimestre').classList.remove('text-danger');
    document.querySelector('#MontoTTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsMontoTTrimestre`).classList.add('d-none');
    $("#MontoTTrimestre").trigger("change");
    document.querySelector(`#labelPorcentCTrimestre`).classList.remove('text-danger')
    document.querySelector('#PorcentCTrimestre').classList.remove('text-danger');
    document.querySelector('#PorcentCTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsPorcentCTrimestre`).classList.add('d-none');
    $("#PorcentCTrimestre").trigger("change");
    document.querySelector(`#labelMontoCTrimestre`).classList.remove('text-danger')
    document.querySelector('#MontoCTrimestre').classList.remove('text-danger');
    document.querySelector('#MontoCTrimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsMontoCTrimestre`).classList.add('d-none');
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
};

const modif = () =>{
    $('#modalModificarActividades').modal('show');
};

const ag = () => {
     // Capturando las etiquetas completas de los inputs para despues obtener el valor
     let ObjetivoI = document.querySelector('#ObjInstitucional');
     let AreaE = document.querySelector('#AreaEstrategica');

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
        /*const dataNuevoCarrera = {
            Carrera: Carrera.value,
            Abreviatura: Abreviatura.value,
            Departamento: Departamento.value,
            Estado: Estado.value
        };
        $.ajax({
            url: `${ API }/Carreras/registrarCarrera.php`, 
            method: 'POST',
            dataType: 'json',
            data: (dataNuevoCarrera)
        }).success(function(response) {
            console.log(response);
            $("#Carrera").val('').trigger("change");
            $("#Abreviatura").val('').trigger("change");
            $("#Departamento").val('').trigger("change");
            $("#Estado").val('').trigger("change");
            Swal.fire({
                icon: 'success',
                title: 'Listo',
                text: 'Registro insertado con exito',
            })
        }).error(function(error) {
            console.warn(error);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'El registro de la carrera no se pudo realizar',
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
        });*/
        Swal.fire({
            icon: 'warning',
            text: 'Continuar llenando las actvividades para el objetivo institucional y area estrategica seleccionadada?',
            showCancelButton: true,
            cancelButtonColor: "#ff3547",
            confirmButtonColor: "#8bc34a",
            confirmButtonText: "Continuar",
        }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                $('#modalLlenadoActividades').modal('show');
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
             let Ir = { valorEtiqueta: Indicador, id: 'Indicador', name: 'Indicador', min: 1, max: 500, type: 'text' };
             let Ri = { valorEtiqueta: ResultadosInstitucional, id: 'ResultadosInstitucional', name: 'Resultados Institucionales' ,type: 'select' };


             let isValidResultadosDeUnidad = verificarInputText(rU,letrasEspaciosCaracteresRegex);
             let isValidIndicador = verificarInputText(Ir,letrasEspaciosCaracteresRegex);
             let isValidResultadosInstitucional = verificarSelect(Ri);

            if (
                (isValidResultadosDeUnidad === true) &&
                (isValidIndicador === true) &&
                (isValidResultadosInstitucional === true) 
            ) {
                return true
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro de la carrera no se pudo realizar',
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                })
                return false
            }
          break;
        case 2:
            let Actividad = document.querySelector('#Actividads');

            let Ac = { valorEtiqueta: Actividad, id: 'Actividads', name: 'Actividad', min: 1, max: 500, type: 'text' };


            let isValidActividad = verificarInputText(Ac,letrasEspaciosCaracteresRegex);

           if (
               (isValidActividad === true)
           ) {
               return true
           } else { // caso contrario mostrar alerta y notificar al usuario 
               Swal.fire({
                   icon: 'error',
                   title: 'Ops...',
                   text: 'El registro de la carrera no se pudo realizar',
                   footer: '<b>Por favor verifique el formulario de registro</b>'
               })
               return false
           }
          break;
        case 3:
          return true
          break;
        case 4:
            let Justificacion = document.querySelector('#Justificacions');
            let Medio = document.querySelector('#Medio');
            let Poblacion = document.querySelector('#Poblacion');
            let Responsable = document.querySelector('#Responsable');

            let jC = { valorEtiqueta: Justificacion, id: 'Justificacions', name: 'Justificacion', min: 1, max: 500, type: 'text' };
            let mD = { valorEtiqueta: Medio, id: 'Medio', name: 'Medio', min: 1, max: 500, type: 'text' };
            let Pb = { valorEtiqueta: Poblacion, id: 'Poblacion', name: 'Poblacion', min: 1, max: 500, type: 'text' };
            let Rp = { valorEtiqueta: Responsable, id: 'Responsable', name: 'Responsable', min: 1, max: 500, type: 'text' };


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
               return true
           } else { // caso contrario mostrar alerta y notificar al usuario 
               Swal.fire({
                   icon: 'error',
                   title: 'Ops...',
                   text: 'El registro de la carrera no se pudo realizar',
                   footer: '<b>Por favor verifique el formulario de registro</b>'
               })
               return false
           }
          break;
        case 5:
          // code block
          break;
          default:
        // code block
    }
}
  var valor;
  const agregarAct = ()=>{
    let Actividads = document.querySelector('#ActividadL');
    let Cantidad = document.querySelector('#Cantidad');
    let Costo = document.querySelector('#Costo');
    let TipoPresupuesto = document.querySelector('#TipoPresupuesto');
    let ObjGasto = document.querySelector('#ObjGasto');
    let DescripcionCuenta = document.querySelector('#DescripcionCuenta');
    let DimensionEstrategicaS = document.querySelector('#DimensionEstrategicaS');
    let Mes = document.querySelector('#Mes');

    let aC = { valorEtiqueta: ActividadL, id: 'ActividadL', name: 'Actividad', min: 1, max: 500, type: 'text' };
    let Ca = { valorEtiqueta: Cantidad, id: 'Cantidad', name: 'Cantidad', min: 1, max: 10, type: 'number' };
    let Co = { valorEtiqueta: Costo, id: 'Costo', name: 'Costo' ,min: 1, max: 10,type: 'number' };
    let Tp = { valorEtiqueta: TipoPresupuesto, id: 'TipoPresupuesto', name: 'TipoPresupuesto' ,type: 'select' };
    let oG = { valorEtiqueta: ObjGasto, id: 'ObjGasto', name: 'ObjGasto' ,type: 'select' };
    let dC = { valorEtiqueta: DescripcionCuenta, id: 'DescripcionCuenta', name: 'Descripcion Cuenta', min: 1, max: 500, type: 'text' };
    let De = { valorEtiqueta: DimensionEstrategicaS, id: 'DimensionEstrategicaS', name: 'Dimension Estrategica', min: 1, max: 10, type: 'text' };
    let M = { valorEtiqueta: Mes, id: 'Mes', name: 'Mes' ,type: 'date' };


    let isValidActividads = verificarInputText(aC,letrasEspaciosCaracteresRegex);
    let isValidCantidad = verificarInputNumber(Ca,numerosRegex);
    let isValidCosto = verificarInputNumber(Co,numerosRegex);
    let isValidTipoPresupuesto = verificarSelect(Tp);
    let isValidObjGasto = verificarSelect(oG);
    let isValidDescripcionCuenta = verificarInputText(dC,letrasEspaciosCaracteresRegex);
    let isValidDimensionEstrategicaS = verificarInputText(De,letrasEspaciosCaracteresRegex);
    let isValidMes = verificarFecha(M);

   if (
       (isValidActividads === true) &&
       (isValidCantidad === true) &&
       (isValidCosto === true) &&
       (isValidTipoPresupuesto === true) &&
       (isValidObjGasto === true) &&
       (isValidDescripcionCuenta === true) &&
       (isValidDimensionEstrategicaS === true) &&
       (isValidMes === true) 
   ) {
       return true
   } else { // caso contrario mostrar alerta y notificar al usuario 
       Swal.fire({
           icon: 'error',
           title: 'Ops...',
           text: 'El registro de la carrera no se pudo realizar',
           footer: '<b>Por favor verifique el formulario de registro</b>'
       })
       return false
   }
    /*Swal.fire({
        title: 'Registro actividad',
        html: `
        <div class="container">    
            <form class="text-center" style="color: #757575;" action="#!">
                <div class="form-row">
                    <div class="col-12">
                        <div class="md-form">
                            <input type="text" id="Actividads" class="form-control">
                            <span id="errorsActividads" class="text-danger text-small d-none">
                            </span>
                            <label 
                                for="Actividads"
                                id="labelActividads"
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
                            <input type="number" id="Costo" class="form-control" readonly disabled>
                            <label 
                                for="Costo"
                                id="labelCosto"
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
                        <input type="text" id="Carrera" class="form-control">
                        <span id="errorsCarrera" class="text-danger text-small d-none">
                        </span>
                        <label 
                            for="Carrera"
                            id="labelCarrera"
                        >
                        Mes requerido
                        </label>
                    </div>
                </div>

            </form>
        </div>`,
        showCancelButton: true,
        confirmButtonText: 'Registrar',
        showLoaderOnConfirm: true,
        cancelButtonColor: "#ff3547",
        confirmButtonColor: "#3f51b5 ",
        footer: ""
      }).then((result) => {
          if (result.value) {
            this.valor = console.log($("#Actividads").val());
            Swal.fire({
                icon: 'warning',
                text: 'Continuar llenando las actvividades para el objetivo institucional y area estrategica seleccionadada?',
                showCancelButton: true,
                cancelButtonColor: "#ff3547",
                confirmButtonColor: "#8bc34a",
                confirmButtonText: "Continuar",
            }).then((result) => {
                 Read more about isConfirmed, isDenied 
                if (result.isConfirmed) {
                    $('#modalVisualizarCarreras').modal('show');
                } else if (result.isDenied) {
                  
                }
            })
            agregarAct();
        } else {
            return false;
        }
      })*/
  }