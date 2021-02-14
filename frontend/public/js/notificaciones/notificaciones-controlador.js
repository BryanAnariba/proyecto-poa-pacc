//petición para las notificaciones
//pendiente de subir hasta que este completo...
const notificaciones = () => {

    $.ajax(`${ API }/control-notificaciones/generarNotificacionesPorUsuario.php`, {
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        success:function(response) {
            //console.log(data);
            let cantidadSolicitudes = response.data[0].cantidadSolicitudes;
            if (cantidadSolicitudes != 0){
                $('#contador').html(`${cantidadSolicitudes}`);
                //$('#dropdown-notificaciones').html(`<a class="dropdown-item" href="#">Tiene solicitudes de permisos pendientes</a>`);
                $('#dropdown-notificaciones').html(`
                    <a class="dropdown-item" href="../views/control-recibir-permisos.php">
                    <img src="../img/control-notificaciones/icono-soli.svg" alt="solicitudes"> Tiene Permisos pendientes</a>
                `);
            }else {
                $('#dropdown-notificaciones').html(`<a class="dropdown-item" href="#">No hay Notificaciones</a>`);
                
            }
            
        },
        error:function(error) {
            console.warn(error);
            const { status, data } = error.responseJSON;
            if (status === 401) {
                window.location.href = '../views/401.php';
            }
            
        }
    });
};


