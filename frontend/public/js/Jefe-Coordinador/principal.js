var estado = 1;
let idDimensionSeleccionada = null;
let idObjetivoSeleccionado = null;
let idAreaEstrategicaSeleccionada = null;
$(document).ready(function(){
    // Manejo del estado de la dimension.
    if(estado==0){
        $("#mda").css("opacity", "0.6");
        $("#mda div div button").prop('disabled', true);
        $("#aga").css("opacity", "0.6");
        $("#aga div div button").prop('disabled', true);
    }else{
        $("#mda").css("opacity", "1");
        $("#mda div div button").prop('disabled', false);
        $("#aga").css("opacity", "1");
        $("#aga div div button").prop('disabled', false);
    }
    $("#ventana2").css("display","none");
    $("#ventana3").css("display","none");
    $(".foot-modif").css("display","none");
    $("#ventana1A").css("display","none");
    $(".foot-agr").css("display","none");


    $("body").click(function(){
        $('#modalFormLlenadoDimension').on('hidden.bs.modal', function () {
            if(($("#modalLlenadoActividades").data('bs.modal') || {})._isShown != true){
                $('#modalLlenadoDimension').modal('show');
                $('body').addClass('modal-open');
            }else{
                $('body').addClass('modal-open');
            }
        })
        $('#modalLlenadoActividades').on('hidden.bs.modal', function () {
            //$('#modalFormLlenadoDimension').modal('show');
            $('body').addClass('modal-open');
        })
    });
});
const avanzarA = () =>{
    $("#ventana1").css("display","none");
    $("#ventana2").css("display","block");
    llenar("DimensionesTablaModificar3");
}
const avanzarB = () =>{
    $("#ventana1").css("display","none");
    $("#ventana2").css("display","none");
    $("#ventana3").css("display","block");
    $(".foot-modif").css("display","block");
}
const avanzarAgreg = ()=>{
    $("#ventanaA").css("display","none");
    $("#ventana1A").css("display","block");
    $(".foot-agr").css("display","block");
};
const llenar = (tabla) => {
    $('#'+tabla).dataTable().fnDestroy();
    $('#'+tabla+' tbody').html(``);
    switch(tabla) {
        case 'DimensionesTabla':
            $.ajax(`${ API }/actividades/lista-actividades-por-dimension.php`, {
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                success:function(response) {
                    const { data } = response;
                    
                    console.log(data);
                    for (let i=0;i<data.length; i++) {
                        if(data[i].cantidadActividadesPorDimension === 0){
                            $('#DimensionesTabla tbody').append(`
                                <tr align="center">
                                    <td>
                                        <div class="rojo" row>
                                            <i class="fas fa-exclamation"></i><div style="display:none"></div>
                                        </div>
                                    </td>
                                    <td>${ data[i].dimensionEstrategica }</td>
                                    <td>
                                        <button type="button" class="btn btn-amber cambioModal" onclick="avanzar('${ data[i].idDimension }','${ data[i].dimensionEstrategica }')">
                                            <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                        </button>
                                    </td>
                                </tr>
                            `);
                        } else if(data[i].cantidadActividadesPorDimension > 0){
                            $('#DimensionesTabla tbody').append(`
                                <tr align="center">
                                    <td>
                                        <div class="verde row">
                                            <i class="fas fa-exclamation"></i><div style="display:none"></div>
                                        </div>
                                    </td>
                                    <td>${ data[i].dimensionEstrategica }</td>
                                    <td>
                                        <button type="button" class="btn btn-amber cambioModal" onclick="avanzar('${ data[i].idDimension }','${ data[i].dimensionEstrategica }')">
                                            <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                        </button>
                                    </td>
                                </tr>
                            `);
                        }
                    };
                    $('#'+tabla).DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
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
        break;
        case 'DimensionesTablaModificar':
            $('#Actividades-Por-Dimension').dataTable().fnDestroy();
            $("#ventana1").css("display","block");
            $("#ventana2").css("display","none");
            $("#ventana3").css("display","none");
            $(".foot-modif").css("display","none");
            $.ajax(`${ API }/actividades/lista-actividades-por-dimension.php`, {
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                success:function(response) {
                    const { data } = response;
                    console.log(data);
                    for (let i=0;i<data.length; i++) {
                        $('#Actividades-Por-Dimension tbody').append(`
                            <tr align="center">
                                <td>${ i + 1 }</td>
                                <td>${ data[i].dimensionEstrategica }</td>
                                <td>
                                    <button type="button" class="btn btn-amber cambioModal" onclick="verActividades('${ data[i].idDimension }','${ data[i].dimensionEstrategica }')">
                                        <img src="../img/menu/ver-icon.svg" alt="ver actividades dimension"/>
                                    </button>
                                </td>
                            </tr>
                        `);
                    };
                    $('#Actividades-Por-Dimension').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
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
        break;
        case 'DimensionesTablaModificar3':
            for (let i=0;i<this.arreglo.length; i++) {
                if(this.arreglo[i].estado=="pendiente"){
                    
                }else if(this.arreglo[i].estado=="llena"){
                    $('#DimensionesTablaModificar3 tbody').append(`
                        <tr align="center">
                            <td>
                                <div class="verde row">
                                    <i class="fas fa-exclamation"></i><div style="display:none">${this.arreglo[i].estado}</div>
                                </div>
                            </td>
                            <td>${ this.arreglo[i].dimension }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="avanzarB()">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }
            };
        break;
        case 'DimensionesTablaAgregar':
            for (let i=0;i<this.arreglo.length; i++) {
                if(this.arreglo[i].estado=="pendiente"){
                    
                }else if(this.arreglo[i].estado=="llena"){
                    $('#DimensionesTablaAgregar tbody').append(`
                        <tr align="center">
                            <td>
                                <div class="verde row">
                                    <i class="fas fa-exclamation"></i><div style="display:none">${this.arreglo[i].estado}</div>
                                </div>
                            </td>
                            <td>${ this.arreglo[i].dimension }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="avanzarAgreg()">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }
            };
        break;
        default:
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'No se puede avanzar, la opcion no es valida',
                footer: '<b>Vuela a realizar todos los pasos</b>'
            })
    };
};

const avanzar = (idDimension,dimensionEstrategica) =>{ 
    $('#ObjInstitucional').append(`<option value="" selected>Seleccione Objetivo Institucional</option>`);
    $('#AreaEstrategica').append(`<option value="" selected>Seleccione Area Estrategica</option>`);
    $('#selecciona-registro-area').addClass('d-none');
    $('#ObjInstitucional').html(``);
    console.log(dimensionEstrategica);
    $('#DimEstrategica').html(`<option value="${ idDimension }">${ dimensionEstrategica }</option>`);
    let parametros = { 
        idDimension: parseInt(idDimension)
    };

    $.when(
        $.ajax(`${ API }/objetivos-institucionales/listar-objetivos-activos-por-dimension.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros)
        }),
        $.ajax(`${ API }/actividades/genera-comparativo-presupuestos.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json'
        })) 
        .done(function(objetivoResponse, comparativaPresupuestosResponse) {
            let listadoObjetivos = objetivoResponse[0].data;
            let comparativaPresupuestoTotalUsuado = comparativaPresupuestosResponse[0].data;
            $('#ObjInstitucional').append(`<option value="" selected>Seleccione Objetivo Institucional</option>`);
            for(let i=0; i<listadoObjetivos.length; i++) {
                $('#ObjInstitucional').append(`
                    <option value="${ listadoObjetivos[i].idObjetivoInstitucional }">${ listadoObjetivos[i].objetivoInstitucional }</option>
                `);
            }
            console.log(comparativaPresupuestoTotalUsuado)
            $('#PresupuestoUtilizado').val(Number(comparativaPresupuestoTotalUsuado.presupuestoConsumidoPorDepto))
            $('#PresupuestoDisponible').val(Number(comparativaPresupuestoTotalUsuado.presupuestoTotalDepartamento))
            $('#modalLlenadoDimension').modal('hide');
            $('#modalFormLlenadoDimension').modal('show');
        })
        .fail(function(error) {
            console.log('Something went wrong', error);
            const { status, data } = error.responseJSON;
            if (status === 401) {
                window.location.href = '../views/401.php';
            }
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
                footer: '<b>Recargue la pagina nuevamente</b>'
            })
        });
};

const cargarAreasEstrategicasActivas = () => {
    $('#AreaEstrategica').html(``);
    let parametros = {
        idObjetivo: parseInt($('#ObjInstitucional').val())
    };
    $.ajax(`${ API }/areas-estrategicas/listar-areas-por-objetivo-activas.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(parametros),
        success:function(response) {
            $('#selecciona-registro-area').removeClass('d-none');
            const { data } = response;
            console.log(data);
            $('#AreaEstrategica').append(`<option value="" selected>Seleccione Area Estrategica</option>`);
            for(let i=0; i<data.length; i++) {
                $('#AreaEstrategica').append(`
                    <option value="${ data[i].idAreaEstrategica }">${ data[i].areaEstrategica }</option>
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
}

const verActividades = (idDimension) => {
    let parametros = { idDimension: parseInt(idDimension) };
    
    $.ajax(`${ API }/actividades/listar-actividades-dimension.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        data: JSON.stringify(parametros),
        success:function(response) {
            const { data } = response;
            console.log(data);
            $('#listado-actividades').dataTable().fnDestroy();
            $('#listado-actividades tbody').html(``);
            for(let i=0;i<data.length; i++) {
                $('#listado-actividades tbody').append(`
                    <tr align="center">
                        <td>
                            ${ i + 1 }
                        </td>
                        <td>
                            ${ data[i].objetivoInstitucional }
                        </td>
                        <td>
                            ${ data[i].areaEstrategica }
                        </td>
                        <td>
                            ${ data[i].resultadoInstitucional }
                        </td>
                        <td>
                            ${ data[i].resultadosUnidad }
                        </td>
                        <td>
                            ${ data[i].indicadoresResultado }
                        </td>
                        <td>
                            ${ data[i].correlativoActividad }
                        </td>
                        <td>
                            ${ data[i].actividad }
                        </td>
                        <td>
                            ${ data[i].porcentajeTrimestre1 }
                        </td>
                        <td>
                            ${ data[i].Trimestre1 }
                        </td>
                        <td>
                            ${ data[i].porcentajeTrimestre2 }
                        </td>
                        <td>
                            ${ data[i].Trimestre2 }
                        </td>
                        <td>
                            ${ data[i].porcentajeTrimestre3 }
                        </td>
                        <td>
                            ${ data[i].Trimestre3 }
                        </td>
                        <td>
                            ${ data[i].porcentajeTrimestre4 }
                        </td>
                        <td>
                            ${ data[i].Trimestre4 }
                        </td>
                        <td>
                            ${ data[i].sumatoriaPorcentaje }
                        </td>
                        <td>
                            ${ data[i].CostoTotal }
                        </td>
                        <td>
                            <button type="button" class="btn btn-amber" onclick="agregarDesglose('${ data[i].idActividad }')">
                                <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                            </button>
                        </td>
                    </tr>
                `)
            }
            $('#listado-actividades').DataTable({
                language: i18nEspaniol,
                retrieve: true
            });
            $('#modalCargaActividades').modal('show');
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
}

const agregarDesglose = () => {
    $('#modalActividad').modal('show');
    $('#DimensionAdministrativa').html(`<option value="" selected>Seleccione una dimension administrativa</option>`);
    $.ajax(`${ API }/dimensiones-administrativas/listar-dimensiones-activas.php`,{
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function(response) {
            const { data } = response;
            for(let i=0;i<data.length;i++) {
                $('#DimensionAdministrativa').append(`
                    <option value="${ data[i].idDimension }">
                        ${ data[i].dimensionAdministrativa }
                    </option>`);
            }
        },
        error:function(error){
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
}

const generaTablasAcordeDimension = (object) => {
    
    console.log(object.value)
    $.when(
        $.ajax(`${ API }/ObjetosGasto/listar-objetos-gasto-activos.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
        }))
        .done(function(objetosGasto) {
            $('#ObjGasto').html(`<option value="" selected>Seleccione Objeto Gasto</option>`)
            let objetosGastos = objetosGasto.data;
            console.log(objetosGastos)
            for (let i=0;i<objetosGastos.length;i++) {
                $('#ObjGasto').append(`
                <option value="${ objetosGastos[i].idObjetoGasto }">${ objetosGastos[i].abrev } - ${ objetosGastos[i].DescripcionCuenta }</option>
                `);
            }
            $('#ObjGasto').select2();
        })
        .fail(function(error) {
            console.log('Something went wrong', error);
            const { status, data } = error.responseJSON;
            if (status === 401) {
                window.location.href = '../views/401.php';
            }
            console.log(data);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
                footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    }); 
    switch (parseInt(object.value)) {
        case 1:
            $('#modalDimensionesAdmin1').modal('show');
            $('#dimension-1-campo').removeClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
        break;
        case 2:
            $('#modalDimensionesAdmin2').modal('show');
            $('#dimension-2-campo').removeClass('d-none');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
        break;
        case 3:
            $('#modalDimensionesAdmin3').modal('show');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
        break;
        case 4:
            $('#modalDimensionesAdmin4').modal('show');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').removeClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
        break;
        case 5:
            $('#modalDimensionesAdmin5').modal('show');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
        break;
        case 6:
            $('#modalDimensionesAdmin6').modal('show');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').removeClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
        break;
        case 7:
            $('#modalDimensionesAdmin7').modal('show');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').removeClass('d-none');
        break;
        case 8:
            $('#modalDimensionesAdmin8').modal('show');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
        break;
        default:
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'No se puede avanzar seleccione una dimension',
                footer: '<b>La opcion seleccionada no es valida</b>'
            })
        break;
    }
} 
