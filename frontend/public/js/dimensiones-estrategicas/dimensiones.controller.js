$(document).ready(function (){
    dimensionesEstrategicas();
});

let idDimensionSeleccionada;
let idObjetivoSeleccionado;
let idAreaEstrategicaSeleccionada;

let nombreDimension = document.querySelector('#R-nombreDimension');
let nD = { valorEtiqueta: nombreDimension, id: 'R-nombreDimension', name: 'Nombre Dimension', min: 1, max: 150, type: 'text' };
let nombreDimensionModificar = document.querySelector('#M-nombreDimension');
let nDM = { valorEtiqueta: nombreDimensionModificar, id: 'M-nombreDimension', name: 'Nombre Dimension', min: 1, max: 150, type: 'text' };

const cancelarRegistroDimension = () => {
    limpiarCamposFormulario(nD);
    $(`#R-nombreDimension`).trigger('reset');
}

const cancelarModificacionDimension = () => {
    limpiarCamposFormulario(nDM);
    $(`#M-nombreDimension`).trigger('reset');
}

const cancelarRegistroObjetivo = () => {
    limpiarCamposFormulario(nO);
    $(`#R-objetivoInstitucional`).trigger('reset');
}

const cancelarModificacionObjetivo = () => {
    limpiarCamposFormulario(nOM);
    $(`#R-objetivoInstitucional`).trigger('reset');
}

const cancelarRegistroArea = () => {
    limpiarCamposFormulario(nA);
    $(`#R-areaEstrategica`).trigger('reset');
}

const cancelarModificacionArea = () => {
    limpiarCamposFormulario(nAM);
    $(`#R-areaEstrategica`).trigger('reset');
}
                                    // Peticiones de las dimensiones estrategicas
const dimensionesEstrategicas = () => {
    $('#listado-dimensiones').dataTable().fnDestroy();
    // Cargar listado de dimensiones estrategicas
    $.ajax(`${ API }/dimensiones-estrategicas/listar-dimensiones.php`, {
    type: 'POST',
	dataType: 'json',
    contentType: 'application/json',
    success:function(response) {
        const { data } = response;
        console.log(data);
        $('#listado-dimensiones tbody').html(``);
        
        for (let i=0;i<data.length; i++) {
            $('#listado-dimensiones tbody').append(`
                <tr>
                    <td scope="row">${ i + 1 }</td>
                    <td>${ data[i].dimensionEstrategica }</td>
                    <td>
                        <button type="button" ${data[i].idEstadoDimension === 1 ? `class="btn btn-success" ` : `class="btn btn-danger" `}
                        onclick=(modificaEstadoDimension(${data[i].idDimension}))>
                            ${data[i].estado }
                        </button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick=(verObjetivosInstitucionales(${data[i].idDimension}))>
                            Objetivos Institucionales
                        </button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-amber" onclick="obtenerDimensionEstrategica('${data[i].dimensionEstrategica}','${data[i].idDimension}')">
                            <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                        </button>
                    </td>
                </tr>
            `)
        }
        $('#listado-dimensiones').DataTable({
            language: i18nEspaniol,
            //dom: 'Blfrtip',
            //buttons: botonesExportacion,
            retrieve: true
        });
    },
    error:function (error) {
        console.error(error);
    }});
}


// Registro dimenesion
const registrarDimension = () => { 
    let isValidNombreDimension = verificarInputText(nD);
    if (isValidNombreDimension===true) {
        $('#btn-registrar-dimension').prop('disabled', true);   
        let parametros = { dimensionEstrategica: nombreDimension.value };
        //console.log(parametros);

        $.ajax(`${ API }/dimensiones-estrategicas/registrar-dimension.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function(response) {
                $('#modalRegistroDimension').modal('hide');
                const { data } = response;
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                $('#btn-registrar-dimension').prop('disabled', false);
                // Carga y llenado de las dimensiones estrategicas
                dimensionesEstrategicas();
            },
            error:function(error) {
                const { data } = error.responseJSON;
                console.log(data);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`,
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                });
            }
        });

        // Limpieza del formulario
        limpiarCamposFormulario(nD);
    } else {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro de la dimension no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        })
    }
}

