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
    let nombreLugar = document.querySelector('#nombreLugar');

    // Tipando los atributos con los valores de la base de datos bueno algunos -> nP = nombrePersona
    let nP = { valorEtiqueta: nombrePersona, id: 'R-nombrePersona', name: 'Nombre Persona', min: 1, max: 80, type: 'text' };
    let aP = { valorEtiqueta: apellidoPersona, id: 'R-apellidoPersona', name: 'Apellido Persona', min: 1, max: 80, type: 'text' };
    let cE = { valorEtiqueta: codigoEmpleado, id: 'R-codigoEmpleado', name: 'Codigo Empleado', min: 5, max: 5, type: 'number' };
    let fN = { valorEtiqueta: fechaNacimiento, id: 'R-fechaNacimiento', name: 'Fecha de Nacimiento' };
    let iD = { valorEtiqueta: idDepartamento, id: 'R-idDepartamento', name: 'Departamento Facultad', type: 'select' };
    let iTU = { valorEtiqueta: idTipoUsuario, id: 'R-idTipoUsuario', name: 'Tipo Usuario', type: 'select' };
    let iP = { valorEtiqueta: idPais, id: 'R-idPais', name: 'Pais de residencia', type: 'select' };
    let iDP = { valorEtiqueta: idDepartamentoPais, id: 'R-idDepartamentoPais', name: 'Departamento Pais de residencia', type: 'select' };
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

        
        $.ajax({
            url: `${ API }/usuarios/registro.php`, 
            method: 'POST',
            dataType: 'json',
            data: dataNuevoUsuario
        }).success(function(response) {
            console.log(response);
        }).error(function(error) {
            console.warn(error);
            Swal.fire({
                icon: 'success',
                title: 'Ops...',
                text: 'Registro insertado con exito',
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
            
        });
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