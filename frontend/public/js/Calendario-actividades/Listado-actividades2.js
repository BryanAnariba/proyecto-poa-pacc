var arregloActividades = [
    {Correlativo: "IS-2021-1-1", 
    Departamento:'Ingenieria en sistemas',
    DimensionEstrategica:"DESARROLLO E INNOVACIÓN CURRICULAR",
    ObjetivoInstitucional:" Impulsar un proceso de desarrollo curricular siguiendo los lineamientos del Modelo Educativo de la UNAH en consonancia con las nuevas tendencias y diversidad educativa (formal, no formal y continua); se diseñaran currículos innovadores (abiertos, flexibles e incluyentes) acordes a estándares internacionales y que contaran con referentes axiológicos que orienten la selección de contenidos y la coherencia entre estos.",
    AreaEstrategica:"Mejoramiento de la Calidad Educativa.",
    TemaActividad:"Finalizar documentos que conforman el Rediseño Curricular. Socializar cambios una vez esté aprobado.",
    NumeroDeActividadesDefinidas:6},
    {Correlativo: "IS-2021-2-1", 
    Departamento:'Ingenieria en sistemas',
    DimensionEstrategica:"INVESTIGACION CIENTÍFICA",
    ObjetivoInstitucional:"Consolidar el sistema de investigación científica y tecnológica de la UNAH, para posicionarse en una situación de liderazgo nacional y regional, tanto del conocimiento como de sus aplicaciones, desarrollando una investigación de impacto nacional y con reconocimiento internacional, ampliamente integrada a la docencia, especialmente al postgrado y vinculada a la solución de problemas, promoviendo sustantivamente el desarrollo del país.",
    AreaEstrategica:"Las facultades y los centros regionales se insertan en el eje de fomento de la investigación; desarrollan investigación en el marco de las prioridades de investigación.",
    TemaActividad:"Elaboración de propuesta de idea de innovación.",
    NumeroDeActividadesDefinidas:2}];

$(document).ready(function (){
    TablaInicio();
});

const TablaInicio = () => {
    $('#ActividadesListado').dataTable().fnDestroy();
    $('#ActividadesListado tbody').html(``);
    
    for (let i=0;i<arregloActividades.length; i++) {
        $('#ActividadesListado tbody').append(`
            <tr align="center">
                <td scope="row">${ i + 1 }</td>
                <td>${ arregloActividades[i].Correlativo }</td>
                <td>${ arregloActividades[i].Departamento }</td>
                <td>${ arregloActividades[i].DimensionEstrategica }</td>
                <td>${ arregloActividades[i].ObjetivoInstitucional }</td>
                <td>${ arregloActividades[i].AreaEstrategica }</td>
                <td>${ arregloActividades[i].TemaActividad }</td>
                <td>${ arregloActividades[i].NumeroDeActividadesDefinidas }</td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('resultado')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('justificacion')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('presupuesto')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
                <td>
                    <button type="button" class="btn btn-amber" onclick="llenar('actividades')">
                        <img src="../img/menu/ver-icon.svg" alt="modificar dimension"/>
                    </button>
                </td>
            </tr>
        `)
    }
    $('#ActividadesListado').DataTable({
        language: i18nEspaniol,
        //dom: 'Blfrtip',
        //buttons: botonesExportacion,
        retrieve: true,
    });
};