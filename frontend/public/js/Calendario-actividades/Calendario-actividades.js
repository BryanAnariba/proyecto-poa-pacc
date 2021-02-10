var obj = [];
$(document).ready(function(){
    cambiarObj();
    cambiarDepa();
});
const cambiarDepa = () => {
    const peticion = {
        nada: ""
    };
    $.ajax(`${ API }/Carreras/obtenerDepartamentos.php`, {
        type: 'POST',
        dataType: 'json',
        data: (peticion),
        success:function(response) {
            document.getElementById("Departamento3").innerHTML="<option value='' disabled selected></option>";
            for(let i = 0; i < response.data.length;i++){
                document.getElementById("Departamento3").innerHTML+=`<option value="${response.data[i].idDepartamento}">${response.data[i].nombreDepartamento}</option>`;
            }
        },
        error:function(error) {
            const { status, data } = error.responseJSON;
            if (status === 401) {
                window.location.href = '../views/401.php';
            }
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`
            });
        }
    });
};
const cambiarObj = () => {
    switch(Usuario['abrevTipoUsuario']) {
        case 'C_C':
            obj.push(    {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-01-02',
                end  : '2021-01-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-12-01',
                end  : '2022-01-01',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Papeleria',
                start  : '2021-06-01',
                end  : '2021-07-01',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Lapices',
                start  : '2021-06-01',
                end  : '2021-07-01',
                color: '#1a237e',
                textColor: 'white'
            });
          break;
        case 'SE_AD':
            obj.push(    {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-02-02',
                end  : '2021-03-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-02-02',
                end  : '2021-03-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-02-02',
                end  : '2021-03-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-02-02',
                end  : '2021-03-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-02-02',
                end  : '2021-03-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-02-02',
                end  : '2021-03-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Contratacion del especialista',
                start  : '2021-02-02',
                end  : '2021-03-03',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Papeleria',
                start  : '2021-06-01',
                end  : '2021-07-01',
                color: '#1a237e',
                textColor: 'white'
            },
            {
                id : 1,
                title  : 'Lapices',
                start  : '2021-06-01',
                end  : '2021-07-01',
                color: '#1a237e',
                textColor: 'white'
            });
          break;
        default:
          // code block
      }
};
const cambioAct = (actividad) => {
    // alert(document.querySelector('#actividadFecha'));
    $('#calend').css('display','block');
};