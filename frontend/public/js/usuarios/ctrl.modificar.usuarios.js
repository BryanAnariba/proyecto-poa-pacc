const listarUsuarios = () => {
    $.ajax(`${ API }/usuarios/listado-usuarios.php`, {
        type: 'POST',
		dataType: 'json',
        contentType: 'application/json',
		success:function(response){
            const { data } = response;
            console.log('Usuarios registrados -> ', data);
            $('#listado-usuarios tbody').html(``);
        
            for (let i=0;i<data.length; i++) {
                $('#listado-usuarios tbody').append(`
                    <tr>
                        <td scope="row">${ i + 1 }</td>
                        <td>${ data[i].nombrePersona }</td>
                        <td>${ data[i].apellidoPersona }</td>
                        <td>${ data[i].direccion }</td>
                        <td>${ data[i].correoInstitucional }</td>
                        <td>${ data[i].nombreUsuario }</td>
                        <td>${ data[i].nombreDepartamento }</td>
                        <td>${ data[i].tipoUsuario }</td>
                        <td>${ data[i].codigoEmpleado }</td>
                        <td>
                            <button type="button" ${data[i].idEstadoDimension === 1 ? `class="btn btn-success" ` : `class="btn btn-danger" `}
                            onclick=(modificaEstadoDimension(${data[i].idDimension}))>
                                ${data[i].estado }
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
}