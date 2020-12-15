// Enpoint o URI general, a partir de esta URI se debera hacer las peticiones
const API = 'http://localhost/proyecto-poa-pacc/backend/api';

// Expresiones regulares
const numeroTelefonoRefex = /^(2\d{3})(-)?\d{4}/;
const numerosRegex = /^[+]?([0-9]+(?:[\.][0-9]*)?|\.[0-9]+)$/;
const unahEmailRegex = /[A-Za-z][\w]*@unah(\.edu)?\.hn/;
const letrasEspaciosRegex = /^[ñA-Za-z _]*[ñA-Za-z][ñA-Za-z _]*$/;
const avatarUsuarioRegex = /^.+\.(jpe?g|gif|png)$/i;
const codigoEmpleadoRegex = /^\d{1,5}$/;