// Modificacion Estado Dimension
const modificaEstadoDimension = (idDimension) => {
    let parametros = { idDimensionEstrategica: parseInt(idDimension) };
    $.ajax(`${ API }/dimensiones-estrategicas/cambiar-estado-dimension.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(parametros),
        success:function(response) {
            const { data } = response;
            console.log(response);
            Swal.fire({
                icon: 'success',
                title: 'Accion realizada Exitosamente',
                text: `${ data.message }`,
            });

            // Carga y llenado de dimensiones estrategicas
            dimensionesEstrategicas();
        },
        error:function(error) {
            console.error(error);
            const { data } = error;
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
                footer: '<b>Por favor verifique el formulario de registro</b>'
            });
        }
    });
}


// Obtenemos la dimension estrategica a modificar
function obtenerDimensionEstrategica(dimensionEstrategica,idDimension) {
    console.log(dimensionEstrategica);
    console.log(idDimension);
    idDimensionSeleccionada = idDimension;
    $('#modalModificarDimension').modal('show');
    $('#M-nombreDimension').val(dimensionEstrategica);
}

// Modificamos la dimension
const modificarDimension = () => {
    let isValidNombreDimension = verificarInputText(nDM);
    if (isValidNombreDimension===true) {
        $('#btn-modificar-dimension').prop('disabled', true);
        let parametros = {
            idDimensionEstrategica: parseInt(idDimensionSeleccionada),
            dimensionEstrategica: nombreDimensionModificar.value
        };
        console.log(parametros);

        $.ajax(`${ API }/dimensiones-estrategicas/modificar-dimension.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function(response) {
                const { data } = response;
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                cancelarModificacionDimension();
                $('#btn-modificar-dimension').prop('disabled', false);
                $('#modalModificarDimension').modal('hide');
                dimensionesEstrategicas();
            },
            error:function(error) {
                const { data } = error;
                console.error(error);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`,
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                });
            }
        });
    } else {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro de la dimension no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        })
    }
}

                        // Peticiones de los objetivos institucionales
let nombreObjetivo = document.querySelector('#R-objetivoInstitucional');
let nO = { valorEtiqueta: nombreObjetivo, id: 'R-objetivoInstitucional', name: 'Objetivo Institucional', min: 1, max: 180, type: 'text' };
let nombreObjetivoModificar = document.querySelector('#M-objetivoInstitucional');
let nOM = { valorEtiqueta: nombreObjetivoModificar, id: 'M-objetivoInstitucional', name: 'Objetivo Institucional', min: 1, max: 180, type: 'text' };

const verObjetivosInstitucionales = (idDimension) => {
    idDimensionSeleccionada = idDimension;
    let parametros = { idDimensionEstrategica: parseInt(idDimension) };
    $('#listado-objetivos').dataTable().fnDestroy();
    // Cargar listado de dimensiones estrategicas
    $.ajax(`${ API }/objetivos-institucionales/listar-objetivos-por-dimension.php`, {
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json',
    data: JSON.stringify(parametros),
    success:function(response) {
        $('#modalObjetivosInstitucionales').modal('show');
        const { data } = response;
        console.log(data);
        $('#listado-objetivos tbody').html(``);
        
        for (let i=0;i<data.length; i++) {
            $('#listado-objetivos tbody').append(`
                <tr>
                    <td scope="row">${ i + 1}</td>
                    <td>${ data[i].ObjetivoInstitucional }</td>
                    <td>
                        <button type="button" ${data[i].idEstadoObjetivoInstitucional === 1 ? `class="btn btn-success" ` : `class="btn btn-danger" `}
                        onclick=(modificarEstadoObjetivo('${data[i].idObjetivoInstitucional}','${data[i].idEstadoObjetivoInstitucional}'))>
                            ${data[i].estado }
                        </button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="visualizarAreasEstrategicas('${data[i].idObjetivoInstitucional}')">
                            Areas Estrategicas
                        </button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-amber" onclick="obtenerObjetivoInstitucional('${data[i].idObjetivoInstitucional}','${data[i].ObjetivoInstitucional}')">
                            <img src="../img/menu/editar.svg" alt="modificar objetivos"/>
                        </button>
                    </td>
                </tr>
            `)
        }
        $('#listado-objetivos').DataTable({
            language: i18nEspaniol,
            //dom: 'Blfrtip',
            //buttons: botonesExportacion,
            retrieve: true
        });
    },
    error:function (error) {
        const { data } = error;
        console.error(error);
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: `${ data.message }`
        });
    }});
}

const registrarObjetivo = () => {
    let isValidNombreObjetivo = verificarInputText(nO);
    if (isValidNombreObjetivo===true) {
        $('#btn-registrar-objetivo').prop('disabled', true);   
        let parametros = {
            idDimensionEstrategica: parseInt(idDimensionSeleccionada),
            objetivoInstitucional: nombreObjetivo.value
        };
        console.log('Longitud de esta vaina => ', (parametros.objetivoInstitucional.length));
        console.log(parametros);
        $.ajax(`${ API }/objetivos-institucionales/registro-objetivo-por-dimension.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function (response) {
                const { data } = response;
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                $('#btn-registrar-objetivo').prop('disabled', false); 
                $('#modalRegistroObjetivo').modal('hide');
                verObjetivosInstitucionales(idDimensionSeleccionada);
                cancelarRegistroObjetivo();
            },
            error:function (error) {
                const { data } = error;
                console.error(error);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`
                });
            }
        });
    } else {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro del objetivo no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    }
}

const modificarEstadoObjetivo = (idObjetivo, idEstadoObjetivo) => {
    let parametros = { idObjetivo: parseInt(idObjetivo), idEstadoObjetivo: parseInt(idEstadoObjetivo) };
    console.log('Data -> ', parametros);
    $.ajax(`${ API }/objetivos-institucionales/modificar-estado-objetivo.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(parametros),
        success:function (response) {
            const { data } = response;
            console.log(response);
            Swal.fire({
                icon: 'success',
                title: 'Accion realizada Exitosamente',
                text: `${ data.message }`,
            });
            verObjetivosInstitucionales(idDimensionSeleccionada);
        },
        error:function (error) {
            const { data } = error;
            console.error(error);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`
            });
        }
    });
}

function obtenerObjetivoInstitucional (idObjetivo, objetivoInstitucional) {
    $('#modalModificarObjetivo').modal('show');
    idObjetivoSeleccionado = idObjetivo;
    $('#M-objetivoInstitucional').val(objetivoInstitucional);
}

const modificarObjetivoInstitucional = () => {
    let isValidNombreObjetivo = verificarInputText(nOM);
    if (isValidNombreObjetivo===true) {
        $('#btn-modificar-objetivo').prop('disabled', true);   
        let parametros = {
            idObjetivo: parseInt(idObjetivoSeleccionado),
            objetivoInstiucional: nombreObjetivoModificar.value
        };
        console.log('Data -> ', parametros);
        $.ajax(`${ API }/objetivos-institucionales/modificar-objetivo.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function (response) {
                const { data } = response;
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                $('#btn-modificar-objetivo').prop('disabled', false);
                verObjetivosInstitucionales(idDimensionSeleccionada);
                cancelarModificacionObjetivo();
                $('#modalModificarObjetivo').modal('hide');
            },
            error:function (error) {
                const { data } = error;
                console.error(error);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`
                });
            }
        });
    } else {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro de la dimension no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    }
}

                        // Peticiones de las areas estrategicas
let nombreArea = document.querySelector('#R-areaEstrategica');
let nA = { valorEtiqueta: nombreArea, id: 'R-areaEstrategica', name: 'Area Estrategica', min: 1, max: 200, type: 'text' };
let nombreAreaModificar = document.querySelector('#M-areaEstrategica');
let nAM = { valorEtiqueta: nombreAreaModificar, id: 'M-areaEstrategica', name: 'Area Estrategica', min: 1, max: 200, type: 'text' };
                        
const visualizarAreasEstrategicas = (idObjetivo) => {
    idObjetivoSeleccionado = idObjetivo;
    let parametros = { idObjetivo: parseInt(idObjetivo) };
    $.ajax(`${ API }/areas-estrategicas/listar-areas-por-objetivo.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(parametros),
        success:function (response) {
            const { data } = response;
            console.log(data);
            $('#modalAreasEstrategicas').modal('show');
            $('#listado-areas tbody').html(``);
        
            for (let i=0;i<data.length; i++) {
            $('#listado-areas tbody').append(`
                <tr>
                    <td scope="row">${ i + 1}</td>
                    <td>${ data[i].areaEstrategica }</td>
                    <td>
                        <button type="button" ${data[i].idEstadoAreaEstrategica === 1 ? `class="btn btn-success" ` : `class="btn btn-danger" `}
                        onclick=(modificarEstadoArea('${data[i].idAreaEstrategica}','${data[i].idEstadoAreaEstrategica}'))>
                            ${data[i].estado }
                        </button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-amber" onclick="obtenerAreaEstrategica('${data[i].idAreaEstrategica}','${data[i].areaEstrategica}')">
                            <img src="../img/menu/editar.svg" alt="modificar objetivos"/>
                        </button>
                    </td>
                </tr>
            `)
        }
        $('#listado-areas').DataTable({
            language: i18nEspaniol,
            //dom: 'Blfrtip',
            //buttons: botonesExportacion,
            retrieve: true
        });
        },
        error:function (error) {
            const { data } = error;
            console.error(error);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`
            });
        }
    });
}

const registrarArea = () => {
    let isValidArea = verificarInputText(nA);
    if (isValidArea===true) {
        $('#btn-registrar-area').prop('disabled', true);
        let parametros = {
            idObjetivo: parseInt(idObjetivoSeleccionado),
            areaEstrategica: nombreArea.value
        };
        console.log('Data -> ', parametros);
        $.ajax(`${ API }/areas-estrategicas/registrar-area-por-objetivo.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function (response) {
                const { data } = response;
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                $('#btn-registrar-area').prop('disabled', false);
                $('#modalRegistroArea').modal('hide');
                visualizarAreasEstrategicas(idObjetivoSeleccionado);
                cancelarRegistroArea();
            },
            error:function (error) {
                const { data } = error;
                console.error(error);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`
                });
            }
        });
    } else {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro del objetivo no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    }
}

const modificarEstadoArea = (idArea, idEstadoArea) => {
        let parametros = {
            idArea: parseInt(idArea),
            idEstadoArea: parseInt(idEstadoArea)
        };
        console.log('Data -> ', parametros);
        $.ajax(`${ API }/areas-estrategicas/cambiar-estado-area.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function (response) {
                const { data } = response;
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                visualizarAreasEstrategicas(idObjetivoSeleccionado);
            },
            error:function (error) {
                const { data } = error;
                console.error(error);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`
                });
            }
        });
    
}

function obtenerAreaEstrategica (idArea, areaEstrategica) {
    idAreaEstrategicaSeleccionada = idArea;
    $('#modalModificarArea').modal('show');
    $('#M-areaEstrategica').val(areaEstrategica);
}

const modificarAreaEstrategica = () => {
    let isValidNombreArea = verificarInputText(nAM);
    if (isValidNombreArea===true) {
        $('#btn-modificar-area').prop('disabled', true);
        let parametros = {
            idArea: parseInt(idAreaEstrategicaSeleccionada),
            areaEstrategica: nombreAreaModificar.value
        };
        console.log('Data -> ', parametros);
        $.ajax(`${ API }/areas-estrategicas/modificar-area.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function (response) {
                const { data } = response;
                console.log(response);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                $('#btn-modificar-area').prop('disabled', false);
                visualizarAreasEstrategicas(idObjetivoSeleccionado);
                cancelarModificacionArea();
                $('#modalModificarArea').modal('hide');
            },
            error:function (error) {
                const { data } = error;
                console.error(error);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`
                });
            }
        });
    } else {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro de la dimension no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    }
}

//$("input").prop('disabled', true);
//$("input").prop('disabled', false);