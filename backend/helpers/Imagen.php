<?php 
    class Imagen {
        private $imagen;
        private $rutaDestino;
        private $nombreImagen;
        private $tipoImagen;
        private $tamanio;
        private $carpeta;

        public function getImagen() {
            return $this->imagen;
        }

        public function setImagen($imagen) {
            $this->imagen = $imagen;
            return $this;
        }

        // Verificar si el directorio existe
        public function verificaExistenciaCarpeta ($directorio) {
            mkdir($directorio, 0777);
        }

        public function __construct($imagen, $carpeta) {
            $this->imagen = $imagen;
            $this->carpeta = $carpeta;
            //ruta destino imagen DOCUMENT_ROOT->HTDOCS
            $this->rutaDestino = $_SERVER['DOCUMENT_ROOT']."/php/seccion-de-pruebas/subida-imagenes-servidor/uploads";
            if (!file_exists($this->rutaDestino)) {
                $this->verificaExistenciaCarpeta($this->rutaDestino);
            } 
            if (!file_exists($this->rutaDestino . '/images')) {
                $this->verificaExistenciaCarpeta($this->rutaDestino . '/images');
            } 
            if (!file_exists($this->rutaDestino . '/images/' . $this->carpeta)) {
                $this->verificaExistenciaCarpeta($this->rutaDestino . '/images/' . $this->carpeta);
            } 
        }
        
        // Sube la imagen 
        public function subirImagen () {
            //si existe un fichero con nombre file que capture lo siguiente
            if(isset($this->imagen)) {
                //Propiedades de la imagen
                $this->nombreImagen = $this->imagen['imagen']['name'];
                $this->tipoImagen = $this->imagen['imagen']['type'];
                $this->tamanio = $this->imagen['imagen']['size'];

                //si el tamaño de la imagen es mayor a 1 MB
                if($this->tamanio <= 1000000) {
                    //si los archivos no concuerdan con este formato que envie un mensaje
                    if ($this->tipoImagen != 'image/jpg' && $this->tipoImagen != 'image/jpeg' && $this->tipoImagen != 'image/png' && $this->tipoImagen != 'image/gif') {
                        return 'El archivo no se puede procesar debido a que no es una imagen';

                    } else { //caso contrario que procese la imagen
                        

                        //primer parametro la ruta temporal donde se almacena y segundo la carpeta de destino
                        //la movemos del directorio temporal al escogido
                        move_uploaded_file($_FILES['imagen']['tmp_name'] , $this->rutaDestino . date("YmdHis") . $this->nombreImagen);
                        return "Imagen almacenada con exito";
                        }

                    } else {
                        return 'El tamaño de la imagen es muy grande';
                    }
            } else {//caso contrario
                return "No hay archivos seleccionados";
            }
        }

        public function removerImagen ($ubicacionImagen) {
            return unlink($this->rutaDestino . '/' . $ubicacionImagen);
        }
    }
?>