const cerrarSesion = () => {
    $.ajax(`${ API }/usuarios/logOut.php`,{
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function (response) {
            const { status, data } = response;
            if (status === 200) {
                window.location.href = '../views/401.php';
            }
        }, 
        error: function(error) {
            const { status, data } = error.responseJSON;
            Swal.fire({
                icon: 'error',
                title: 'Ops...',
                text: `${ data.message }`,
                footer: '<b>Ha ocurrido un error</b>'
            });
        }
    });
}