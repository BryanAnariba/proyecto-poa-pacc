var estado = 1;
let idDimensionSeleccionada = null;
let idDimensionAdminSeleccionada = null;
let idObjetivoSeleccionado = null;
let idAreaEstrategicaSeleccionada = null;
let idActividadSeleccionada = null;
let costoTotalActividadSeleccionada = null;
let idDescripcionItemSeleccionada = null;
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
                    $('#Actividades-Por-Dimension tbody').html(``);
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
                            <button type="button" class="btn btn-amber" onclick="agregarDesglose('${ data[i].idActividad }', '${ data[i].CostoTotal }','${ data[i].idDimension }')">
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

const agregarDesglose = (idActividad, costoTotal, idDimension) => {
    idActividadSeleccionada = idActividad;
    costoTotalActividadSeleccionada = costoTotal;
    idDimensionSeleccionada = idDimension;
    console.log(idDimensionSeleccionada)
    $('#CostoT').val(costoTotalActividadSeleccionada).trigger('change');
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

const abrirModalRegistroDimensionAdmin = () => {
    $('#modalRegistroDimensionAdmin').modal('show');

}

const registraItemAdministrativo = () => {
    $('#modalRegistroDimensionAdmin').modal('show');
    
    $('#modificarItems').addClass('d-none');
    $('#insertarItems').removeClass('d-none');
}

const generaTablasAcordeDimension = (object) => {
    idDimensionAdminSeleccionada = object.value;
    let parametro = { idActividad: parseInt(idActividadSeleccionada), idDimensionAdmin: parseInt(object.value) };
    console.log(object.value)
    $.when(
        $.ajax(`${ API }/ObjetosGasto/listar-objetos-gasto-activos.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
        }),
        $.ajax(`${ API }/tipo-presupuestos/listar-tipo-presupuestos-actuales.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
        }),
        $.ajax(`${ API }/descripcion-administrativa/listar-descripciones-administrativas.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametro)
        }))
        .done(function(objetosGasto, tipoPresupuestos, descripcionesAdministrativas) {
            $('#ObjGasto').html(`<option value="" selected>Seleccione Objeto Gasto</option>`);
            $('#TipoPresupuesto').html(`<option value="" selected>Seleccione Tipo Presupuesto</option>`);
            let objetosGastos = objetosGasto[0].data;
            let presupuestos = tipoPresupuestos[0].data;
            const { data } = descripcionesAdministrativas[0];

            console.log(objetosGastos);
            console.log(presupuestos);
            console.log(data);
            for (let i=0;i<objetosGastos.length;i++) {
                $('#ObjGasto').append(`
                <option value="${ objetosGastos[i].idObjetoGasto }">${ objetosGastos[i].abrev } - ${ objetosGastos[i].DescripcionCuenta }</option>
                `);
            }
            $('#ObjGasto').select2();

            for(let i=0;i<presupuestos.length;i++) {
                $('#TipoPresupuesto').append(`
                    <option value="${ presupuestos[i].idTipoPresupuesto }">${ presupuestos[i].tipoPresupuesto }</option>
                `)
            }
            
            switch (parseInt(object.value)) {
                case 1:
                    $('#modalDimensionesAdmin1').modal('show');
                    $('#dimension-1-campo').removeClass('d-none');
                    $('#dimension-2-campo').addClass('d-none');
                    $('#dimension-4-campo').addClass('d-none');
                    $('#dimension-6-campo').addClass('d-none');
                    $('#dimension-7-campo').addClass('d-none');
                    $('#dimension-8-campo').addClass('d-none');
                    $('#dimension-administrativa-1').dataTable().fnDestroy();
                    $('#dimension-administrativa-1 tbody').html(``);
                    for(let i=0;i<data.length; i++) {
                        let descripcion = JSON.parse(data[i].Descripcion);
                        $('#dimension-administrativa-1 tbody').append(`
                            <tr align="center">
                                <td>
                                    ${ i + 1 }
                                </td>
                                <td>
                                    ${ data[i].Actividad }
                                </td>
                                <td>
                                    ${ descripcion.cantidadPersonas }
                                </td>
                                <td>
                                    ${ data[i].Cantidad }
                                </td>
                                <td>
                                    ${ data[i].Costo }
                                </td>
                                <td>
                                    ${ data[i].costoTotal }
                                </td>
                                <td>
                                    ${ data[i].tipoPresupuesto }
                                </td>
                                <td>
                                    ${ data[i].abrev }
                                </td>
                                <td>
                                    ${ data[i].descripcionCuenta }
                                </td>
                                <td>
                                    ${ data[i].dimensionEstrategica }
                                </td>
                                <td>
                                    ${ data[i].mesRequerido }
                                </td>
                                <td>
                                    <button type="button" class="btn btn-amber" onclick="modificarItem('${ data[i].Cantidad }','${ data[i].Costo }','${ data[i].idActividad }', '${ descripcion.cantidadPersonas }','${ data[i].idDescripcionAdministrativa }','${ data[i].idDimensionAdministrativa }', '${ data[i].mesRequerido }', '${ data[i].idObjetoGasto }', '${ data[i].abrev }' , '${ data[i].descripcionCuenta }', '${ data[i].idTipoPresupuesto }','${ data[i].tipoPresupuesto }')">
                                        <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                    </button>
                                </td>
                            </tr>
                        `)
                    }
                    $('#dimension-administrativa-1').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
                break;
                case 2:
                
                    $('#modalDimensionesAdmin2').modal('show');
                    $('#dimension-administrativa-2').dataTable().fnDestroy();
                    $('#dimension-administrativa-2 tbody').html(``);
                    $('#dimension-2-campo').removeClass('d-none');
                    $('#dimension-1-campo').addClass('d-none');
                    $('#dimension-4-campo').addClass('d-none');
                    $('#dimension-6-campo').addClass('d-none');
                    $('#dimension-7-campo').addClass('d-none');
                    $('#dimension-8-campo').addClass('d-none');
                    for(let i=0;i<data.length; i++) {
                        let descripcion = JSON.parse(data[i].Descripcion);
                        $('#dimension-administrativa-2 tbody').append(`
                            <tr align="center">
                            <td>
                                ${ i + 1 }
                            </td>
                            <td>
                                ${ data[i].Actividad }
                            </td>
                            <td>
                                ${ data[i].Cantidad }
                            </td>
                            <td>
                                ${ descripcion.meses}
                            </td>
                            <td>
                                ${ data[i].Costo }
                            </td>
                            <td>
                                ${ data[i].costoTotal }
                            </td>
                            <td>
                                ${ data[i].tipoPresupuesto }
                            </td>
                            <td>
                                ${ data[i].abrev }
                            </td>
                            <td>
                                ${ data[i].descripcionCuenta }
                            </td>
                            <td>
                                ${ data[i].dimensionEstrategica }
                            </td>
                            <td>
                                ${ data[i].mesRequerido }
                            </td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="modificarItem('${ data[i].Cantidad }','${ data[i].Costo }','${ data[i].idActividad }', '${ descripcion.meses }','${ data[i].idDescripcionAdministrativa }','${ data[i].idDimensionAdministrativa }', '${ data[i].mesRequerido }', '${ data[i].idObjetoGasto }', '${ data[i].abrev }' , '${ data[i].descripcionCuenta }', '${ data[i].idTipoPresupuesto }','${ data[i].tipoPresupuesto }')">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                        `)
                    }
                    $('#dimension-administrativa-2').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
                break;
                case 3:
                    $('#modalDimensionesAdmin3').modal('show');
                    $('#dimension-1-campo').addClass('d-none');
                    $('#dimension-2-campo').addClass('d-none');
                    $('#dimension-4-campo').addClass('d-none');
                    $('#dimension-6-campo').addClass('d-none');
                    $('#dimension-7-campo').addClass('d-none');
                    $('#dimension-8-campo').addClass('d-none');
                    $('#dimension-administrativa-3').dataTable().fnDestroy();
                    $('#dimension-administrativa-3 tbody').html(``);
                    for(let i=0;i<data.length; i++) {
                        $('#dimension-administrativa-3 tbody').append(`
                        <tr align="center">
                            <td>
                                ${ i + 1 }
                            </td>
                            <td>
                                ${ data[i].Actividad }
                            </td>
                            <td>
                                ${ data[i].Cantidad }
                            </td>
                            <td>
                                ${ data[i].Costo }
                            </td>
                            <td>
                                ${ data[i].costoTotal }
                            </td>
                            <td>
                                ${ data[i].tipoPresupuesto }
                            </td>
                            <td>
                                ${ data[i].abrev }
                            </td>
                            <td>
                                ${ data[i].descripcionCuenta }
                            </td>
                            <td>
                                ${ data[i].dimensionEstrategica }
                            </td>
                            <td>
                                ${ data[i].mesRequerido }
                            </td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="modificarItem('${ data[i].Cantidad }','${ data[i].Costo }','${ data[i].idActividad }', '${ null }','${ data[i].idDescripcionAdministrativa }','${ data[i].idDimensionAdministrativa }', '${ data[i].mesRequerido }', '${ data[i].idObjetoGasto }', ${ data[i].abrev } , '${ data[i].descripcionCuenta }', '${ data[i].idTipoPresupuesto }','${ data[i].tipoPresupuesto }')">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                        `)
                    }
                    $('#dimension-administrativa-3').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
                break;
                case 4:
                    $('#modalDimensionesAdmin4').modal('show');
                    $('#dimension-1-campo').addClass('d-none');
                    $('#dimension-2-campo').addClass('d-none');
                    $('#dimension-4-campo').removeClass('d-none');
                    $('#dimension-6-campo').addClass('d-none');
                    $('#dimension-7-campo').addClass('d-none');
                    $('#dimension-8-campo').addClass('d-none');
                    $('#dimension-administrativa-4').dataTable().fnDestroy();
                    $('#dimension-administrativa-4 tbody').html(``);
                    for(let i=0;i<data.length; i++) {
                        let descripcion = JSON.parse(data[i].Descripcion);
                        $('#dimension-administrativa-4 tbody').append(`
                        <tr align="center">
                        <td>
                            ${ i + 1 }
                        </td>
                        <td>
                            ${ data[i].Actividad }
                        </td>
                        <td>
                            ${ data[i].Cantidad }
                        </td>
                        <td>
                            ${ data[i].Costo }
                        </td>
                        <td>
                            ${ data[i].costoTotal }
                        </td>
                        <td>
                            ${ data[i].tipoPresupuesto }
                        </td>
                        <td>
                            ${ data[i].abrev }
                        </td>
                        <td>
                            ${ data[i].descripcionCuenta }
                        </td>
                        <td>
                            ${ data[i].dimensionEstrategica }
                        </td>
                        <td>
                            ${ data[i].mesRequerido }
                        </td>
                        <td>
                            ${ descripcion.tipoEquipoTecnologico }
                        </td>
                        <td>
                            <button type="button" class="btn btn-amber" onclick="modificarItem('${ data[i].Cantidad }','${ data[i].Costo }','${ data[i].idActividad }', '${ descripcion.tipoEquipoTecnologico }','${ data[i].idDescripcionAdministrativa }','${ data[i].idDimensionAdministrativa }', '${ data[i].mesRequerido }', '${ data[i].idObjetoGasto }', '${ data[i].abrev }' , '${ data[i].descripcionCuenta }', '${ data[i].idTipoPresupuesto }','${ data[i].tipoPresupuesto }')">
                                <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                            </button>
                        </td>
                    </tr>
                        `)
                    }
                    $('#dimension-administrativa-4').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
                break;
                case 5:
                    $('#modalDimensionesAdmin5').modal('show');
                    $('#dimension-1-campo').addClass('d-none');
                    $('#dimension-2-campo').addClass('d-none');
                    $('#dimension-4-campo').addClass('d-none');
                    $('#dimension-6-campo').addClass('d-none');
                    $('#dimension-7-campo').addClass('d-none');
                    $('#dimension-8-campo').addClass('d-none');
                    $('#dimension-administrativa-5').dataTable().fnDestroy();
                    $('#dimension-administrativa-5 tbody').html(``);
                    for(let i=0;i<data.length; i++) {
                        $('#dimension-administrativa-5 tbody').append(`
                        <tr align="center">
                            <td>
                                ${ i + 1 }
                            </td>
                            <td>
                                ${ data[i].Actividad }
                            </td>
                            <td>
                                ${ data[i].Cantidad }
                            </td>
                            <td>
                                ${ data[i].Costo }
                            </td>
                            <td>
                                ${ data[i].costoTotal }
                            </td>
                            <td>
                                ${ data[i].tipoPresupuesto }
                            </td>
                            <td>
                                ${ data[i].abrev }
                            </td>
                            <td>
                                ${ data[i].descripcionCuenta }
                            </td>
                            <td>
                                ${ data[i].dimensionEstrategica }
                            </td>
                            <td>
                                ${ data[i].mesRequerido }
                            </td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="modificarItem('${ data[i].Cantidad }','${ data[i].Costo }','${ data[i].idActividad }', '${ null }','${ data[i].idDescripcionAdministrativa }','${ data[i].idDimensionAdministrativa }', '${ data[i].mesRequerido }', '${ data[i].idObjetoGasto }', '${ data[i].abrev }' , '${ data[i].descripcionCuenta }', '${ data[i].idTipoPresupuesto }','${ data[i].tipoPresupuesto }')">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                        `)
                    }
                    $('#dimension-administrativa-5').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
                break;
                case 6:
                    $('#modalDimensionesAdmin6').modal('show');
                    $('#dimension-1-campo').addClass('d-none');
                    $('#dimension-2-campo').addClass('d-none');
                    $('#dimension-4-campo').addClass('d-none');
                    $('#dimension-6-campo').removeClass('d-none');
                    $('#dimension-7-campo').addClass('d-none');
                    $('#dimension-8-campo').addClass('d-none');
                    $('#dimension-administrativa-6').dataTable().fnDestroy();
                    $('#dimension-administrativa-6 tbody').html(``);
                    for(let i=0;i<data.length; i++) {
                        let descripcion = JSON.parse(data[i].Descripcion);
                        $('#dimension-administrativa-6 tbody').append(`
                        <tr align="center">
                        <td>
                            ${ i + 1 }
                        </td>
                        <td>
                            ${ data[i].Actividad }
                        </td>
                        <td>
                            ${ data[i].Cantidad }
                        </td>
                        <td>
                            ${ data[i].Costo }
                        </td>
                        <td>
                            ${ data[i].costoTotal }
                        </td>
                        <td>
                            ${ data[i].tipoPresupuesto }
                        </td>
                        <td>
                            ${ data[i].abrev }
                        </td>
                        <td>
                            ${ data[i].descripcionCuenta }
                        </td>
                        <td>
                            ${ data[i].dimensionEstrategica }
                        </td>
                        <td>
                            ${ data[i].mesRequerido }
                        </td>
                        <td>
                            ${ descripcion.areaBeca }
                        </td>
                        <td>
                            <button type="button" class="btn btn-amber" onclick="modificarItem('${ data[i].Cantidad }','${ data[i].Costo }','${ data[i].idActividad }', '${ descripcion.areaBeca }','${ data[i].idDescripcionAdministrativa }','${ data[i].idDimensionAdministrativa }', '${ data[i].mesRequerido }', '${ data[i].idObjetoGasto }', '${ data[i].abrev }' , '${ data[i].descripcionCuenta }', '${ data[i].idTipoPresupuesto }','${ data[i].tipoPresupuesto }')">
                                <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                            </button>
                        </td>
                    </tr>
                        `)
                    }
                    $('#dimension-administrativa-6').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
                break;
                case 7:
                    $('#modalDimensionesAdmin7').modal('show');
                    $('#dimension-1-campo').addClass('d-none');
                    $('#dimension-2-campo').addClass('d-none');
                    $('#dimension-4-campo').addClass('d-none');
                    $('#dimension-6-campo').addClass('d-none');
                    $('#dimension-7-campo').removeClass('d-none');
                    $('#dimension-8-campo').removeClass('d-none');
                    $('#dimension-administrativa-7').dataTable().fnDestroy();
                    $('#dimension-administrativa-7 tbody').html(``);
                    for(let i=0;i<data.length; i++) {
                        let descripcion = JSON.parse(data[i].Descripcion);
                        $('#dimension-administrativa-7 tbody').append(`
                        <tr align="center">
                        <td>
                            ${ i + 1 }
                        </td>
                        <td>
                            ${ data[i].Actividad }
                        </td>
                        <td>
                            ${ data[i].Cantidad }
                        </td>
                        <td>
                            ${ data[i].Costo }
                        </td>
                        <td>
                            ${ data[i].costoTotal }
                        </td>
                        <td>
                            ${ data[i].tipoPresupuesto }
                        </td>
                        <td>
                            ${ data[i].abrev }
                        </td>
                        <td>
                            ${ data[i].descripcionCuenta }
                        </td>
                        <td>
                            ${ data[i].dimensionEstrategica }
                        </td>
                        <td>
                            ${ data[i].mesRequerido }
                        </td>
                        <td>
                            ${ descripcion.proyecto }
                        </td>
                        <td>
                            <button type="button" class="btn btn-amber" onclick="modificarItem('${ data[i].Cantidad }','${ data[i].Costo }','${ data[i].idActividad }', '${ descripcion.proyecto }','${ data[i].idDescripcionAdministrativa }','${ data[i].idDimensionAdministrativa }', '${ data[i].mesRequerido }', '${ data[i].idObjetoGasto }', '${ data[i].abrev }' , '${ data[i].descripcionCuenta }', '${ data[i].idTipoPresupuesto }','${ data[i].tipoPresupuesto }')">
                                <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                            </button>
                        </td>
                    </tr>
                        `)
                    }
                    $('#dimension-administrativa-7').DataTable({
                        language: i18nEspaniol,
                        retrieve: true
                    });
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
} 

const modificarItem = (cantidad, costo, idActividad, descripcion, idDescripcionAdmin, idDimensionAdministrativa, mesRequerido, idObjetoGasto, abrev, descripcionCuenta, idTipoPresupuesto, tipoPresupuesto) => {
    idActividadSeleccionada = idActividad;
    idDimensionAdminSeleccionada = idDimensionAdministrativa;
    idDescripcionItemSeleccionada = idDescripcionAdmin;
    console.log(abrev);
    console.log(idObjetoGasto)
    $('#modificarItems').removeClass('d-none');
    $('#insertarItems').addClass('d-none');

    $('#Cantidad').val(cantidad).trigger('change');
    $('#Costo').val(costo).trigger('change');
    $('#MesRequerido').append(`<option value="${ mesRequerido }" selected>${ mesRequerido }</option>`);
    $('#ObjGasto').html(`<option value="${ idObjetoGasto }" selected>${ abrev } - ${ descripcionCuenta }</option>`)
    $('#TipoPresupuesto').html(`<option value="${ idTipoPresupuesto }" selected>${ tipoPresupuesto }</option>`)
    $.when(
        $.ajax(`${ API }/ObjetosGasto/listar-objetos-gasto-activos.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
        }),
        $.ajax(`${ API }/tipo-presupuestos/listar-tipo-presupuestos-actuales.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
    }))
    .done(function(objetosGasto, tipoPresupuestos) {
        let objetosGastos = objetosGasto[0].data;
        let presupuestos = tipoPresupuestos[0].data;
        console.log(objetosGastos);
        console.log(presupuestos);
        for (let i=0;i<objetosGastos.length;i++) {
            $('#ObjGasto').append(`
            <option value="${ objetosGastos[i].idObjetoGasto }">${ objetosGastos[i].abrev } - ${ objetosGastos[i].DescripcionCuenta }</option>
            `);
        }
        $('#ObjGasto').select2();

        for(let i=0;i<presupuestos.length;i++) {
            $('#TipoPresupuesto').append(`
                <option value="${ presupuestos[i].idTipoPresupuesto }">${ presupuestos[i].tipoPresupuesto }</option>
            `)
        }
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

    switch (parseInt(idDimensionAdministrativa)) {
        case 1:
            $('#dimension-1-campo').removeClass('d-none');
            $('#CantidadPersonas').val(descripcion).trigger('change');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
            $('#dimension-8-campo').addClass('d-none');
        break;
        case 2:
            $('#dimension-2-campo').removeClass('d-none');
            $('#Meses').val(descripcion).trigger('change');
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
            $('#dimension-8-campo').addClass('d-none');
        break;
        case 3:
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
            $('#dimension-8-campo').addClass('d-none');
        break;
        case 4:
            $('#dimension-1-campo').addClass('d-none');
            $('#TipoEquipoTecnologico').val(descripcion).trigger('change');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').removeClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
            $('#dimension-8-campo').addClass('d-none');
        break;
        case 5:
            $('#dimension-1-campo').addClass('d-none');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
            $('#dimension-8-campo').addClass('d-none');
        break;
        case 6:
            $('#dimension-1-campo').addClass('d-none');
            $('#AreaBeca').val(descripcion).trigger('change');
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').removeClass('d-none');
            $('#dimension-7-campo').addClass('d-none');
            $('#dimension-8-campo').addClass('d-none');
        break;
        case 7:
            $('#dimension-1-campo').addClass('d-none');
            $('#Proyecto').append(`<option value="${ descripcion }" selected>${ descripcion }</option>`)
            $('#dimension-2-campo').addClass('d-none');
            $('#dimension-4-campo').addClass('d-none');
            $('#dimension-6-campo').addClass('d-none');
            $('#dimension-7-campo').removeClass('d-none');
            $('#dimension-8-campo').addClass('d-none');
        break;
        case 8:
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
    $('#modalRegistroDimensionAdmin').modal('show');
}

const modificarAct = () => {
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
                    idDescripcionAdministrativa: parseInt(idDescripcionItemSeleccionada),
                    idActividad: parseInt(idActividadSeleccionada),
                    idObjetoGasto: parseInt(ObjGasto.value),
                    idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                    idDimension: parseInt(idDimensionAdminSeleccionada),
                    cantidad: Cantidad.value,
                    costo:  Costo.value,
                    costoTotal: CostoT.value,
                    mesRequerido: Mes.value,
                    descripcion: { cantidadPersonas: CantidadPersonas.value }
                }
                console.log(parametros);
                $.ajax(`${ API }/descripcion-administrativa/modifica-descripcion-administrativa.php`,{ 
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        console.log(data); 
                        $('#modalRegistroDimensionAdmin').modal('hide');
                        Swal.fire({
                        icon: 'success',
                        title: 'Accion realizada Exitosamente',
                        text: `${ data.message }`
                        });
                        generaTablasAcordeDimension(document.querySelector('#DimensionAdministrativa'));
                        vaciarAct();
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
                                footer: '<b>Verifique los datos del formulario de registro</b>'
                            });
                        }
                    }
                });
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro del item en la actividad seleccionada no se pudo realizar',
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
                    idDescripcionAdministrativa: parseInt(idDescripcionItemSeleccionada),
                    idActividad: parseInt(idActividadSeleccionada),
                    idObjetoGasto: parseInt(ObjGasto.value),
                    idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                    idDimension: parseInt(idDimensionAdminSeleccionada),
                    cantidad: Cantidad.value,
                    costo:  Costo.value,
                    costoTotal: CostoT.value,
                    mesRequerido: Mes.value,
                    descripcion: { meses: meses.value }
                }
                console.log(parametros);
                $.ajax(`${ API }/descripcion-administrativa/modifica-descripcion-administrativa.php`,{ 
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        $('#modalRegistroDimensionAdmin').modal('hide');
                        console.log(data); 
                        Swal.fire({
                        icon: 'success',
                        title: 'Accion realizada Exitosamente',
                        text: `${ data.message }`
                        });
                        generaTablasAcordeDimension(document.querySelector('#DimensionAdministrativa'));
                        vaciarAct();
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
                                footer: '<b>Verifique los datos del formulario de registro</b>'
                            });
                        }
                    }
                });
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro del item en la actividad seleccionada no se pudo realizar',
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
                    idDescripcionAdministrativa: parseInt(idDescripcionItemSeleccionada),
                    idActividad: parseInt(idActividadSeleccionada),
                    idObjetoGasto: parseInt(ObjGasto.value),
                    idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                    idDimension: parseInt(idDimensionAdminSeleccionada),
                    cantidad: Cantidad.value,
                    costo:  Number(Costo.value),
                    costoTotal: CostoT.value,
                    mesRequerido: Mes.value,
                    descripcion: {}
                }
                console.log(parametros);
                $.ajax(`${ API }/descripcion-administrativa/modifica-descripcion-administrativa.php`,{ 
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        $('#modalRegistroDimensionAdmin').modal('hide');
                        console.log(data); 
                        Swal.fire({
                        icon: 'success',
                        title: 'Accion realizada Exitosamente',
                        text: `${ data.message }`
                        });
                        generaTablasAcordeDimension(document.querySelector('#DimensionAdministrativa'));
                        vaciarAct();
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
                                footer: '<b>Verifique los datos del formulario de registro</b>'
                            });
                        }
                    }
                });
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro del item en la actividad seleccionada no se pudo realizar',
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
                    idDescripcionAdministrativa: parseInt(idDescripcionItemSeleccionada),
                    idActividad: parseInt(idActividadSeleccionada),
                    idObjetoGasto: parseInt(ObjGasto.value),
                    idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                    idDimension: parseInt(idDimensionAdminSeleccionada),
                    cantidad: Cantidad.value,
                    costo:  Costo.value,
                    costoTotal: CostoT.value,
                    mesRequerido: Mes.value,
                    descripcion: { tipoEquipoTecnologico: tipoEquipoTecnologico.value }
                }
                console.log(parametros);
                $.ajax(`${ API }/descripcion-administrativa/modifica-descripcion-administrativa.php`,{ 
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        console.log(data); 
                        $('#modalRegistroDimensionAdmin').modal('hide');
                        Swal.fire({
                        icon: 'success',
                        title: 'Accion realizada Exitosamente',
                        text: `${ data.message }`
                        });
                        generaTablasAcordeDimension(document.querySelector('#DimensionAdministrativa'));
                        vaciarAct();
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
                                footer: '<b>Verifique los datos del formulario de registro</b>'
                            });
                        }
                    }
                });
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro del item en la actividad seleccionada no se pudo realizar',
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
                    idDescripcionAdministrativa: parseInt(idDescripcionItemSeleccionada),
                    idActividad: parseInt(idActividadSeleccionada),
                    idObjetoGasto: parseInt(ObjGasto.value),
                    idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                    idDimension: parseInt(idDimensionAdminSeleccionada),
                    cantidad: Cantidad.value,
                    costo:  Costo.value,
                    costoTotal: CostoT.value,
                    mesRequerido: Mes.value,
                    descripcion: {}
                }
                console.log(parametros);
                $.ajax(`${ API }/descripcion-administrativa/modifica-descripcion-administrativa.php`,{ 
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        $('#modalRegistroDimensionAdmin').modal('hide');
                        console.log(data); 
                        Swal.fire({
                        icon: 'success',
                        title: 'Accion realizada Exitosamente',
                        text: `${ data.message }`
                        });
                        generaTablasAcordeDimension($('#DimensionAdministrativa'));
                        vaciarAct();
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
                                footer: '<b>Verifique los datos del formulario de registro</b>'
                            });
                        }
                    }
                });
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro del item en la actividad seleccionada no se pudo realizar',
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
                    idDescripcionAdministrativa: parseInt(idDescripcionItemSeleccionada),
                    idActividad: parseInt(idActividadSeleccionada),
                    idObjetoGasto: parseInt(ObjGasto.value),
                    idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                    idDimension: parseInt(idDimensionAdminSeleccionada),
                    cantidad: Cantidad.value,
                    costo:  Costo.value,
                    costoTotal: CostoT.value,
                    mesRequerido: Mes.value,
                    descripcion: { areaBeca: areaBeca.value }
                }
                console.log(parametros);
                $.ajax(`${ API }/descripcion-administrativa/modifica-descripcion-administrativa.php`,{ 
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    data: JSON.stringify(parametros),
                    success:function(response) {
                        const { data } = response;
                        console.log(data); 
                        $('#modalRegistroDimensionAdmin').modal('hide');
                        Swal.fire({
                        icon: 'success',
                        title: 'Accion realizada Exitosamente',
                        text: `${ data.message }`
                        });
                        generaTablasAcordeDimension($('#DimensionAdministrativa'));
                        vaciarAct();
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
                                footer: '<b>Verifique los datos del formulario de registro</b>'
                            });
                        }
                    }
                });
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro del item en la actividad seleccionada no se pudo realizar',
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
                    idDescripcionAdministrativa: parseInt(idDescripcionItemSeleccionada),
                    idActividad: parseInt(idActividadSeleccionada),
                    idObjetoGasto: parseInt(ObjGasto.value),
                    idTipoPresupuesto: parseInt(TipoPresupuesto.value),
                    idDimension: parseInt(idDimensionAdminSeleccionada),
                    cantidad: Cantidad.value,
                    costo:  Costo.value,
                    costoTotal: CostoT.value,
                    mesRequerido: Mes.value,
                    descripcion: { proyecto: proyectos.value }
                }
                console.log(parametros);
                $.ajax(`${ API }/descripcion-administrativa/modifica-descripcion-administrativa.php`,{ 
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
                        text: `${ data.message }`
                        });
                        $('#modalRegistroDimensionAdmin').modal('hide');
                        generaTablasAcordeDimension($('#DimensionAdministrativa'));
                        vaciarAct();
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
                                footer: '<b>Verifique los datos del formulario de registro</b>'
                            });
                        }
                    }
                });
            } else { // caso contrario mostrar alerta y notificar al usuario 
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: 'El registro del item en la actividad seleccionada no se pudo realizar',
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
