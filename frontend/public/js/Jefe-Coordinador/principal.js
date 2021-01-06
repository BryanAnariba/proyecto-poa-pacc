var arreglo = [
    {estado: "pendiente", dimension:"Dimension 1"},
    {estado: "llena", dimension:"Dimension 2"},
    {estado: "llena", dimension:"Dimension 3"},
    {estado: "pendiente", dimension:"Dimension 4"},
    {estado: "llena", dimension:"Dimension 5"},
    {estado: "pendiente", dimension:"Dimension 6"},
    {estado: "llena", dimension:"Dimension 7"},
    {estado: "pendiente", dimension:"Dimension 8"},
    {estado: "llena", dimension:"Dimension 9"},
    {estado: "pendiente", dimension:"Dimension 10"},
    {estado: "llena", dimension:"Dimension 11"}];
var estado = 1;

var dimension = [];

$(document).ready(function(){
    if(estado==0){
        $("#mda").css("opacity", "0.6");
        $("#mda div div button").prop('disabled', true);
        $("#aga").css("opacity", "0.6");
        $("#aga div div button").prop('disabled', true);
    }else{
        $("#mda").css("opacity", "1");
        $("#mda div div button").prop('disabled', false);
        $("#aga").css("opacity", "1");
        $("#aga div div button").prop('disabled', false);
    }
    $("#ventana2").css("display","none");
    $("#ventana3").css("display","none");
    $(".foot-modif").css("display","none");
    $("#ventana1A").css("display","none");
    $(".foot-agr").css("display","none");
});
const avanzarA = () =>{
    $("#ventana1").css("display","none");
    $("#ventana2").css("display","block");
    llenar("DimensionesTablaModificar3");
}
const avanzarB = () =>{
    $("#ventana1").css("display","none");
    $("#ventana2").css("display","none");
    $("#ventana3").css("display","block");
    $(".foot-modif").css("display","block");
}
const avanzarAgreg = ()=>{
    $("#ventanaA").css("display","none");
    $("#ventana1A").css("display","block");
    $(".foot-agr").css("display","block");
};
const llenar = (tabla) => {
    $('#'+tabla).dataTable().fnDestroy();
    $('#'+tabla+' tbody').html(``);
    switch(tabla) {
        case 'DimensionesTabla':
            for (let i=0;i<this.arreglo.length; i++) {
                if(this.arreglo[i].estado=="pendiente"){
                    $('#DimensionesTabla tbody').append(`
                        <tr align="center">
                            <td>
                                <div class="rojo" row>
                                    <i class="fas fa-exclamation"></i><div style="display:none">${this.arreglo[i].estado}</div>
                                </div>
                            </td>
                            <td>${ this.arreglo[i].dimension }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="avanzar('${ this.arreglo[i].dimension }','${this.arreglo[i].estado}')">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }else if(this.arreglo[i].estado=="llena"){
                    $('#DimensionesTabla tbody').append(`
                        <tr align="center">
                            <td>
                                <div class="verde row">
                                    <i class="fas fa-exclamation"></i><div style="display:none">${this.arreglo[i].estado}</div>
                                </div>
                            </td>
                            <td>${ this.arreglo[i].dimension }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="avanzarM()" disabled>
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }
            };
          break;
        case 'DimensionesTablaModificar':
            $("#ventana1").css("display","block");
            $("#ventana2").css("display","none");
            $("#ventana3").css("display","none");
            $(".foot-modif").css("display","none");
            for (let i=0;i<this.arreglo.length; i++) {
                if(this.arreglo[i].estado=="pendiente"){
                    
                }else if(this.arreglo[i].estado=="llena"){
                    $('#DimensionesTablaModificar tbody').append(`
                        <tr align="center">
                            <td>
                                <div class="verde row">
                                    <i class="fas fa-exclamation"></i><div style="display:none">${this.arreglo[i].estado}</div>
                                </div>
                            </td>
                            <td>${ this.arreglo[i].dimension }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="avanzarA()">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }
            };
          break;
          case 'DimensionesTablaModificar3':
            for (let i=0;i<this.arreglo.length; i++) {
                if(this.arreglo[i].estado=="pendiente"){
                    
                }else if(this.arreglo[i].estado=="llena"){
                    $('#DimensionesTablaModificar3 tbody').append(`
                        <tr align="center">
                            <td>
                                <div class="verde row">
                                    <i class="fas fa-exclamation"></i><div style="display:none">${this.arreglo[i].estado}</div>
                                </div>
                            </td>
                            <td>${ this.arreglo[i].dimension }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="avanzarB()">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }
            };
          break;
        case 'DimensionesTablaAgregar':
            for (let i=0;i<this.arreglo.length; i++) {
                if(this.arreglo[i].estado=="pendiente"){
                    
                }else if(this.arreglo[i].estado=="llena"){
                    $('#DimensionesTablaAgregar tbody').append(`
                        <tr align="center">
                            <td>
                                <div class="verde row">
                                    <i class="fas fa-exclamation"></i><div style="display:none">${this.arreglo[i].estado}</div>
                                </div>
                            </td>
                            <td>${ this.arreglo[i].dimension }</td>
                            <td>
                                <button type="button" class="btn btn-amber" onclick="avanzarAgreg()">
                                    <img src="../img/menu/editar.svg" alt="modificar dimension"/>
                                </button>
                            </td>
                        </tr>
                    `);
                }
            };
          break;
        default:
            console.error("opcion no disponible");
    };
    $('#'+tabla).DataTable({
        language: i18nEspaniol,
        "lengthMenu": [[3, 6, 9, -1], [3, 6, 9, "All"]],
        retrieve: true
    });
    
};

const avanzar = (dimension,estado) =>{
  this.dimension.push(dimension,estado);
  localStorage.setItem("Dimension", JSON.stringify(this.dimension));
  window.location.href = "/proyecto-poa-pacc/frontend/public/views/llenado-dimension-jefeCoordinador.php";
};
