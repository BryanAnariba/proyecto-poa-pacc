                        // Peticiones que se ejecutan al abrir el formulario de registro usuarios
const cargarDepartamentosFacultad = () => {
    $.ajax(`${ API }/departamentos/listar-departamentos.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function (response) {
            const { data } = response;
            console.log(data);
        }, 
        error:function (error) {
            const { data } = error.responseJSON;
            console.log(data);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })

        }
    });
}

const cargarTipoUsuarios = () => {
    
}

const cargarCiudadesPais = () => {
    // Limpiamos select
    $('#R-idDepartamentoPais').html(``);

    // Cargamos spinner de loading y esconcemos select
    $('#spinneridDepartamentoPais').removeClass('d-none');
    $('#R-idDepartamentoPais').addClass('d-none');

    // Mandamos los parametros por metodo post
    let parametros = { idPais: parseInt($('#R-idPais').val()) };
    
    // Test de parametros
    //console.log(parametros);

    // Peticion al servidor
    $.ajax(`${ API }/lugares/listar-ciudades.php`, {
		type: 'POST',
		dataType: 'json',
        contentType: 'application/json',
		data: JSON.stringify(parametros),
		success:function(response){
            const { data } = response;
            console.log('Ciudades Pais => ', data);

            // Quitamos spinner y cargamos select
            $('#spinneridDepartamentoPais').addClass('d-none');
            $('#R-idDepartamentoPais').removeClass('d-none');
            $('#R-idDepartamentoPais').append(
                `<option value='' selected>Seleccione Ciudad/Provincia Pais</option>`
            );

            // Rellenamos la informacion del select
            for(let i=0;i<data.length;i++) {
                $('#R-idDepartamentoPais').append(
                    `
                        <option value="${ data[i].idLugar }">${ data[i].ciudad }</option>
                    `
                );
            }
		},
		error:function(error){
            const { data } = error.responseJSON;
            console.log(data);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
		}
    });
}

const cargarMunicipios = () => {
    let id =$("#R-idDepartamentoPais").val();
    // Limpiamos select
    $('#R-idMunicipiosCiudad').html(``);

    // Cargamos spinner de loading y esconcemos select
    $('#spinneridMunicipiosCiudad').removeClass('d-none');
    $('#R-idMunicipiosCiudad').addClass('d-none');

    // Mandamos los parametros por metodo post
    let parametros = { idCiudad: parseInt(id) };
    
    // Test de parametros
    //console.log(parametros);

    // Peticion al servidor
    $.ajax(`${ API }/lugares/listar-municipios.php`, {
		type: 'POST',
		dataType: 'json',
        contentType: 'application/json',
		data: JSON.stringify(parametros),
		success:function(response){
            const { data } = response;
            console.log('Municipios Ciudad => ', data);

            // Quitamos spinner y cargamos select
            $('#spinneridMunicipiosCiudad').addClass('d-none');
            $('#R-idMunicipiosCiudad').removeClass('d-none');
            $('#R-idMunicipiosCiudad').append(
                `<option value='' selected>Seleccione Municipio Ciudad</option>`
            );

            // Rellenamos la informacion del select
            for(let i=0;i<data.length;i++) {
                $('#R-idMunicipiosCiudad').append(
                    `
                        <option value="${ data[i].idLugar }">${ data[i].municipio }</option>
                    `
                );
            }
		},
		error:function(error){
            const { data } = error.responseJSON;
            console.log(data);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
		}
    });
}
const cargarModalRegistro = () => {
    $('.loading-registro').removeClass('d-none');
    $('#modalContentRegistro').addClass('d-none');
    let parametros = { idTipoLugar: 1 };
    setTimeout(() => {
        //cargarTipoUsuarios();
        $.ajax(`${ API }/lugares/listar-paises.php`, {
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            data: JSON.stringify(parametros),
            success:function(response){
                $.ajax(`${ API }/usuarios/listar-tipos-usuarios.php`, {
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    success:function (response) {
                        const { data } = response;
                        console.log('Tipos usuarios => ', data);
                    }, 
                    error:function (error) {
                        //const { data } = error.responseJSON;
                        //console.log(data);
                        console.error(error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Ops...',
                            text: `${ error }`,
                            footer: '<b>Por favor verifique el formulario de registro</b>'
                        })
                    }
                });
                $('.loading-registro').addClass('d-none');
                $('#modalContentRegistro').removeClass('d-none');
                const { data } = response;
                console.log('Paises => ', data);
                $('#R-idPais').append(
                    `<option value='' selected>Seleccione Direcion Pais</option>`
                );
                for(let i=0;i<data.length;i++) {
                    $('#R-idPais').append(
                        `
                            <option value=${ data[i].idLugar } >${ data[i].nombreLugar }</option>
                        `
                    );
                }
            },
            error:function(error){
                const { data } = error.responseJSON;
                console.log(data);
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`,
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                })
            }
        });
    }, 1000);
}

