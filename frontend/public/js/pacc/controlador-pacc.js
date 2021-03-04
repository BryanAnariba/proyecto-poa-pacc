$( document ).ready(function() {
    // $('#listado-dimensiones').DataTable();
    // $('#listado-dimensiones tbody').html(``);
    // $('#listado-dimensiones').DataTable({
    //     language: i18nEspaniol,
    //     dom: 'Blfrtip',
    //     buttons: botonesExportacion,
    //     retrieve: true
    // });
    $.when(
        $.ajax(`${ API }/pacc/listado-presupuestos-departamento.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json'
        }),
        $.ajax(`${ API }/pacc/listar-comparativa-presupuestos.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json'
        })).done(function(dataDepartamentos, dataComparativaPresupuestos) {
            let response = dataDepartamentos[0];
            const { data } = response;
            $('#presupuestoAnual').val(dataComparativaPresupuestos[0].data.presupuestoAnual).trigger('change');
            $('#presupuestoUtilizado').val(dataComparativaPresupuestos[0].data.montoUtilizado).trigger('change');
            $('#fechaPresupuesto').val(dataComparativaPresupuestos[0].data.fechaPresupuesto).trigger('change');
            let presupuestoDisponible = Number(dataComparativaPresupuestos[0].data.presupuestoAnual) - Number(dataComparativaPresupuestos[0].data.montoUtilizado);
            $('#presupuestoDisponible').val(Number.parseFloat(presupuestoDisponible).toFixed(2)).trigger('change');
            let departamentos = data.map(depto => depto.nombreDepartamento);
            let presupuestos = data.map(presupuesto => presupuesto.montoPresupuesto);
            var graficaDepartamentos = document.querySelector('#grafica-presupuestos-departamentos').getContext("2d");
            var graficoTipoDona = new Chart(graficaDepartamentos, {
                type: 'doughnut',
                data: {
                    labels: departamentos,
                    datasets:[{
                        label: presupuestos,
                        data: presupuestos,
                        backgroundColor: ["#F93154","#1A237E","#4A148C","#00B74A","#FFA900","#1266F1"]
                    }],
                },
                options: {
                    responsive: true,
                    legend: {
                        position: 'bottom'
                    },
                }
            });
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
});
var grafico;
const abrirModalReporteGeneral = () => {
    $('#FechaPresupuesto').html(``);
    $.ajax(`${ API }/pacc/genera-lista-anios-presupuestos.php`,{
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function (response) {
            const { data } = response;
            $('#FechaPresupuesto').html(`<option value="">Seleccione el año en que desea generar el PACC</option>`);
            for(let i=0; i<data.length; i++) {
                $('#FechaPresupuesto').append(`<option value="${data[i].idControlPresupuestoActividad}">${ data[i].anio }</option>`);
            }
            $('#FechaPresupuesto').select2({ width: '100%' });
            $('#modalGeneraPaccGeneral').modal('show');
        },
        error:function(error){
            console.log(error.responseText)
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
		}
    });
}

const generarReporteGeneralPACC = () => {
    if ($('#FechaPresupuesto').val() === "") {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: "Seleccione una fecha para generar el PACC correspondiente",
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    } else {
        let parametros = { fechaPresupuestoActividad: parseInt($('#FechaPresupuesto').val()) };
        $.ajax(`${ API }/pacc/genera-pacc-general.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function (response) {
                const { data } = response;
                var $a = $("<a>");
                $a.attr("href",response.file);
                $("body").append($a);
                $a.attr("download","Reporte-PACC-Facultad.xlsx");
                $a[0].click();
                $a.remove();
                Swal.fire({
                    icon: 'success',
                    title: 'Accion realizada Exitosamente',
                    text: `${ data.message }`,
                });
                $('#FechaPresupuesto').html(`<option value="">Seleccione el año en que desea generar el PACC</option>`);
            },
            error:function(error){
                console.log(error.responseText)
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
            }
        });
    }
}

const abrirModalReporteDepartamento = () => {
    let parametros  = { idEstadoDepartamento: parseInt(1) };
    $.when(
        $.ajax(`${ API }/pacc/genera-lista-anios-presupuestos.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json'
        }),
        $.ajax(`${ API }/departamentos/listar-departamentos.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros)
        })).done(function(dataAniosPresupuesto, dataDepartamentos) {
            const departamentos = dataDepartamentos[0].data;
            const aniosPresupuestos = dataAniosPresupuesto[0].data;

            $('#FechaPresupuestoDepartamento').html(`<option value="">Seleccione el año en que desea generar el PACC</option>`);
            for(let i=0; i<aniosPresupuestos.length; i++) {
                $('#FechaPresupuestoDepartamento').append(`<option value="${ aniosPresupuestos[i].idControlPresupuestoActividad }">${ aniosPresupuestos[i].anio }</option>`);
            }
            $('#FechaPresupuestoDepartamento').select2({ width: '100%' });

            $('#departamento').html(`<option value="">Seleccione el departamento en que desea generar el PACC</option>`);
            for(let i=0; i<departamentos.length; i++) {
                $('#departamento').append(`<option value="${ departamentos[i].idDepartamento }">${ departamentos[i].nombreDepartamento }</option>`);
            }
            $('#departamento').select2({ width: '100%' });
            $('#modalGeneraPaccDepartamento').modal('show');
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

const generarReporteDepartamentoPACC = () => {
    if ($('#FechaPresupuestoDepartamento').val() === "") {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: "Seleccione una fecha para generar el PACC correspondiente",
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    } else {
        if ($('#departamento').val() === "") { 
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: "Seleccione un departamento para generar el PACC correspondiente",
                footer: '<b>Por favor verifique el formulario de registro</b>'
            });
        } else {
            let parametros = { fechaPresupuestoActividad: parseInt($('#FechaPresupuestoDepartamento').val()), idDepartamento: parseInt($('#departamento').val()) };
            $.ajax(`${ API }/pacc/genera-pacc-por-departamento.php`,{
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify(parametros),
                success:function (response) {
                    const { data } = response;
                    var $a = $("<a>");
                    $a.attr("href",response.file);
                    $("body").append($a);
                    $a.attr("download",`Reporte-PACC-${ response.departamento }.xlsx`);
                    $a[0].click();
                    $a.remove();
                    Swal.fire({
                        icon: 'success',
                        title: 'Accion realizada Exitosamente',
                        text: `${ data.message }`,
                    });
                },
                error:function(error){
                    console.log(error.responseText)
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
                }
            });
        }
    }
}

const abrirModalGraficos = () => {
    let parametros  = { idEstadoDepartamento: parseInt(1) };
    $.when(
        $.ajax(`${ API }/pacc/genera-lista-anios-presupuestos.php`,{
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json'
        }),
        $.ajax(`${ API }/departamentos/listar-departamentos.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros)
        })).done(function(dataAniosPresupuesto, dataDepartamentos) {
            const departamentos = dataDepartamentos[0].data;
            const aniosPresupuestos = dataAniosPresupuesto[0].data;

            $('#FechaPresupuestoDepartamentoGrafica').html(`<option value="">Seleccione el año en que desea generar el PACC</option>`);
            for(let i=0; i<aniosPresupuestos.length; i++) {
                $('#FechaPresupuestoDepartamentoGrafica').append(`<option value="${ aniosPresupuestos[i].idControlPresupuestoActividad }">${ aniosPresupuestos[i].anio }</option>`);
            }
            $('#FechaPresupuestoDepartamentoGrafica').select2({ width: '100%' });

            $('#departamentoGrafica').html(`<option value="">Seleccione el departamento en que desea generar el PACC</option>`);
            for(let i=0; i<departamentos.length; i++) {
                $('#departamentoGrafica').append(`<option value="${ departamentos[i].idDepartamento }">${ departamentos[i].nombreDepartamento }</option>`);
            }
            $('#departamentoGrafica').select2({ width: '100%' });
            
            $('#tipoGrafico').select2({ width: '100%' });
            $('#modalGraficos').modal('show');
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


function getRandomColor() {
    var letters = '0123456789ABCDEF';
    var color = '#';
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

const generarReportes = () => {
    
    //$('#listado-dimensiones tbody').html(``);
    $('#listado-dimensiones').dataTable().fnDestroy();
    // $('#listado-dimensiones tbody').dataTable().fnDestroy();
    if ($('#FechaPresupuestoDepartamentoGrafica').val() === "") {
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: "Seleccione una fecha para generar la grafica de gastos por dimension correspondiente",
            footer: '<b>Por favor verifique el formulario de registro</b>'
        });
    } else {
        if ($('#departamentoGrafica').val() === "") { 
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: "Seleccione un departamento para generar la grafica de gastos por dimension correspondiente",
                footer: '<b>Por favor verifique el formulario de registro</b>'
            });
        } else {
            let parametros = { fechaPresupuestoActividad: parseInt($('#FechaPresupuestoDepartamentoGrafica').val()), idDepartamento: parseInt($('#departamentoGrafica').val()) };
            
            $.ajax(`${ API }/pacc/genera-data-dimensiones-estrategicas-departamentos.php`,{
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify(parametros),
                success:function (response) {
                    const { data } = response;
                    console.log(data);
        
                    $('#listado-dimensiones tbody').html(``);
                    for (let i=0;i<data.length; i++) {
                        
    
                        $('#listado-dimensiones tbody').append(`
                            <tr>
                                <td scope="row" class="text-center">${ data[i].idDimension }</td>
                                <td scope="row" style="background-color: #7CB342;" class="text-white text-center">${ data[i].dimensionEstrategica }</td>
                                <td scope="row" style="background-color: #D50000;" class="text-white text-center">${ data[i].sumatoriaCostosPorDimension }</td>
                                <td scope="row" class="text-center">${ data[i].nombreDepartamento }</td>
                                <td scope="row" class="text-center">${ data[i].anioActividades }</td>
                            </tr>
                        `)
                    }

                    $('#listado-dimensiones').DataTable({
                        language: i18nEspaniol,
                        dom: 'Blfrtip',
                        buttons: botonesExportacion,
                        retrieve: true
                    });
                },
                error:function(error){
                    console.log(error.responseText)
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
                }
            });
        }
    }
}