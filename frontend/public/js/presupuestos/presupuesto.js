const openModalRegistroPresupuesto = () => {
    $('#estadoPresupuestoAnual').html(``);
    $.ajax(`${ API }/estados/listar-estados.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function(response) {
            const { data } = response;
            $('#modalRegistrarPresupuestoAnual').modal('show');
            console.log(data);
            for(let i=0;i<data.length; i++) {
                $('#estadoPresupuestoAnual').append(`
                    <option value="${ data[i].idEstado }">${ data[i].estado }</option>
                `);
            }
        },
        error:function(error) {
            console.log(error);
            const { status, data } = error.responseJSON;
            if (status === 401) {
                window.location.href = '../views/401.php';
            }
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
            });
        }
    });
}

const registrarPresupuesto = () => {
    let presupuestoAnual = document.querySelector('#R-presupuestoAnual');
    let pA = { valorEtiqueta: presupuestoAnual, id: 'R-presupuestoAnual', name: 'Presupuesto Anual', min: 1, max: 15, type: 'number' };

    let isValidPresupuestoAnual = verificarInputNumber(pA, regexCampoMonetario);

    if (isValidPresupuestoAnual === true) {
        $('#btn-registrar-presupuesto').prop('disabled', true);
        let parametros = {
            presupuestoAnual: Number(presupuestoAnual.value),
            estadoPresupuestoAnual: parseInt($('#estadoPresupuestoAnual').val())
        };
        console.log(parametros);
        $.ajax(`${ API }/presupuestos/registrar-presupuesto-anual.php` , {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function(response) {
                const { data } = response;
                console.log(data);
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                $('#modalRegistrarPresupuestoAnual').modal('hide');
                cancelarRegistroPresupuesto();
                $('#btn-registrar-presupuesto').prop('disabled', false);
            },
            error:function(error) {
                cancelarRegistroPresupuesto();
                $('#btn-registrar-presupuesto').prop('disabled', false);
                console.log(error);
                const { status, data } = error.responseJSON;
                if (status === 401) {
                    window.location.href = '../views/401.php';
                }
                console.log(data);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`,
                });
            }
        });
    } else {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro del presupuesto no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    }
}

const cancelarRegistroPresupuesto = () => {
    let presupuestoAnual = document.querySelector('#R-presupuestoAnual');
    let pA = { valorEtiqueta: presupuestoAnual, id: 'R-presupuestoAnual', name: 'Presupuesto Anual', min: 1, max: 15, type: 'number' };
    limpiarCamposFormulario(pA);
    $('#R-presupuestoAnual').trigger('reset');
}
const cancelarModificacionPresupuesto = () => {
    let presupuestoAnual = document.querySelector('#M-presupuestoAnual');
    let pA = { valorEtiqueta: presupuestoAnual, id: 'M-presupuestoAnual', name: 'Presupuesto Anual', min: 1, max: 15, type: 'number' };
    limpiarCamposFormulario(pA);
    $('#M-presupuestoAnual').trigger('reset');
}

const listarPresupuestos = () => {
    $.ajax(`${ API }/presupuestos/listar-presupuestos.php` ,{
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function(response) {
            const { data } = response;
            console.log(data);
            $('#listado-presupuestos tbody').html(``);
            for (let i=0;i<data.length; i++) {
                $('#listado-presupuestos tbody').append(`
                    <tr class="my-auto">
                        <td class="my-auto">
                            <h5>${ i + 1 }</h5>
                        </td>
                        <td class="my-auto">
                            <h5>${ data[i].idControlPresupuestoActividad }</h5>
                        </td>
                        <td class="my-auto">
                            <h5>${ data[i].presupuestoAnual }</h5>
                        </td>
                        <td class="my-auto">
                            <h5>${ data[i].fechaPresupuesto }</h5>
                        </td>
                        <td class="my-auto">
                            <button type="button" class="btn btn-info btn-sm" onclick="">
                                <img src="../img/menu/ver-icon.svg" alt="Ver Mas"/>
                            </button>
                        </td>
                        <td class="my-auto">
                            <button type="button" class="btn btn-info btn-sm" onclick="modificarPresupuesto(${ data[i].idControlPresupuestoActividad })">
                                <img src="../img/menu/visualizar-icon.svg" alt="Modificar Presupuesto"/>
                            </button>
                        </td>
                    </tr>
                `)
            }
            $('#listado-presupuestos').DataTable({
                language: i18nEspaniol,
                //dom: 'Blfrtip',
                //buttons: botonesExportacion,
                retrieve: true
            });
        },
        error:function(error) {
            const { status, data } = error.responseJSON;
            if (status === 401) {
                window.location.href = '../views/401.php';
            }
            console.log(data);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
            });
        }
    });
}


let presupuestoAnualModificar = document.querySelector('#M-presupuestoAnual');
let pAM = { valorEtiqueta: presupuestoAnualModificar, id: 'M-presupuestoAnual', name: 'Presupuesto Anual', min: 1, max: 15, type: 'number' };
let idPresupuestoSeleccionado = null;
const modificarPresupuesto = (idControlPresupuestoActividad) => {
    
    $('#M-estadoPresupuestoAnual').html(``);
    idPresupuestoSeleccionado = idControlPresupuestoActividad;
    let parametros ={ idPresupuestoAnual: parseInt(idControlPresupuestoActividad) };
    $.when(
        $.ajax(`${ API }/presupuestos/verifica-presupuesto-modificar.php` , {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros)
        }),
        $.ajax(`${ API }/estados/listar-estados.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json'
    }))
    .done(function(presupuestoResponse, estadosResponse) {
        $('#M-presupuestoAnual').val(presupuestoResponse[0].data.presupuestoAnual).trigger('change');
        for(let i=0;i<estadosResponse[0].data.length; i++) {
            $('#M-estadoPresupuestoAnual').append(`
                <option value="${ estadosResponse[0].data[i].idEstado }">${ estadosResponse[0].data[i].estado }</option>
            `);
        }
        $('#modalModificarPresupuestoAnual').modal('show');
    })
    .fail(function(error) {
        const { status, data } = error.responseJSON;
        if (status === 401) {
            window.location.href = '../views/401.php';
        }
        console.log(data);
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: `${ data.message }`,
            footer: '<b>Por favor recargue la pagina</b>'
        });
    });
}

const modificaPresupuesto = () => {
    let isValidPresupuestoAnual = verificarInputNumber(pAM, regexCampoMonetario);
    if (isValidPresupuestoAnual === true) {
        let parametros = {
            idControlPresupuestoActividad: idPresupuestoSeleccionado,
            presupuestoAnual: Number(document.querySelector('#M-presupuestoAnual').value),
            estadoPresupuestoAnual: parseInt($('#M-estadoPresupuestoAnual').val())
        };
        console.log(parametros);
        $.ajax(`${ API }/presupuestos/modificar-presupuesto-anual.php` , {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function(response) {
                const { data } = response;
                $('#btn-modif-presupuesto').prop('disabled', false);
                $('#modalModificarPresupuestoAnual').modal('hide');
                $('#modalVisualizarPresupuesto').modal('hide');
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
            },
            error:function(error) {
                $('#btn-modif-presupuesto').prop('disabled', false);
                $('#modalModificarPresupuestoAnual').modal('hide');
                $('#modalVisualizarPresupuesto').modal('hide');
                console.log(error);
                const { status, data } = error.responseJSON;
                if (status === 401) {
                    window.location.href = '../views/401.php';
                }
                console.log(data);
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
            text: 'El registro del presupuesto no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    }
}