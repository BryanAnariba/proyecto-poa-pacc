        
        <!--script src="../js/libreria-bootstrap-mdb/jquery-ui.min.js"></script-->
        <script src="../js/libreria-bootstrap-mdb/popper.min.js"></script>
        <script src="../js/libreria-bootstrap-mdb/bootstrap.min.js"></script>
        <script src="../js/libreria-bootstrap-mdb/mdb.min.js"></script>
        <script src="../js/menu/menu-principal.js"></script>
        <script src="../js/navbar/navbar.js"></script>
        <script src="../js/notificaciones/notificaciones-controlador.js"></script>
        
    <?php 
        if ($_SESSION['abrevTipoUsuario'] === 'S_AC') {
            echo '
                <script type="text/javascript">
                    setInterval(notificaciones,100);
                </script>';
            
        }

    ?>
    </body>
</html>