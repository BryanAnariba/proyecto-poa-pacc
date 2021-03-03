var poblacionRegistro=[];
var Poblacion=[];
$(document).ready(function(){
    poblacionRegistro = [
        {id:1,
        Departamento:'Ingenieria en sistemas',
        Trimestre:'Trimestre 1',
        Año:2021,
        Población:'Estudiantes Matriculados',
        Cantidad:50,
        Registro:'Norman',
        Modifico:'Keren',
        Documento:'riogriosrgrgsr'
        },{id:2,
        Departamento:'Ingenieria en sistemas',
        Trimestre:'Trimestre 2',
        Año:2021,
        Población:'Docentes con Maestria',
        Cantidad:50,
        Registro:'Norman',
        Modifico:'Keren',
        Documento:'riogriosrgrgsr'
        }
    ];
    verRegistro();
});

// visualizacion en dataTable

const obtenerDocentesEstudiantes = () =>{
    let idUsuario = { 'idUsuario': Usuario['idUsuario'] };
    
    $.when(
        $.ajax(`${ API }/control-estudiantes-docentes/obtenerMatriculados.php`, {
            type: 'POST',
            dataType: 'json',
            data: idUsuario
        }),
        $.ajax(`${ API }/control-estudiantes-docentes/obtenerEgresados.php`, {
            type: 'POST',
            dataType: 'json',
            data: idUsuario
        }),
        $.ajax(`${ API }/control-estudiantes-docentes/obtenerDocentes.php`, {
            type: 'POST',
            dataType: 'json',
            data: idUsuario
        }))
        .done(function(matriculadosResponse, egresadosResponse, docentesResponse) {
            let matriculados = matriculadosResponse[0].data;
            let egresados = egresadosResponse[0].data;
            let docentes = docentesResponse[0].data;
            let poblacionIngresada=[];

            poblacionIngresada=matriculados.concat(egresados);
            poblacionIngresada=poblacionIngresada.concat(docentes);

            console.log(poblacionIngresada);

            poblacionIngresada.sort(function(a,b){
                // Turn your strings into dates, and then subtract them
                // to get a value that is either negative, positive, or zero.
                return new Date(b.fechaModificacion) - new Date(a.fechaModificacion);
            });

            poblacionIngresada.sort(function(a,b){
                // Turn your strings into dates, and then subtract them
                // to get a value that is either negative, positive, or zero.
                return new Date(b.fechaRegistro) - new Date(a.fechaRegistro);
            });

            console.log(poblacionIngresada);

            $('#DocentesEstudiantes').dataTable().fnDestroy();
            $('#DocentesEstudiantes tbody').html(``);
            for (let i=0;i<poblacionIngresada.length; i++) {
                $('#DocentesEstudiantes tbody').append(`
                    <tr>
                        <td scope="row">${ i + 1 }</td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].nombreDepartamento }</justify></td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].nombreTrimeste }</justify></td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].fechaRegistro }</justify></td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].fechaModificacion }</justify></td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].poblacion }</justify></td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].cantidad }</justify></td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].registro }</justify></td>
                        <td><justify class="m-auto">${ poblacionIngresada[i].modifico }</justify></td>
                        <td class="text-center">
                            <button type="button" class="btn btn-info btn-sm m-auto"
                            onclick="visualizarAdjuntos('${poblacionIngresada[i].documentoRespaldo}')">
                            <img src="../img/control-recibir-permisos/adjuntos-icono.svg" alt="Ver Mas"/>
                            </button>
                         </td>
                        <td class="text-center">
                                <input type="file" id="docUpload" style="display:none" onchange="nuevo()"/> 
                                <button type="button" class="btn btn-info btn-sm m-auto"
                                    onclick="actualizarRespaldo('${poblacionIngresada[i].id}','${poblacionIngresada[i].cantidad}','${poblacionIngresada[i].nombreTrimeste}','${poblacionIngresada[i].poblacion}')"
                                >
                                    <img src="../img/control-estudiantes-docentes/upload.svg" alt="Ver Mas"/>
                                </button>
                        </td>
                        <td class="my-auto">
                            <button type="button" class="btn btn-info btn-sm m-auto" 
                                onclick="verModificar('${poblacionIngresada[i].id}','${poblacionIngresada[i].cantidad}','${poblacionIngresada[i].nombreTrimeste}','${poblacionIngresada[i].poblacion}')">
                                <img src="../img/menu/visualizar-icon.svg" alt="verObservacion"/>
                            </button>
                        </td>
                        
                    </tr>
                `)
            }
            $('#DocentesEstudiantes').DataTable({
                language: i18nEspaniol,
                retrieve: true
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
}

// llenado de select de poblacion en modal registro

const verRegistro = () =>{
    Poblacion = ["Estudiantes Matriculados","Egresados","Docentes con Maestria"];
        
    document.querySelector("#Poblacion").innerHTML='<option value="" selected disabled>Seleccione poblacion a ingresar</option>';

    for(let i = 1; i <= Poblacion.length;i++){
        document.querySelector("#Poblacion").innerHTML+=`<option value="${i}">${Poblacion[i-1]}</option>`;
    }

    var element = document.querySelector("#Poblacion");

    element.addEventListener('focus', function () {
        this.size=3;
    });
    element.addEventListener('change', function () {
        this.size=1;
        this.blur();
    });
    element.addEventListener('blur', function () {
        this.size=1;
    });
}

// 1) Cambiar modal en registro cuando se seleccione que poblacion se registrara.
// 2) Obtener trimestres y colocar en select.

const cambiarFormulario = () =>{
    $("#tabla").css("display","block");
    $("#registrarNumero").prop("disabled",false);

    $("#respaldo").val('').trigger("change");
    $("#documentoSubido").val('');
    document.querySelector(`#labelrespaldo`).classList.remove('text-danger')
    document.querySelector('#respaldo').classList.remove('text-danger');
    document.querySelector('#respaldo').classList.remove('is-invalid')
    document.querySelector(`#errorsrespaldo`).classList.add('d-none');

    document.querySelector('#Trimestre').classList.remove('text-danger');
    document.querySelector('#Trimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsTrimestre`).classList.add('d-none');

    $.ajax(`${ API }/control-estudiantes-docentes/obtenerTrimestres.php`, {
        type: 'POST',
        dataType: 'json',
        success:function(response) {
            const { data } = response;
            document.getElementById("Trimestre").innerHTML=`<option value="" selected disabled>Seleccione un trimestre</option>`;

            for(let i = 0; i < data.length;i++){
                document.getElementById("Trimestre").innerHTML+=`<option value="${data[i].idTrimestre}">${data[i].nombreTrimeste}</option>`;
            }

            var element = document.querySelector("#Trimestre");

            element.addEventListener('focus', function () {
                this.size=4;
            });
            element.addEventListener('change', function () {
                this.size=1;
                this.blur();
            });
            element.addEventListener('blur', function () {
                this.size=1;
            });
        },
        error:function(error) {
            console.log(error);
            const { status, data } = error.responseJSON;
            if (status === 401) {
                window.location.href = '../views/401.php';
            }else{
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`,
                    footer: '<b>Por favor verifique el formulario de registro</b>'
                })
            };
        }
    });

    idPoblacion = $('select[id="Poblacion"] option:selected').text();
    switch(idPoblacion) {
        case 'Estudiantes Matriculados':
            $("#tituloRegistro").html('Estudiantes Matriculados');
            $("#campoNum").html(`
                <!-- numero estudiantes matriculados -->
                <div class="md-form">
                    <input type="number" id="NumEstudiantesMatriculados" class="form-control" maxlength="2">
                    <span id="errorsNumEstudiantesMatriculados" class="text-danger text-small d-none">
                    </span>
                    <label 
                        for="NumEstudiantesMatriculados"
                        id="labelNumEstudiantesMatriculados"
                    >
                    Numero estudiantes matriculados
                    </label>
                </div>`
            );
            // $("#registrarNumero").attr("onclick",`enviar('NumEstudiantesMatriculados')`);
          break;
        case 'Egresados':
            $("#tituloRegistro").html('Egresados');
            $("#campoNum").html(`
                <!-- numero egresados -->
                <div class="md-form">
                    <input type="number" id="NumEgresados" class="form-control" maxlength="2">
                    <span id="errorsNumEgresados" class="text-danger text-small d-none">
                    </span>
                    <label 
                        for="NumEgresados"
                        id="labelNumEgresados"
                    >
                    Numero egresados
                    </label>
                </div>`
            );
            // $("#registrarNumero").attr("onclick",`enviar('NumEgresados')`);
          break;
        case 'Docentes con Maestria':
            $("#tituloRegistro").html('Docentes con Maestria');
            $("#campoNum").html(`
                <!-- numero docentes con maestria -->
                <div class="md-form">
                    <input type="number" id="NumDocentes" class="form-control" maxlength="2">
                    <span id="errorsNumDocentes" class="text-danger text-small d-none">
                    </span>
                    <label 
                        for="NumDocentes"
                        id="labelNumDocentes"
                    >
                    Numero docentes con maestria
                    </label>
                </div>`
            );
            // $("#registrarNumero").attr("onclick",`enviar('NumDocentes')`);
          break;
        default:
          break;
        }
    poblacionTemp=null;
};

// visualizacion modal Modificar
const verModificar = (id,Cantidad,trimestre,poblacion) =>{
    $("#modalModificarDocentesEstudiantes").modal('toggle');
    $("#cerrarM").attr("onclick",`CerrarModalM('${poblacion}')`);
    $("#modificarNumero").attr("onclick",`Modificar('${poblacion}','${id}')`);
    cambiarFormularioM(id,Cantidad,trimestre,poblacion);
};

const cambiarFormularioM = (id,Cantidad,trimestre,poblacion) =>{
    var Trimestre = ["Trimestre 1","Trimestre 2","Trimestre 3","Trimestre 4"];
    
    document.getElementById("TrimestreM").innerHTML=`<option value="" disabled>Seleccione un trimestre</option>`;

    for(let i = 0; i < Trimestre.length;i++){
        if(trimestre===Trimestre[i]){
            document.getElementById("TrimestreM").innerHTML+=`<option value="${i}" selected>${Trimestre[i]}</option>`;
        }else{
            document.getElementById("TrimestreM").innerHTML+=`<option value="${i}">${Trimestre[i]}</option>`;
        }
    }

    var element = document.querySelector("#TrimestreM");

    element.addEventListener('focus', function () {
        this.size=4;
    });
    element.addEventListener('change', function () {
        this.size=1;
        this.blur();
    });
    element.addEventListener('blur', function () {
        this.size=1;
    });

    switch(poblacion) {
        case 'Estudiantes Matriculados':
            $("#tituloRegistroM").html('Estudiantes Matriculados');
            $("#campoNumM").html(`
                <!-- numero estudiantes matriculados -->
                <div class="md-form">
                    <input type="number" id="NumEstudiantesMatriculadosM" class="form-control" maxlength="2">
                    <span id="errorsNumEstudiantesMatriculadosM" class="text-danger text-small d-none">
                    </span>
                    <label 
                        for="NumEstudiantesMatriculadosM"
                        id="labelNumEstudiantesMatriculadosM"
                    >
                    Numero estudiantes matriculados
                    </label>
                </div>`
            );
            $(`#NumEstudiantesMatriculadosM`).val(Cantidad).trigger("change");
            // $("#registrarNumero").attr("onclick",`enviar('NumEstudiantesMatriculados')`);
          break;
        case 'Egresados':
            $("#tituloRegistroM").html('Egresados');
            $("#campoNumM").html(`
                <!-- numero egresados -->
                <div class="md-form">
                    <input type="number" id="NumEgresadosM" class="form-control" maxlength="2">
                    <span id="errorsNumEgresadosM" class="text-danger text-small d-none">
                    </span>
                    <label 
                        for="NumEgresadosM"
                        id="labelNumEgresadosM"
                    >
                    Numero egresados
                    </label>
                </div>`
            );
            $(`#NumEgresadosM`).val(Cantidad).trigger("change");
            // $("#registrarNumero").attr("onclick",`enviar('NumEgresados')`);
          break;
        case 'Docentes con Maestria':
            $("#tituloRegistroM").html('Docentes con Maestria');
            $("#campoNumM").html(`
                <!-- numero docentes con maestria -->
                <div class="md-form">
                    <input type="number" id="NumDocentesM" class="form-control" maxlength="2">
                    <span id="errorsNumDocentesM" class="text-danger text-small d-none">
                    </span>
                    <label 
                        for="NumDocentesM"
                        id="labelNumDocentesM"
                    >
                    Numero docentes con maestria
                    </label>
                </div>`
            );
            $(`#NumDocentesM`).val(Cantidad).trigger("change");
            // $("#registrarNumero").attr("onclick",`enviar('NumDocentes')`);
          break;
        default:
          break;
        }
    poblacionTemp=null;
};

// enviar resumen

const enviar = () =>{
    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    let Trimestre = document.querySelector('#Trimestre');
    let numeroPoblacion = null;
    let respaldo = document.querySelector('#respaldo');

    let poblacion = null;

    if(document.querySelector("#Poblacion").value==1){
        numeroPoblacion=document.querySelector('#NumEstudiantesMatriculados');
        poblacion="NumEstudiantesMatriculados";
    }else if(document.querySelector("#Poblacion").value==2){
        numeroPoblacion=document.querySelector('#NumEgresados');
        poblacion="NumEgresados";
    }else if(document.querySelector("#Poblacion").value==3){
        numeroPoblacion=document.querySelector('#NumDocentes');
        poblacion="NumDocentes";
    }
    // Tipando los atributos con los valores de la base de datos bueno algunos
    let tR = { valorEtiqueta: Trimestre, id: 'Trimestre', name: 'Trimestre', type: 'select' };
    let nP = { valorEtiqueta: numeroPoblacion, id: poblacion, name: poblacion, min: 1, max: 4, type: 'text' };
    let rP = { valorEtiqueta: respaldo, id: 'respaldo', name: 'respaldo', min: 1, max: 1000, type: 'text' };
   

    // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidTrimestre = verificarSelect(tR);
    let isValidRespaldo = null;
    let isValidnumeroPoblacion = verificarInputNumber(nP,numerosRegex);

    if(respaldo.value===''){
        isValidRespaldo=verificarInputText(rP,letrasEspaciosCaracteresRegex);
    }else{
        isValidRespaldo=true
    }
   // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
   if (
       (isValidTrimestre === true) &&
       (isValidnumeroPoblacion === true) &&
       (isValidRespaldo === true)
   ) {
        const formData = new FormData($("#formulario-registro-poblacion")[0]);
        formData.append('Trimestre', Trimestre.value);
        formData.append('numeroPoblacion', JSON.parse(numeroPoblacion.value));
        formData.append('respaldo', respaldo.value);
        formData.append('poblacion', poblacion);
        formData.append('idUsuario', Usuario['idUsuario']);
       $.ajax(`${ API }/control-estudiantes-docentes/ingresarDocentesEstudiantes.php`, {
            type: 'POST',
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
           success:function(response) {
                const { data } = response;

                $("#Trimestre").val('').trigger("change");
                $("#respaldo").val('').trigger("change");
                $("#documentoSubido").val('');
                $(`#${poblacion}`).val('').trigger("change");
                $("#tabla").css("display","none");

                Swal.fire({
                    icon: 'success',
                    title: 'Listo!',
                    text: `El registro de numero de ${data.message} se realizo con exito`,
                    footer: '<b></b>'
                });

                verRegistro();
                
                document.querySelector(`#labelrespaldo`).classList.remove('text-danger')
                document.querySelector('#respaldo').classList.remove('text-danger');
                document.querySelector('#respaldo').classList.remove('is-invalid')
                document.querySelector(`#errorsrespaldo`).classList.add('d-none');
                $("#registrarNumero").prop("disabled",true);
           },
           error:function(error) {
               console.log(error);
               const { status, data } = error.responseJSON;
               if (status === 401) {
                   window.location.href = '../views/401.php';
               }else{
                   Swal.fire({
                       icon: 'error',
                       title: 'Ops...',
                       text: `${ data.message }`,
                       footer: '<b>Por favor verifique el formulario de registro</b>'
                   })
               };
           }
       });
   } else { // caso contrario mostrar alerta y notificar al usuario 
       Swal.fire({
           icon: 'error',
           title: 'Ops...',
           text: 'El registro de la carrera no se pudo realizar',
           footer: '<b>Por favor verifique el formulario de registro</b>'
       })
   }
}

const Modificar=(poblacion,id)=>{
    // Capturando las etiquetas completas de los inputs para despues obtener el valor
    let Trimestre = document.querySelector('#TrimestreM');
    let numeroPoblacion = null;

    let poblacionVar='';
    if(poblacion=='Estudiantes Matriculados'){
        numeroPoblacion=document.querySelector('#NumEstudiantesMatriculadosM');
        poblacionVar="NumEstudiantesMatriculadosM";
    }else if(poblacion=='Egresados'){
        numeroPoblacion=document.querySelector('#NumEgresadosM');
        poblacionVar="NumEgresadosM";
    }else if(poblacion=='Docentes con Maestria'){
        numeroPoblacion=document.querySelector('#NumDocentesM');
        poblacionVar="NumDocentesM";
    }
    // Tipando los atributos con los valores de la base de datos bueno algunos
    let tR = { valorEtiqueta: Trimestre, id: 'TrimestreM', name: 'TrimestreM', type: 'select' };
    let nP = { valorEtiqueta: numeroPoblacion, id: poblacionVar, name: poblacionVar, min: 1, max: 4, type: 'text' };
   

    // Llamando a las funciones para realizar la verificacion de los campos retorna true o false
    let isValidTrimestre = verificarSelect(tR);
    let isValidnumeroPoblacion = verificarInputNumber(nP,numerosRegex);

   // Si todos los campos que llevan validaciones estan okey o true que realice el ajax o fetch o axios o lo que sea
   if (
       (isValidTrimestre === true) &&
       (isValidnumeroPoblacion === true) 
   ) {
        const dataPoblacionRegistro = {
           Trimestre: Trimestre.value,
           numeroPoblacion: JSON.parse(numeroPoblacion.value),
           poblacion:poblacion,
           idUsuario: Usuario['idUsuario']
        };
        $.ajax(`${ API }/control-estudiantes-docentes/modificarDocentesEstudiantes.php`, {
            type: 'POST',
            dataType: 'json',
            data: (dataPoblacionRegistro),
            success:function(response) {
                    const { data } = response;
                    console.log(data)
                    // $("#TrimestreM").val('').trigger("change");
                    // $(`#${poblacionVar}`).val('').trigger("change");
                    // Swal.fire({
                    //     icon: 'success',
                    //     title: 'Listo!',
                    //     text: `El numero de ${poblacion} se modifico con exito`,
                    //     footer: '<b></b>'
                    // });
            },
            error:function(error) {
                const { status, data } = error.responseJSON;
                if (status === 401) {
                    window.location.href = '../views/401.php';
                }else{
                    Swal.fire({
                        icon: 'error',
                        title: 'Ops...',
                        text: `${ data.message }`,
                        footer: '<b>Por favor verifique el formulario de registro</b>'
                    })
                };
            }
        });
   } else { // caso contrario mostrar alerta y notificar al usuario 
       Swal.fire({
           icon: 'error',
           title: 'Ops...',
           text: 'El registro de la carrera no se pudo realizar',
           footer: '<b>Por favor verifique el formulario de registro</b>'
       })
   }
}

const CerrarModal=()=>{
    let poblacionVar='';
    if(document.querySelector("#Poblacion").value==1){
        poblacionVar="NumEstudiantesMatriculados";
    }else if(document.querySelector("#Poblacion").value==2){
        poblacionVar="NumEgresados";
    }else if(document.querySelector("#Poblacion").value==3){
        poblacionVar="NumDocentes";
    }
    $("#Trimestre").val('').trigger("change");
    $("#respaldo").val('').trigger("change");
    $(`#${poblacionVar}`).val('').trigger("change");
    $("#tabla").css("display","none");
    verRegistro();
    document.querySelector(`#labelrespaldo`).classList.remove('text-danger')
    document.querySelector('#respaldo').classList.remove('text-danger');
    document.querySelector('#respaldo').classList.remove('is-invalid')
    document.querySelector(`#errorsrespaldo`).classList.add('d-none');
    document.querySelector('#Trimestre').classList.remove('text-danger');
    document.querySelector('#Trimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsTrimestre`).classList.add('d-none');
    document.querySelector(`#label${poblacionVar}`).classList.remove('text-danger')
    document.querySelector(`#${poblacionVar}`).classList.remove('text-danger');
    document.querySelector(`#${poblacionVar}`).classList.remove('is-invalid')
    document.querySelector(`#errors${poblacionVar}`).classList.add('d-none');
    $("#registrarNumero").prop("disabled",true);
}

const CerrarModalM=(poblacion)=>{
    let poblacionVar='';
    if(poblacion=='Estudiantes Matriculados'){
        poblacionVar="NumEstudiantesMatriculados";
    }else if(poblacion=='Egresados'){
        poblacionVar="NumEgresados";
    }else if(poblacion=='Docentes con Maestria'){
        poblacionVar="NumDocentes";
    }
    $("#TrimestreM").val('').trigger("change");
    verRegistro();
    document.querySelector('#Trimestre').classList.remove('text-danger');
    document.querySelector('#Trimestre').classList.remove('is-invalid')
    document.querySelector(`#errorsTrimestre`).classList.add('d-none');
    document.querySelector(`#label${poblacionVar}`).classList.remove('text-danger')
    document.querySelector(`#${poblacionVar}`).classList.remove('text-danger');
    document.querySelector(`#${poblacionVar}`).classList.remove('is-invalid')
    document.querySelector(`#errors${poblacionVar}`).classList.add('d-none');
}

const mostrarValorASubir = () =>{
    let file = $('#documentoSubido').prop('files');
    $('#respaldo').val(file[0].name);
}

const nuevo = () =>{
    let file = $('#docUpload').prop('files');
    // alert(file[0].name);
    // $("#docUpload").val('');
    Swal.fire({
        icon: 'success',
        title: 'Listo!',
        text: `El documento de respaldo se modifico con exito, se cambio por ${file[0].name}`,
        footer: '<b></b>'
    });
    //    $.ajax(`${ API }/Carreras/registrarCarrera.php`, {
    //        type: 'POST',
    //        dataType: 'json',
    //        data: (dataNuevoCarrera),
    //        success:function(response) {
    //            const { data } = response;
    //            $("#Carrera").val('').trigger("change");
    //            $("#Abreviatura").val('').trigger("change");
    //            $("#Departamento").val('').trigger("change");
    //            $("#Estado").val('').trigger("change");
    //            Swal.fire({
    //                icon: 'success',
    //                title: 'Accion realizada Exitosamente',
    //                text: `${ data.message }`,
    //            })
    //        },
    //        error:function(error) {
    //            const { status, data } = error.responseJSON;
    //            if (status === 401) {
    //                window.location.href = '../views/401.php';
    //            }else{
    //                Swal.fire({
    //                    icon: 'error',
    //                    title: 'Ops...',
    //                    text: `${ data.message }`,
    //                    footer: '<b>Por favor verifique el formulario de registro</b>'
    //                })
    //            };
    //        }
    //    });
}


//petición para obtener la imagen adjunta de la solicitud seleccionada
const visualizarAdjuntos = (respaldo) => {
    console.log(respaldo);
    $('#modalRespaldoAdjunto').modal('show');
    if (respaldo != null){
        $('#V-respaldoAdjunto').html(`<img src="../../../backend/uploads/documentoRespaldo/departamento/${respaldo}" class="mx-auto img-fluid  img-responsive" /> `);
    }else {
        $('#V-respaldoAdjunto').html(`<h6 align="center" style="color:#ffc107" > No se adjunto imagen de respaldo <h6/> `);
    }
}

const actualizarRespaldo = () =>{
    $('#docUpload').trigger('click')
}