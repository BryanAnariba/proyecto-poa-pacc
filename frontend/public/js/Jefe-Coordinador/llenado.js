let clientsArr =  JSON.parse(localStorage.getItem('Dimension')) || [];
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

$(document).ready(function(){
    console.log(arreglo);
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
});
//localStorage.removeItem("Dimension");
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
var pos=1;
$(document).ready(function(){

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
  })
  
  });
  var valor;
  const agregarAct = ()=>{
    $(document).off('focusin.modal');
    Swal.fire({
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
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    $('#modalVisualizarCarreras').modal('show');
                } else if (result.isDenied) {
                  
                }
            })
            agregarAct();
        } else {
            return false;
        }
      })
  }