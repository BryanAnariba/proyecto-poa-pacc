$(document).ready(function () {
    $.ajax(`${ API }/usuarios/menu.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function(response) {
            console.log(response);
        },
        error:function(error) {
            
            console.error(error);
            const { data } = error.responseJSON;
                Swal.fire({
                    icon: 'error',
                    title: 'Ops...',
                    text: `${ data.message }`,
                    footer: '<b>Debes loguearte nuevamente</b>',
                    confirmButtonText: "Ir al login"
                });
                
            if (data.status === 401) {
                window.location = '../../../views/401.php';
            }
        }
    });
});