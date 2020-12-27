$(document).ready(function (){
    obtenerCarreras();
});
const agregarATabla = (dataSet) => {
    $('#CarrerasTodas').dataTable().fnDestroy();
    $('#CarrerasTodas tbody').html(``);
    
    for (let i=0;i<dataSet.length; i++) {
        $('#CarrerasTodas tbody').append(`
            <tr align="center">
                <td scope="row">${ i + 1 }</td>
                <td>${ dataSet[i].codigoObjetoGasto }</td>
                <td>${ dataSet[i].DescripcionCuenta }</td>
                <td>${ dataSet[i].abrev }</td>
                <td>${ dataSet[i].estado }</td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="obtenerCarrera('${dataSet[i].idObjetoGasto}','${dataSet[i].codigoObjetoGasto}','${dataSet[i].DescripcionCuenta}','${dataSet[i].abrev}','${dataSet[i].idEstado}')">
                        <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                    </button>
                </td>
            </tr>
        `)
    }
    $('#CarrerasTodas').DataTable({
        language: i18nEspaniol,
        dom: 'Blfrtip',
        buttons: botonesExportacion,
        retrieve: true
    });
};
const obtenerCarreras = () => {
    const peticion = {
        nada: ""
    };
    $.ajax(`${ API }/ObjetosGasto/ObtenerObjetosGasto.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: (peticion),
        success:function(response) {
            agregarATabla(response.data);
        },
        error:function(error) {
            const { data } = error.responseJSON;
            console.log(data);
        }
    });
};
const cambiarEstadoModificado = (idEstado) => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/ObjetosGasto/obtenerEstado.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("EstadoModif").innerHTML="<option value='' disabled></option>";
        for(let i = 0; i < response.data.length;i++){
            if(idEstado==response.data[i].idEstado){
                document.getElementById("EstadoModif").innerHTML+=`<option value="${response.data[i].idEstado}" selected>${response.data[i].estado}</option>`;
            }else{
                document.getElementById("EstadoModif").innerHTML+=`<option value="${response.data[i].idEstado}">${response.data[i].estado}</option>`;
            }
        }
        
    }).error(function(error) {
       console.warn(error); 
    });
};
var id = 0;
const obtenerCarrera = (id,codigo,ObjetosGasto,abrev,idEstado) => {
    this.id=id;
    $('#modalModificarObjeto').modal('show');
    //$('#M-nombreDimension').val(dimensionEstrategica).trigger('change');
    //$("#botonModif").attr("disabled", false);
    $("#ObjetoDeGasto").val(ObjetosGasto).trigger("change");
    $("#Abreviatura2").val(abrev).trigger("change");
    $("#CodigoObjeto").val(codigo).trigger("change");
    cambiarEstadoModificado(idEstado);
};
const actualizarObjeto = () => {

    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    let ObjetoDeGasto = document.querySelector('#ObjetoDeGasto');
    let Abreviatura = document.querySelector('#Abreviatura2');
    let CodigoObjeto = document.querySelector('#CodigoObjeto');
    let Estado = document.querySelector('#EstadoModif');
    
    // Tipando los atributos con los valores de la base de datos bueno algunos -> nP = nombrePersona
    let oG = { valorEtiqueta: ObjetoDeGasto, id: 'ObjetoDeGasto', name: 'Objeto de Gasto', min: 1, max: 80, type: 'text' };
    let aB = { valorEtiqueta: Abreviatura, id: 'Abreviatura2', name: 'Abreviatura', min: 1, max: 5, type: 'text' };
    let cO = { valorEtiqueta: CodigoObjeto, id: 'CodigoObjeto',name: 'Codigo objeto de gasto', min: 1, max: 8, type: 'number' };
    let Es = { valorEtiqueta: Estado, id: 'EstadoModif',name: 'Estado', type: 'select' };
    

    // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidObjeto = verificarInputText(oG,letrasEspaciosCaracteresRegex);
    let isValidAbreviatura = verificarInputText(aB,letrasEspaciosCaracteresRegex);
    let isValidCodigo = verificarInputNumber(cO,numerosRegex);
    let isValidEstado = verificarSelect(Es);

    // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
    if (
        (isValidObjeto === true) &&
        (isValidAbreviatura === true) &&
        (isValidEstado === true) &&
        (isValidCodigo === true) 
    ) {
        const dataNuevoCarrera = {
            idObjetoGasto: this.id,
            ObjetoDeGasto: ObjetoDeGasto.value,
            Abreviatura: Abreviatura.value,
            CodigoObjeto: CodigoObjeto.value,
            Estado: Estado.value
        };
        $.ajax({
            url: `${ API }/ObjetosGasto/ActualizarObjeto.php`, 
            method: 'POST',
            dataType: 'json',
            data: dataNuevoCarrera
        }).success(function(response) {
            console.log(response);
            Swal.fire({
                icon: 'success',
                title: 'Listo',
                text: 'Registro insertado con exito',
            });
            obtenerCarreras();
        }).error(function(error) {
            console.log(error);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'El registro del objeto del gasto no se pudo realizar',
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
        });
    } else { // caso contrario mostrar alerta y notificar al usuario 
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro del objeto del gasto no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        })
    }
};
const DesplegarModalRegistro = () => {
    $('#modalRegistrarObjeto').modal('show');
    cambiarEst();
}
const cambiarEst = () => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/ObjetosGasto/obtenerEstado.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("Estado").innerHTML="<option value='' disabled selected></option>";
        for(let i = 0; i < response.data.length;i++){
            document.getElementById("Estado").innerHTML+=`<option value="${response.data[i].idEstado}">${response.data[i].estado}</option>`;
        };
    }).error(function(error) {
       console.warn(error); 
    });
};
const registrarObjeto = () => {

    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    let ObjetoDeGasto = document.querySelector('#ObjetoDeGastoR');
    let Abreviatura = document.querySelector('#Abreviatura');
    let CodigoObjeto = document.querySelector('#CodigoObjetoR');
    let Estado = document.querySelector('#Estado');
    
    // Tipando los atributos con los valores de la base de datos bueno algunos -> nP = nombrePersona
    let oG = { valorEtiqueta: ObjetoDeGasto, id: 'ObjetoDeGastoR', name: 'Objeto de Gasto', min: 1, max: 80, type: 'text' };
    let aB = { valorEtiqueta: Abreviatura, id: 'Abreviatura', name: 'Abreviatura', min: 1, max: 5, type: 'text' };
    let cO = { valorEtiqueta: CodigoObjeto, id: 'CodigoObjetoR',name: 'Codigo objeto de gasto', min: 1, max: 8, type: 'number' };
    let Es = { valorEtiqueta: Estado, id: 'Estado',name: 'Estado', type: 'select' };
    

    // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidObjeto = verificarInputText(oG,letrasEspaciosCaracteresRegex);
    let isValidAbreviatura = verificarInputText(aB,letrasEspaciosCaracteresRegex);
    let isValidCodigo = verificarInputNumber(cO,numerosRegex);
    let isValidEstado = verificarSelect(Es);

    // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
    if (
        (isValidObjeto === true) &&
        (isValidAbreviatura === true) &&
        (isValidEstado === true) &&
        (isValidCodigo === true) 
    ) {
        const dataNuevoCarrera = {
            idObjetoGasto: this.id,
            ObjetoDeGasto: ObjetoDeGasto.value,
            Abreviatura: Abreviatura.value,
            CodigoObjeto: CodigoObjeto.value,
            Estado: Estado.value
        };

        $.ajax({
            url: `${ API }/ObjetosGasto/RegistrarObjeto.php`, 
            method: 'POST',
            dataType: 'json',
            data: dataNuevoCarrera
        }).success(function(response) {
            console.log(response);
            Swal.fire({
                icon: 'success',
                title: 'Listo',
                text: 'Registro insertado con exito',
            });
            obtenerCarreras();
        }).error(function(error) {
            console.log(error);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'El registro del objeto del gasto no se pudo realizar',
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
        });
    } else { // caso contrario mostrar alerta y notificar al usuario 
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro del objeto del gasto no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        })
    }
};