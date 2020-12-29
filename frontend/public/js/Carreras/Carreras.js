const verificarCamposRegistro = () => {

    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    let Carrera = document.querySelector('#Carrera');
    let Abreviatura = document.querySelector('#Abreviatura');
    let Departamento = document.querySelector('#Departamento');
    let Estado = document.querySelector('#Estado');

    // Tipando los atributos con los valores de la base de datos bueno algunos -> nP = nombrePersona
    let Cr = { valorEtiqueta: Carrera, id: 'Carrera', name: 'Carrera', min: 1, max: 80, type: 'text' };
    let aB = { valorEtiqueta: Abreviatura, id: 'Abreviatura', name: 'Abreviatura', min: 1, max: 2, type: 'text' };
    let Dp = { valorEtiqueta: Departamento, id: 'Departamento', name: 'Departamento', type: 'select' };
    let Es = { valorEtiqueta: Estado, id: 'Estado', name: 'Estado' ,type: 'select' };
    

   // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidNombrePersona = verificarInputText(Cr,letrasEspaciosCaracteresRegex);
    let isValidAbreviatura = verificarInputText(aB,letrasEspaciosCaracteresRegex);
    let isValidIdDepartamento = verificarSelect(Dp);
    let isValidEstado = verificarSelect(Es);

    // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
    if (
        (isValidNombrePersona === true) &&
        (isValidAbreviatura === true) &&
        (isValidEstado === true) &&
        (isValidIdDepartamento === true) 
    ) {
        const dataNuevoCarrera = {
            Carrera: Carrera.value,
            Abreviatura: Abreviatura.value,
            Departamento: Departamento.value,
            Estado: Estado.value
        };
        $.ajax({
            url: `${ API }/Carreras/registrarCarrera.php`, 
            method: 'POST',
            dataType: 'json',
            data: (dataNuevoCarrera)
        }).success(function(response) {
            console.log(response);
            Swal.fire({
                icon: 'success',
                title: 'Listo',
                text: 'Registro insertado con exito',
            })
        }).error(function(error) {
            console.warn(error);
            console.log("hola");
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'El registro de la carrera no se pudo realizar',
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
        });
    } else { // caso contrario mostrar alerta y notificar al usuario 
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro de la carrera no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        })
    }
};
const cambiarDepa = () => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/Carreras/obtenerDepartamentos.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("Departamento").innerHTML="<option value='' disabled selected></option>";
        for(let i = 0; i < response.data.length;i++){
            document.getElementById("Departamento").innerHTML+=`<option value="${response.data[i].idDepartamento}">${response.data[i].nombreDepartamento}</option>`;
        }
        
    }).error(function(error) {
        console.warn(error); 
    });
};
const cambiarEst = () => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/Carreras/obtenerEstado.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("Estado").innerHTML="<option value='' disabled selected></option>";
        for(let i = 0; i < response.data.length;i++){
            document.getElementById("Estado").innerHTML+=`<option value="${response.data[i].idEstado}">${response.data[i].estado}</option>`;
        }
        
    }).error(function(error) {
       console.warn(error); 
    });
};
const cambiarDepaEstado = () => {
    cambiarDepa();
    cambiarEst();
};
const cambiarDepa2 = () => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/Carreras/obtenerDepartamentos.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("Departamento2").innerHTML="<option value= disabled selected></option>";
        for(let i = 0; i < response.data.length;i++){
            document.getElementById("Departamento2").innerHTML+=`<option value="${response.data[i].idDepartamento}">${response.data[i].nombreDepartamento}</option>`;
        }
        $("#botonModif").attr("disabled", true);
    }).error(function(error) {
       console.warn(error); 
    });
};
const cambiarModif = () => {
    cambiarDepa2();
    $("#carreraSel").css({'display':'none'});
    $("#modifAbajo").css({'display':'none'});
};
const cambiarDepaModificado = (carrera) => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/Carreras/obtenerDepartamentos.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("DepartamentoModif").innerHTML="<option value='' disabled></option>";
        for(let i = 0; i < response.data.length;i++){
            if(carrera.idDepartamento==response.data[i].idDepartamento){
                document.getElementById("DepartamentoModif").innerHTML+=`<option value="${response.data[i].idDepartamento}" selected>${response.data[i].nombreDepartamento}</option>`;
            }else{
                document.getElementById("DepartamentoModif").innerHTML+=`<option value="${response.data[i].idDepartamento}">${response.data[i].nombreDepartamento}</option>`;
            }
        }
        
    }).error(function(error) {
       console.warn(error); 
    });
};
const cambiarEstadoModificado = (carrera) => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/Carreras/obtenerEstado.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("EstadoModif").innerHTML="<option value='' disabled></option>";
        for(let i = 0; i < response.data.length;i++){
            if(carrera.idEstadoDCDU==response.data[i].idEstado){
                document.getElementById("EstadoModif").innerHTML+=`<option value="${response.data[i].idEstado}" selected>${response.data[i].estado}</option>`;
            }else{
                document.getElementById("EstadoModif").innerHTML+=`<option value="${response.data[i].idEstado}">${response.data[i].estado}</option>`;
            }
        }
        
    }).error(function(error) {
       console.warn(error); 
    });
};
const cambiarCarreraModif = () => {
    const peticion = {
        idCarrera: document.querySelector('#carreraDepa').value
    };
    $.ajax({
        url: `${ API }/Carreras/obtenerCarreraPorId.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        $("#modifAbajo").css({'display':'block'});
        $("#botonModif").attr("disabled", false);
        $("#Carrera2").val(response.data[0].carrera).trigger("change");
        $("#Abreviatura2").val(response.data[0].abrev).trigger("change");
        cambiarDepaModificado(response.data[0]);
        cambiarEstadoModificado(response.data[0]);
    }).error(function(error) {
       console.warn(error); 
    });
};
const cambiarDepaModif = () => {
    $("#carreraSel").css({'display':'block'});
    $("#modifAbajo").css({'display':'none'});

    const peticion = {
        idDepartamento: document.querySelector('#Departamento2').value
    };
    $.ajax({
        url: `${ API }/Carreras/ObtenerCarrerasPorIdDepa.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        document.getElementById("carreraDepa").innerHTML="<option value= disabled selected></option>";
        for(let i = 0; i < response.data.length;i++){
            document.getElementById("carreraDepa").innerHTML+=`<option value="${response.data[i].idCarrera}">${response.data[i].carrera}</option>`;
        }
        $("#botonModif").attr("disabled", true);
    }).error(function(error) {
        console.warn(error);
    });

};
const agregarATabla = (dataSet) => {
    $('#CarrerasTodas').dataTable().fnDestroy();
    $('#CarrerasTodas tbody').html(``);
    
    for (let i=0;i<dataSet.length; i++) {
        $('#CarrerasTodas tbody').append(`
            <tr>
                <td scope="row">${ i + 1 }</td>
                <td>${ dataSet[i].carrera }</td>
                <td>${ dataSet[i].abrev }</td>
                <td>${ dataSet[i].nombreDepartamento }</td>
                <td>${ dataSet[i].estado }</td>
            </tr>
        `)
    }
    $('#CarrerasTodas').DataTable({
        language: i18nEspaniol,
        //dom: 'Blfrtip',
        //buttons: botonesExportacion,
        retrieve: true
    });
};
const obtenerCarreras = () => {
    const peticion = {
        nada: ""
    };
    $.ajax({
        url: `${ API }/Carreras/ObtenerCarreras.php`, 
        method: 'POST',
        dataType: 'json',
        data: peticion
    }).success(function(response) {
        agregarATabla(response.data);
    }).error(function(error) {
        console.error(error);
    });
};
const actualizarCarrera = () => {

    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    let Carrera = document.querySelector('#Carrera2');
    let Abreviatura = document.querySelector('#Abreviatura2');
    let Departamento = document.querySelector('#DepartamentoModif');
    let Estado = document.querySelector('#EstadoModif');

    // Tipando los atributos con los valores de la base de datos bueno algunos -> nP = nombrePersona
    let Cr = { valorEtiqueta: Carrera, id: 'Carrera2', name: 'Carrera', min: 1, max: 80, type: 'text' };
    let aB = { valorEtiqueta: Abreviatura, id: 'Abreviatura2', name: 'Abreviatura', min: 1, max: 2, type: 'text' };
    let Dp = { valorEtiqueta: Departamento, id: 'DepartamentoModif',name: 'Departamento', type: 'select' };
    let Es = { valorEtiqueta: Estado, id: 'EstadoModif',name: 'Estado', type: 'select' };
    

    // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidNombrePersona = verificarInputText(Cr,letrasEspaciosCaracteresRegex);
    let isValidAbreviatura = verificarInputText(aB,letrasEspaciosCaracteresRegex);
    let isValidIdDepartamento = verificarSelect(Dp);
    let isValidEstado = verificarSelect(Es);

    // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
    if (
        (isValidNombrePersona === true) &&
        (isValidAbreviatura === true) &&
        (isValidEstado === true) &&
        (isValidIdDepartamento === true) 
    ) {
        const dataNuevoCarrera = {
            idCarrera: document.querySelector('#carreraDepa').value,
            Carrera: Carrera.value,
            Abreviatura: Abreviatura.value,
            Departamento: Departamento.value,
            Estado: Estado.value
        };
        $.ajax({
            url: `${ API }/Carreras/ActualizarCarrera.php`, 
            method: 'POST',
            dataType: 'json',
            data: dataNuevoCarrera
        }).success(function(response) {
            console.log(response);
            Swal.fire({
                icon: 'success',
                title: 'Listo',
                text: 'Registro insertado con exito',
            })
        }).error(function(error) {
            console.log(error);
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: 'El registro de la carrera no se pudo realizar',
                footer: '<b>Por favor verifique el formulario de registro</b>'
            })
        });
    } else { // caso contrario mostrar alerta y notificar al usuario 
        Swal.fire({
            icon: 'error',
            title: 'Ops...',
            text: 'El registro de la carrera no se pudo realizar',
            footer: '<b>Por favor verifique el formulario de registro</b>'
        })
    }
};