//                                  Peticiones de verificacion, guardado, y actualizado
const verificarCamposRegistro = () => {

    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    let nombrePersona = document.querySelector('#R-nombrePersona');
    let apellidoPersona = document.querySelector('#R-apellidoPersona');
    let codigoEmpleado = document.querySelector('#R-codigoEmpleado');
    let fechaNacimiento = document.querySelector('#R-fechaNacimiento');
    let idDepartamento = document.querySelector('#R-idDepartamento');
    let idTipoUsuario = document.querySelector('#R-idTipoUsuario');
    let correoInstitucional = document.querySelector('#R-correoInstitucional');
    let idPais = document.querySelector('#R-idPais');
    let idDepartamentoPais = document.querySelector('#R-idDepartamentoPais');
    let idMunicipioCiudad = document.querySelector('#R-idMunicipiosCiudad');
    let nombreLugar = document.querySelector('#nombreLugar');

    // Tipando los atributos con los valores de la base de datos bueno algunos -> nP = nombrePersona
    let nP = { valorEtiqueta: nombrePersona, id: 'R-nombrePersona', name: 'Nombre Persona', min: 1, max: 80, type: 'text' };
    let aP = { valorEtiqueta: apellidoPersona, id: 'R-apellidoPersona', name: 'Apellido Persona', min: 1, max: 80, type: 'text' };
    let cE = { valorEtiqueta: codigoEmpleado, id: 'R-codigoEmpleado', name: 'Codigo Empleado', min: 5, max: 5, type: 'number' };
    let fN = { valorEtiqueta: fechaNacimiento, id: 'R-fechaNacimiento', name: 'Fecha de Nacimiento' };
    let iD = { valorEtiqueta: idDepartamento, id: 'R-idDepartamento', name: 'Departamento Facultad', type: 'select' };
    let iTU = { valorEtiqueta: idTipoUsuario, id: 'R-idTipoUsuario', name: 'Tipo Usuario', type: 'select' };
    let iP = { valorEtiqueta: idPais, id: 'R-idPais', name: 'Pais de residencia', type: 'select' };
    let iDP = { valorEtiqueta: idDepartamentoPais, id: 'R-idDepartamentoPais', name: 'Ciudad Pais de residencia', type: 'select' };
    let iMC = { valorEtiqueta: idMunicipioCiudad, id: 'R-idMunicipiosCiudad', name: 'Municipio Ciudad de residencia', type: 'select' };
    let cI = { valorEtiqueta: correoInstitucional, id: 'R-correoInstitucional', name: 'Correo Institucional' };
    

    // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidNombrePersona = verificarInputText(nP);
    let isValidApellidoPersona = verificarInputText(aP);
    let isValidCodigoEmpleado = verificarInputNumber(cE, codigoEmpleadoRegex);
    let isValidFecha = verificarFecha(fN);
    let isValidIdDepartamento = verificarSelect(iD);
    let isValidIdTipoUsuario = verificarSelect(iTU);
    let isValidIdPais = verificarSelect(iP);
    let isValidIdDepartamentoPais = verificarSelect(iDP);
    let isValidIdMunicipioCiudad = verificarSelect(iMC);
    let isValidCorreoInstitucional = verificarEmail(cI);
    

    // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
    if (
        (isValidNombrePersona === true) &&
        (isValidApellidoPersona === true) &&
        (isValidCodigoEmpleado === true) && 
        (isValidFecha === true) &&
        (isValidIdDepartamento === true) && 
        (isValidIdTipoUsuario === true) &&
        (isValidIdPais === true) &&
        (isValidIdDepartamentoPais === true) &&
        (isValidIdMunicipioCiudad === true) &&
        (isValidCorreoInstitucional === true)
    ) {
        const dataNuevoUsuario = {
            nombrePersona: nombrePersona.value,
            apellidoPersona: apellidoPersona.value,
            codigoEmpleado: codigoEmpleado.value,
            fechaNacimiento: fechaNacimiento.value,
            idDepartamento: idDepartamento.value,
            idTipoUsuario: idTipoUsuario.value,
            correoInstitucional: correoInstitucional.value,
            idPais: idPais.value,
            idDepartamentoPais: idDepartamentoPais.value,
            nombreLugar: ((nombreLugar.value != '') ? nombreLugar.value : null)
        };
        console.log('User data => ', dataNuevoUsuario);
    } else { // caso contrario mostrar alerta y notificar al usuario 
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro de la persona no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        })
    }
}

const verificarCamposActualizacion = () => {

}