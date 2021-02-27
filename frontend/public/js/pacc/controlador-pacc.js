$( document ).ready(function() {
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