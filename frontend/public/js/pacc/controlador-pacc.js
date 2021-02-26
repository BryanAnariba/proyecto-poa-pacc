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
                type: 'pie',
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
    $('#modalGeneraPaccGeneral').modal('show');
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
        console.log('Works');
    }
}