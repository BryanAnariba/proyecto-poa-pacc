-- Inserts para llenado de la Base de datos Proyecto POA-PACC
-- Llena dimemsiones administrativas y estrategicas, asi coo los objetivos 
--institucionales y sus respectivas areas estrategicas

-- INSERTANDO DIMENSIONES ADMINISTRATIVAS
INSERT INTO `DimensionAdmin` (`idDimension`, `dimensionAdministrativa`, `idEstadoDimension`) 
VALUES (NULL, 'TALLERES SEMINARIOS', '1'), 
    (NULL, 'CONTRATACION DE PERSONAL', '1'), 
    (NULL, 'EQUIPO DE OFICINA', '1'), 
    (NULL, 'EQUIPO TECNOLÓGICOS', '1'), 
    (NULL, 'ACTIVIDADES ESPECIALES', '1'), 
    (NULL, 'BECAS', '1'), 
    (NULL, 'INFRAESTRUCTURA', '1'), 
    (NULL, 'VENTA DE SERVICIOS', '1');


-- INSERTANDO DIMENSIONES ESTRATEGICAS
INSERT INTO `DimensionEstrategica` (`idDimension`, `idEstadoDimension`, `dimensionEstrategica`) 
VALUES (NULL, '1', 'Desarrollo e Innov. Curricu.'), 
    (NULL, '1', 'Investigación Científica'), 
    (NULL, '1', 'Vinculación Univ. Sociedad'), 
    (NULL, '1', 'Docencia y Profesorado Univ.'), 
    (NULL, '1', 'Estudiantes y Graduados'), 
    (NULL, '1', 'Gestión del Conocimiento'), 
    (NULL, '1', 'Lo Esencial de la Reforma U.'), 
    (NULL, '1', 'Cultura de Inno. Insti...'), 
    (NULL, '1', 'Asegura. de la Calid. y M'), 
    (NULL, '1', 'Posgrado'), 
    (NULL, '1', 'Gestion Administrativa'), 
    (NULL, '1', 'Gestión del Talento Humano'), 
    (NULL, '1', 'Gestión Académica'), 
    (NULL, '1', 'Internacional... de la E.S.'), 
    (NULL, '1', 'Gobernabilidad y Proceso...'), 
    (NULL, '1', 'Desa. del Sistema Educ.Sup.'), 
    (NULL, '1', 'Gestión TIC');


-- iNSERTANDO OBJETIVOS INSTITUCIONALES PARA CADA DIMENSION ESTRATEGICA
INSERT INTO `ObjetivoInstitucional` (`idObjetivoInstitucional`, `idDimensionEstrategica`, `idEstadoObjetivoInstitucional`, `objetivoInstitucional`) 
VALUES (NULL, '1', '1', 'Impulsar un proceso de desarrollo curricular siguiendo los lineamientos del Modelo Educativo de la UNAH en consonancia con las nuevas tendencias y diversidad educativa (formal, no formal y continua); se diseñaran currículos innovadores (abiertos, flexibles e incluyentes) acordes a estándares internacionales y que contaran con referentes axiológicos que orienten la selección de contenidos y la coherencia entre estos.'), 
    (NULL, '1', '1', 'Consolidar la aplicación de la política de bimodalidad en la UNAH.'), 
    (NULL, '2', '1', 'Consolidar el sistema de investigación científica y tecnológica de la UNAH, para posicionarse en una situación de liderazgo nacional y regional, tanto del conocimiento como de sus aplicaciones, desarrollando una investigación de impacto nacional y con reconocimiento internacional, ampliamente integrada a la docencia, especialmente al postgrado y vinculada a la solución de problemas, promoviendo sustantivamente el desarrollo del país.'), 
    (NULL, '3', '1', 'Fortalecer de manera permanente y sostenida la Vinculación de la UNAH con el Estado, sus graduados, las fuerzas sociales, productivas y demás que integran la sociedad hondureña.'), 
    (NULL, '3', '1', 'Crear en la comunidad universitaria una cultura de compromiso social, a través de la construcción de redes y ámbitos de inserción con la sociedad hondureña, para construir vías de comunicación y de acción efectivas entre distintas comunidades y la Universidad, para construir participativamente valores, conocimientos y espacios de  mutuo aprendizaje.'), 
    (NULL, '3', '1', 'Focalizar la inserción de los graduados universitarios en los mercados de trabajo, su seguimiento y actualización educativa, con estudios de postgrado, que sean pertinentes a los programas acádemicas y de actualización continua.'), 
    (NULL, '4', '1', 'Empoderar y formar de manera permanente al profesorado universitario en prácticas académicas innovadoras, alineadas con los objetivos académicos, estratégicos y del  Modelo Educativo de la Universidad, con el propósito que construyan las múltiples competencias para su transformación académica y la de los estudiantes (actualización, innovación, culturización) con valores y ética, en el plano docente, humanístico y disciplinar.'), 
    (NULL, '5', '1', 'Propiciar cambios en la calidad de vida y formación académica de los estudiantes universitarios; articulando procesos de orientación, asesoría, salud, cultura, deporte, estímulos académicos y atención diferenciada e inclusiva, con el fin de lograr el desarrollo estudiantil para el logro de su excelencia académica y profesional.'), 
    (NULL, '5', '1', 'Focalizar la inserción de los graduados universitarios en los mercados de trabajo, con miras al cambio, haciendo enfasis en el emprendedurismo, su seguimiento y actualización educativa profesional, con estudios de postgrado que sean pertinentes a las necesidades que enfrenta el país, al desarrollo de la ciencia y la tecnología y, a  la   actualización continua de los graduados.'), 
    (NULL, '5', '1', 'Velar y promover de manera efectiva, la inclusión de los Graduados Universitarios calificados para el relevo docente ( entre otros, reorientado y fortaleciendo a través de un nuevo Reglamento, a los Instructores).'), 
    (NULL, '6', '1', 'Gestionar y promover el conocimiento científico y social para contribuir a la superación de los principales problemas del país, para satisfacer las necesidades prioritarias y desplegar las potencialidades para el desarrollo humano sostenible a nivel local, nacional y regional a través de la movilidad y el intercambio, el uso de las TICs y funcionamiento de redes, entre otros.'), 
    (NULL, '7', '1', 'Transversalizar en los planes de estudios, curriculares y didácticos, y en todas las funciones académicas y actividades administrativas de la UNAH, la PRÁCTICA DE LA ÉTICA, la identidad y la cultura para la construcción de ciudadanía: ÉTIC'), 
    (NULL, '7', '1', 'Garantizar una educación integral, que incorpore la gestión académica del conocimiento, de cultura para el desarrollo, como parte de la dinámica institucional, y del perfil profesional, orientado al fortalecimiento de la ciudadano. '), 
    (NULL, '7', '1', 'Priorizar la producción y gestión del conocimiento con alto contenido de identidad nacional, regional y local; que refuerce el saber local-regional, aborde los problemas nacionales, y que transite hacia la internacionalización del conocimiento.'), 
    (NULL, '7', '1', 'Fortalecer en la comunidad universitaria la práctica de la cultura física y deportes, el aprecio por las artes y la cultura como parte de la formación integral y del buen vivir.'), 
    (NULL, '8', '1', 'Fortalecer la cultura de la Innovación Institucional y Educativa e implementar el modelo de innovación educativa de la UNAH, que integre el currículo, las metodologías, las estrategias de enseñanza y aprendizaje, los materiales y recursos didácticos, el uso educativo de las TIC, la relación con el entorno, la profesionalización docente, y la profesionalización de la dirección y conducción de la UNAH.'), 
    (NULL, '9', '1', 'Mejora continua y acreditación de la calidad de la UNAH, sus servicios y funciones sustantivas de docencia, investigación y vinculación universidad-sociedad. y programas;  evidenciada en la rendición de cuentas a la sociedad hondureña y en la atención oportuna efectiva y pertinente a las demandas auténticas de ésta. '), 
    (NULL, '9', '1', 'Promover un sistema de aseguramiento de la calidad en la UNAH, con participación de todas las Unidades Académicas, Administrativas, Financieras y Logísticas.'), 
    (NULL, '9', '1', 'Convertir a la Universidad en una Institución respetuosa del medio ambiente, saludable y segura para todos que cree conciencia y promueva estilos de vida saludables dentro de la sociedad, con el propósito de fortalecer la participación ciudadana, la critica constructiva y la creatividad.'), 
    (NULL, '10', '1', 'Posicionar a la UNAH como una institución líder en la formación de posgrados a nivel nacional, generando una oferta de posgrados de estricta pertinencia con las necesidades de conocimiento que los distintos sectores de la sociedad hondureña requieren, lo que unido a la calidad de los programas y a su capacidad de actualización, están en consonancia con los desafíos de crecimiento y desarrollo del país y la región.'), 
    (NULL, '11', '1', 'Lograr un desarrollo institucional acorde con los ingresos económicos, de modo que se asegure su viabilidad futura, focalizado en el mejoramiento de la situación económico-financiera de la UNAH y su desarrollo a través de la generación de ingresos y del aumento a la productividad. Para ello se busca mejorar la eficiencia de los recursos e insumos, el crecimiento y mantenimiento de la infraestructura de acuerdo a las necesidades de la calidad y las perspectivas de expansión en un ambiente de calidad, acogedor, diverso y pluralista con una infraestructura de calidad, estéticamente atractiva e inserta en un entorno natural y cultural privilegiado que favorezca el trabajo académico y la convivencia social.'), 
    (NULL, '11', '1', 'Innovar, crear y mejorar la gestión administrativa-financiera, en función de la actividad académica y de los diferentes insumos y recursos institucionales, y aquellos que se generen por las diferentes unidades, aplicando procesos administrativos y principios de eficiencia, eficacia, oportunidad, transparencia y rendición de cuentas en todos los actos de la UNAH.'), 
    (NULL, '12', '1', 'Promover de manera planificada el permanente desarrollo del talento  humano docente y administrativo de la UNAH en todo el ciclo vital, productivo y laboral: captación, selección, inducción, desempeño, despliegue de capacidades y potencialidades, capacitación, formación, distribución, egreso. y vínculo social e institucional; asegurando el relevo  en nuevos campos del conocimiento científico, técnico y humanístico.\r\n'), 
    (NULL, '13', '1', 'Contar con una gestión académica de calidad y pertinente a la complejidad de la UNAH, ágil, moderna y flexible que permita un apoyo efectivo al desarrollo de las funciones fundamentales de la Universidad y del proceso educativo; por medio de la formulación y aplicación a través de un sistema automatizado de políticas, normas y procedimientos académicos ; que orienta la planificación, organización, integración y control de los servicios de soporte a la docencia, investigación, vinculación universidad-sociedad, gestión del conocimiento, y la monitoria y evaluación de dichas funciones, con un enfoque de gestión basada en resultados y evaluación de alcances.'), 
    (NULL, '14', '1', 'Liderar y coordinar los esfuerzos institucionales de internacionalización de la educación superior, a fin de contribuir de manera eficaz al fortalecimiento y mejoramiento académico de la UNAH en el marco de la Reforma Universitaria.'), 
    (NULL, '15', '1', 'Fortalecer y consolidar el gobierno universitario, basando sus acciones y decisiones en los principios de Democracia, Respeto, Responsabilidad, Subsidiaridad, Transparencia y Rendición de cuentas.'), 
    (NULL, '15', '1', 'Fortalecer y consolidar las responsabilidades de la UNAH en el papel de organizar, dirigir y desarrollar la educación superior del país.'), 
    (NULL, '15', '1', 'Avanzar de manera planificada y progresiva en un proceso de descentralización de la gestión académica y administrativa financiera hacia las redes educativas regionales '), 
    (NULL, '16', '1', 'Fortalecer y consolidar las responsabilidades de la UNAH en el papel de organizar, dirigir y desarrollar la educación superior del país.'), 
    (NULL, '17', '1', 'Consolidar y asumir el liderazgo nacional en las Tecnologías de la Información y Comunicación para la academia, la ciencia y la cultura.'), 
    (NULL, '17', '1', ' Integrar activamente a la UNAH al campo de la Bimodalidad (Educación presencial y a Distancia en todas sus expresiones) incorporando la tecnología de forma permanente.'), 
    (NULL, '17', '1', 'Mantener y fortalecer a la UNAH con una infraestructura de redes, telecomunicaciones, equipo ofimático y aplicaciones informáticas (hardware y software), como plataforma para todo el quehacer universitario.'), 
    (NULL, '17', '1', 'Consolidar el Gobierno Electrónico institucional a través de la sistematización, automatización de los procesos académicos y administrativos a través de las TIC en forma ágil y eficiente.');


-- INSERTANDO AREAS ESTRATEGICAS PARA CADA OBJETIVO INSTITUCIONAL DE CADA DIMENSION ESTRATEGICA
INSERT INTO `AreaEstrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '1', 'Mejoramiento de la Calidad Educativa.'), 
    (NULL, '1', '2', 'Mejoramiento de la Calidad Educativa. '), 
    (NULL, '1', '3', 'a) Las facultades y los centros regionales se insertan en el eje de fomento de la investigación; desarrollan investigación en el marco de las prioridades de investigación.'),
    (NULL, '1', '3', 'b) Las Facultades y los Centros Regionales se insertan en el eje de publicación, difusión y comunicación; promueven y publican las investigaciones realizadas por su personal docente y estudiantil.'), 
    (NULL, '1', '3', 'c) Las facultades y los centros regionales  se insertan en el eje de protección de los resultados de investigación; utilizan los resultados de las investigaciones para contribuir a la solución de los problemas prioritarios del país y al desarrollo científico y técnico.'),
    (NULL, '1', '3', 'd) Las facultades y los centros regionales  se insertan en el eje de capacitación en investigación; aprovechan la oferta de capacitación y actualización en investigación científica.'), 
    (NULL, '1', '3', 'e) Las facultades y los centros regionales se insertan en el eje de gestión de la investigación; cuentan con al menos instancias de gestión y/o ejecución de la investigación que promueven y gestionan recursos internos/ externos y  desarrollan proyectos de investigación que contribuyen a la solución de problemas y a la generación de conocimiento pertinente.'), 
    (NULL, '1', '4', 'A. Vínculos académicos y alianzas estratégicas'), 
    (NULL, '1', '4', 'B. Socialización y creación de conocimiento en vinculación'), 
    (NULL, '1', '4', 'C. Gestión académica y administrativa de la vinculación');

INSERT INTO `AreaEstrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '5', 'A. Servicio Social y gestión del riesgo'), 
    (NULL, '1', '5', 'B. Educacion No Formal'), 
    (NULL, '1', '5', 'C. Comunicación y Difusión'), 
    (NULL, '1', '5', 'D. Desarrollo Local y Cultura'), 
    (NULL, '1', '6', 'A. Inserción laboral'), 
    (NULL, '1', '6', 'B. Actualización profesional y formación continua'), 
    (NULL, '1', '6', 'C. Estudios de seguimiento de graduados'), 
    (NULL, '1', '6', 'D. Asociación de Graduados'), 
    (NULL, '1', '6', 'E. Plataforma Virtual'), 
    (NULL, '1', '6', 'F. Servicios y Beneficios'), 
    (NULL, '1', '6', 'G. Eventos y Encuentros');

INSERT INTO `AreaEstrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '7', 'Fortalecemiento de las competencias docentes para la educación superior que faciliten el aprendizaje y mejoren la eficiencia terminal.'), 
    (NULL, '1', '8', 'a. Brindar atención a los estudiantes universitarios de forma integral en su dimensión psico-pedagógica y social, que involucre aspectos interpersonales-afectivos, mediación de conflictos, orientación, asesoría, rendimiento académico, inducción vocacional y laboral. '), 
    (NULL, '1', '8', 'b. Contribuir a la promoción, prevención y atención integral de la salud en el estudiantado universitario, para mejorar su calidad de vida y rendimiento académico. '), 
    (NULL, '1', '8', 'c. Promover la realización de actividades socioculturales y deportivas tanto recreativas, competitivas y de intercambio estudiantil universitario.'), 
    (NULL, '1', '8', 'd. Contribuir al mejoramiento de la calidad de vida estudiantil mediante la promoción de espacios y beneficios que le permitan el desarrollo de sus potencialidades bajo perspectivas de equidad e inclusión, además de promover una cultura de solidaridad, cooperación y participación ciudadana a través de la formación de líderes y voluntarios universitarios.'), 
    (NULL, '1', '9', 'Mejoramiento de la Calidad, la Pertinencia y la equidad.'), 
    (NULL, '1', '10', 'Fortalecimiento de la Calidad.'), 
    (NULL, '1', '11', 'a) Fortalecimiento y consolidación del proceso de organización y desarrollo de las redes educativas regionales de la UNAH, y de los planes estratégicos y tácticos para continuar con la reforma integral de los centros regionales de la UNAH.'), 
    (NULL, '1', '11', 'b) Mejorar significativamente la cobertura de la UNAH y el acceso de la población hondureña a los servicios académicos de la UNAH.'), 
    (NULL, '1', '11', 'c) Desarrollar los Centros Regionales de la UNAH, como polos de desarrollo científico, técnico, y cultural de las regiones del país.');

INSERT INTO `AreaEstrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '12', 'ÉTICA: Transversalización del Eje Curricular de Ética en las actividades administrativas y como eje integrador de los demás ejes del Modelo Educativo de la UNAH.'), 
    (NULL, '1', '13', 'CIUDADANÍA: Expansión del perfil profesional con elementos de  ciudadanía educativa.'), 
    (NULL, '1', '14', 'IDENTIDAD: Producción del conocimiento con identidad, nacional, regional, local, y para la internacionalización académica de la UNAH.'), 
    (NULL, '1', '15', 'CULTURA: Formación de ciudadanos de cultura, globales, de región, y productivos, potenciando el rol de los CRU.'), 
    (NULL, '1', '16', 'Aplicación del modelo de innovación educativa que integre como ámbitos de innovación educativa: el currículo, las metodologías, las estrategias de enseñanza y aprendizaje, los materiales y recursos didácticos, el uso educativo de las TIC, la relación con el entorno, la profesionalización docente y directiva.'), 
    (NULL, '1', '17', 'Mejoramiento de la Calidad y la Pertinencia.'), 
    (NULL, '1', '18', 'Fortalecimiento de  la Planificación, Monitoria y Evaluación de la Gestión Académica.'), 
    (NULL, '1', '19', 'Mejoramiento de la Calidad, la Pertinencia y la Equidad.'),
    (NULL, '1', '20', 'A) Las facultades y centros regionales se insertan en el eje de Los posgrados, la UNAH y el país; diseñando, posgrados que el país, la ciencia y la propia universidad necesitan, contribuyendo de esa  manera al desarrollo económico, político y social de nuestro país.'), 
    (NULL, '1', '20', 'B) Las facultades y centros regionales se insertan en el eje de Gestión Académico-Institucional; creando y aprobando nuevos posgrados académicos y profesionalizante,con un sistema de posgrados integrado plenamente a los departamentos.'), 
    (NULL, '1', '20', 'C) Las facultades y centros regionales se insertan en el eje de Evaluación y Acreditación; procurando que sus posgrados sean objeto de evaluación  institucional constante, autoevaluación y acreditación regional, para aumentar el prestigio académico de la UNAH. '), 
    (NULL, '1', '20', 'D) Las facultades y centros regionales se insertan en el eje de Investigación, desarrollo e innovación; integrando la función de investigación en sus diferentes posgrados y que estos provechen el programa de investigación que oferta la UNAH (becas, capacitaciones, revistas, congresos)  y la estructura de investigación de la UNAH (institutos, grupos, observatorios) todo ello en alineamiento con las prioridades de investigación de la UNAH y de las facultades y centros regionales.\r\n\r\n'), 
    (NULL, '1', '20', 'E) Las facultades y centros regionales se insertan en el eje de Vinculación Universidad Estado, sectores productivos y sectores sociales; con una relación institucional estructurada, posgrados de la UNAH  reconocidos y contribuyendo al desarrollo económico, social y político del país.'), 
    (NULL, '1', '20', 'F) Las facultades y los centros regionales se insertan en el eje de Regionalización e internacionalización; elaboración y ejecución de estrategias de regionalización interna e internacionalización de los posgrados, con el propósito de formar profesionales con visión de mundo y de enfoque inter y multidisciplinario.'), 
    (NULL, '1', '20', 'G) Las facultades y los centro regionales se insertan en el eje de Formación y capacitación; registrando y acreditando un cuerpo de profesionales especializado en la gestión de posgrados, incluyendo el componente de investigación.');

INSERT INTO `AreaEstrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '21', 'Las Unidades Académicas y Administrativas disponen y tienen  acceso a los servicios de la plataforma tecnológica y al programa de desarrollo tecnológico de la UNAH.'), 
    (NULL, '1', '21', 'La infraestructura de las sedes universitarias en termino de aulas, salones, talleres, laboratorios, oficinas u otros, son suficientes y adecuados para el logro de los objetivos institucionales.'), 
    (NULL, '1', '21', 'Los Departamentos Académicos y las carreras disponen del equipo didáctico necesario para facilitar el proceso del desarrollo educativo.'), 
    (NULL, '1', '22', 'La unidad académica cuenta con un presupuesto que le permite realizar adecuadamente las funciones de docencia, investigación, vinculación y gestión académica programadas por la carrera.'), 
    (NULL, '1', '22', 'La institución cuenta con la normativa interna e institucional para garantizar la buena organización, el buen funcionamiento y el cumplimiento de las normas y procedimientos.'), 
    (NULL, '1', '23', 'Fortalecimiento Institucional mediante el desarrollo Docente y Personal Administrativo responde a las necesidades académicas y a lo establecido en la normativa institucional'), 
    (NULL, '1', '24', 'Mejoramiento de la Calidad, la Pertinencia y la Equidad.'), 
    (NULL, '1', '25', 'a) Fortalecer la capacidad institucional para la elaboración, negociación y ejecución de iniciativas de cooperación con instancias internacionales para potenciar la labor docente, la investigación científica y las actividades de apoyo de la UNAH a la sociedad, la formación integral de los estudiantes y docentes, la infraestructura, la cooperación al desarrollo y el intercambio de conocimiento.'), 
    (NULL, '1', '25', 'b) Incremento del grado de visibilidad e involucramiento interinstitucional de la UNAH en el marco de las redes universitarias.'), 
    (NULL, '1', '25', 'c) Implementación del registro de acciones de internacionalización.');

INSERT INTO `AreaEstrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '26', 'Lograr que la UNAH lleve a cabo en forma sostenida y permanente, un ejercicio pleno y responsable del principio de autonomía, que le permita participar activamente en la transformación de la sociedad hondureña.'), 
    (NULL, '1', '27', 'Fortalecer la atribución que la Constitución de la República le otorga a la UNAH de organizar, dirigir y desarrollar la educación superior y profesional.'), 
    (NULL, '1', '29', 'a. Conducir en coordinación con la Rectoría de la UNAH, el cumplimiento de la atribución que la Constitución de la República le otorga a la UNAH de organizar, dirigir y desarrollar la educación superior y profesional de Honduras'), 
    (NULL, '1', '29', 'b. Conducir e impulsar el cumplimiento de los trece objetivos estratégicos del Sistema de Educación Superior formulados en el Plan Estratégico de Desarrollo 2014-2023, en forma proactiva y con gestión de apoyo financiero nacional e internacional.'), 
    (NULL, '1', '29', 'c. Consolidar el funcionamiento del Consejo Nacional de Educación, ejerciendo la Rectoría de la UNAH la Vice-Presidencia del mismo y la Dirección de Educación Superior, la Secretaría, así como la conducción de proyectos de integración de la Educación Nacional a través de la Comisión Bipartita. '), 
    (NULL, '1', '30', 'Promover  la  capacitación continua de los miembros de la comunidad universitaria para  el desarrollo de las competencias de las TIC.'),
    (NULL, '1', '30', 'Apoyar mediante el uso de los espacios y recursos web, las actividades propias de difusión y posicionamiento de la institución en todas las áreas del contexto nacional e internacional'), 
    (NULL, '1', '30', 'Promover la aplicación de nuevas tecnologías en las diferentes áreas del conocimiento con base en las necesidades institucionales y tendencias mundiales.'), 
    (NULL, '1', '30', 'Promover el uso adecuado, ético y solidario de las TIC para el desarrollo de la academia, la ciencia y la cultura.'), 
    (NULL, '1', '30', 'Contar con un Sistema de Unidades de Recursos de Información certificado'), 
    (NULL, '1', '30', 'Intercambiar información con otras instituciones de manera rápida y eficiente. ');

INSERT INTO `AreaEstrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '31', 'Promover las TICs en apoyo a la docencia no presencial para el fortalecimiento del Sistema de Educación a Distancia'), 
    (NULL, '1', '31', 'Fortalecer la docencia presencial a travès de las TICs.'), 
    (NULL, '1', '32', 'Apoyar el desarrollo permanente, sostenibilidad y seguridad de la UNAHnet.'), 
    (NULL, '1', '32', 'Disponer de los sistemas de información y aplicaciones informáticas para el desarrollo institucional observando las normas y políticas institucionales y las leyes nacionales.'), 
    (NULL, '1', '32', 'Optimizar la adquisición y mantenimiento de equipo informático observando las normas y políticas institucionales y las leyes nacionales. (Plan de Renovación, Plan de Adquisición y Plan de Mantenimiento - REFERENCIA)'), 
    (NULL, '1', '33', 'Gestionar la administración electrónica a través de la automatización de los servicios académicos y administrativos.'), 
    (NULL, '1', '33', 'Disponer de informacion institucional en soporte electrónico o de manera digital, con el fin de mejorar todas las gestiones tanto administrativas como academicas.  (Repositorios - REFERENCIA)'), 
    (NULL, '1', '33', 'Modernizar los procesos institucionales incrementando su eficiencia y ejecución (Inteligencia de Negocios - REFERENCIA)'), 
    (NULL, '1', '33', 'Contar con un marco regulatorio que garantice un crecimiento estandarizado y un uso eficiente de los recursos de TI en la institución.');


-- INSERTANDO RESULTADOS INSTITUCIONALES
INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '1', '1', 'Implementados currículos innovadores a nivel de grado y postgrado (macro, meso y micro currículos), en todas las Facultades y Centros Regionales Universitarios. '), 
    (NULL, '2', '1', 'Aplicada la política de bimodalidad con base en los diagnósticos regionales de necesidades y potencialidades auténticas.'), 
    (NULL, '3', '1', 'Las facultades y los centros regionales  desarrollan proyectos de investigación enmarcados en los temas prioritarios de la UNAH y de la facultad o centro regional a la cual están adscritas.'), 
    (NULL, '3', '1', 'Las facultades y los centros regionales  compiten por fondos concursables para investigación a nivel interno o externo.'), 
    (NULL, '3', '1', 'Las facultades y los centros regionales  postulan candidatos para concursar por reconocimientos que premien: '), 
    (NULL, '3', '1', 'Las facultades y los centros regionales promueven la asignación de investigación como carga académica en la UNAH, con el desarrollo de proyectos de investigación.'), 
    (NULL, '4', '1', 'Las facultades y los centros regionales participan en los encuentros académicos organizados por la Dirección de Investigación Científica (congresos,  encuentros, foros y otros eventos de investigación científica).'), 
    (NULL, '4', '1', 'Las facultades y los centros regionales crean y fortalecen sus revistas científicas siguiendo los estándares internacionales de calidad.'), 
    (NULL, '4', '1', 'Las facultades y los centros regionales participan en los encuentros académicos organizados por la Dirección de Investigación Científica (congresos,  encuentros, foros y otros eventos de investigación científica).'), 
    (NULL, '4', '1', 'Las facultades y los centros regionales participan en los encuentros académicos organizados por la Dirección de Investigación Científica (congresos,  encuentros, foros y otros eventos de investigación científica).'), 
    (NULL, '4', '1', 'Las facultades y los centros regionales organizan encuentros (foros, conversatorios, simposios talleres etc.), para divulgar los resultados de las investigaciones realizadas.'), 
    (NULL, '4', '1', 'Las facultades y los centros regionales impulsan la representación institucional con ponencias en eventos científicos internacionales con recursos internos y externos.');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '5', '1', 'Las facultades y los centros regionales identifican los proyectos de investigación, cuyos resultados sean susceptibles de protección, uso y explotación de la propiedad '), 
    (NULL, '6', '1', 'Las facultades y los centros regionales  participan en el programa de capacitación ofertado por la Dirección de Investigación Científica.'), 
    (NULL, '7', '1', 'Las faculttades y centros regionales cuenta con una estructura de investigación creada y fortalecida: institutos de investigación, unidades de gestión de la investigación, grupos de investigación, observatorios académicos, círculos de creatividad, spin off universitarias e incubadoras.'), 
    (NULL, '7', '1', 'Firmados convenios de cooperación con instituciones nacionales e internacionales.'), 
    (NULL, '7', '1', 'Fortalecidos los vínculos de la UNAH con el gobierno, sectores productivos, sectores sociales y otras universidades, en torno a la investigación científica, para contribuir de forma integral al conocimiento y solución de los principales problemas del país.'), 
    (NULL, '8', '1', 'Comités de vinculación creados y funcionando con calidad y pertinencia en las unidades académicas, ejecutando proyectos de vinculación relacionados con las áreas prioritarias.'), 
    (NULL, '8', '1', 'Unidades académicas aplicando las políticas de vinculación en sus procesos de vinculación con la sociedad según sus contextos.'), 
    (NULL, '8', '1', 'Propiciar las alianzas con otras entidades públicas y de la sociedad  del país, para el desarrollo de procesos de cooperación recíproca para el fortalecimiento de la Educación pública y gratuita y temáticas de formación de interés educativo de los actores de la sociedad'), 
    (NULL, '8', '1', 'Convenios suscritos entre la UNAH e instancias de la sociedad civil, el Estado, los gobiernos locales, el sector productivo.'), 
    (NULL, '9', '1', 'La Dirección de Vinculación organiza anualmente encuentros locales, regionales, nacionales e internacionales que contribuye al debate académico del quehacer de vinculación.'), 
    (NULL, '9', '1', 'Creado un Sistema de información de procesos de vinculación con indicadores de resultados.');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '10', '1', 'Los Comités de Vinculación (CV) en las Unidades Académicas de las Facultades y Centros Regionales, funcionan y cumplen con la planificación académica en vinculación y asignan recursos para su ejecución.'), 
    (NULL, '10', '1', 'La carrera gestiona recursos internos y externos en coordinación con la Dirección de Vinculación UNAH-Sociedad y la Vicerrectoría de Relaciones Internacionales.'), 
    (NULL, '11', '1', 'Ejecución del Sistema Integral de Atención Primaria en Salud Familiar-Comunitario en 30 municipios del país conjuntamente con la Secretaría de Salud, las municipalidades, la SEPLAN, la Secretaría de Educación y la AMOHN.'), 
    (NULL, '11', '1', 'La Dirección de Vinculación promueve el intercambio de experiencias y buenas prácticas en el quehacer de vinculación entre las unidades académicas y Centros Regionales.'), 
    (NULL, '11', '1', 'Formular y ejecutar en Ciudad Universitaria y en cada centro regional universitario, un PLAN UNIVERSITARIO ANUAL DE APOYO A LA GESTIÓN DE RIESGOS, bajo la coordinación de la Maestría en Gestión del Riesgo.'), 
    (NULL, '12', '1', 'Integrar programas y planes para la implementación de los servicios de educación no formal a nivel de diplomados, cursos libres, talleres, seminarios, conferencias, con las unidades académicas y en alianza con otros actores de la sociedad.'), 
    (NULL, '12', '1', 'Promover encuentros académicos de análisis y reflexión permanente sobre temas relevantes de la realidad nacional, y del sistema educativo nacional incluyendo la educación superior como bien público y gratuito'), 
    (NULL, '12', '1', 'Generar una oferta básica de procesos de Educación no Formal (ENF) por facultades y centros regionales a través de sus distintas carreras (disciplinarias o interdisciplinarias), con aliados estratégicos identificados por los comités de vinculación, orientados a fortalecer el sistema nacional de educación pública y gratuita  del país.'), 
    (NULL, '12', '1', 'Ejecutar un proyecto piloto de APOYO A LA EDUCACIÓN FORMAL. Y NO FORMAL en los municipios donde funciona el programa APS. En educación no formal se trabajará en construir capacidades locales diversas, orientadas al desarrollo local, la construcción de ciudadanía y cultura de paz, mediante ciclos de conferencias, cursos libres, seminarios, diplomados y otros procesos de educación no formal, disciplinares, e interdisciplinarios, dirigidos a  diferentes actores locales y municipales, en complemento y coordinación con los programas APS FC y DESARROLLO ECONOMICO LOCAL.'), 
    (NULL, '13', '1', 'La Dirección de Vinculación cuenta con estructura y mecanismos de divulgación de los procesos de vinculación para el apoyo a la difusión del quehacer de vinculación a nivel nacional.'), 
    (NULL, '13', '1', 'Las carreras realiza actividades para divulgar los proyectos de vinculación.'), 
    (NULL, '13', '1', 'La DVUS Edita y publica documentos académicos de las diferentes temáticas abordadas en los distintos procesos académicos de vinculación con la sociedad.'), 
    (NULL, '13', '1', 'Las unidades académicas sistematizan sus procesos de vinculación ejecutados, de acuerdo a los lineamientos propuestos por la DVUS.'), 
    (NULL, '14', '1', 'Se cuenta con actores cooperantes identificados y estructurados en mesas temáticas para la ejecución y respaldo de los proyectos de desarrollo local de los municipios.'), 
    (NULL, '14', '1', 'Se identifican las cadenas de valor de producción que inciden en el desarrollo economico local en los municipios seleccionados.'), 
    (NULL, '14', '1', 'Diseñado un programa orientado al fortalecimiento institucional y el emprendedurismo y desarrollo de capacidades locales en donde funciona el Sistema APS, con la participación plena de las unidades académicas de las áreas sociales y económicas.'), 
    (NULL, '14', '1', 'Se mejoran los niveles nutricionales locales y se estimula la generación de empleo e ingresos mediante la creación de microempresas familiares comunitarias en los municipios seleccionados.'), 
    (NULL, '14', '1', 'Ejecutar un proyecto piloto de APOYO A LA GESTIÓN CULTURAL orientado a potenciar los factores culturales como elementos de desarrollo local y regional, en complemento y coordinación con los programas de salud, producción y educación, en dos municipios en los que funcionen dichos programas.');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '15', '1', 'Creación de la bolsa de empleo de graduados.'), 
    (NULL, '16', '1', 'Creación de un programa de actualización de conocimientos para los graduados y no graduados en todas las áreas.'), 
    (NULL, '17', '1', 'Realización de estudios de graduados en las temáticas siguientes: Empleabilidad, pertinencia de la calidad educativa, percepción de los empleadores, satisfacción de los empleadores, satisfacción de la comunidad con el graduado de la UNAH, etnre otros.'), 
    (NULL, '18', '1', 'Brindar acompañamiento a las asociaciones acuerpando su trabajo y a la vez realizando simultáneamente parte del mismo.'), 
    (NULL, '19', '1', 'Creación y actualización permanente de la base de dato de nuestros graduados, a través de un acercamiento virtual, mediante el llenado de un formulario.'), 
    (NULL, '20', '1', 'Crear una cartera de servicios que la universidad proporcione a sus graduados.'), 
    (NULL, '21', '1', 'Fomentar espacios de discusión, análisis, debates e intercambios académicos entre graduados, estudiantes y profesores universitarios para el enriquecimiento de la ciencia, la tecnología y la innovación en los distintos campos del conocimiento.'), 
    (NULL, '22', '1', 'Personal Docente implementando prácticas innovadoras, alineadas con el modelo educativo.'), 
    (NULL, '23', '1', 'Estudiantes orientados profesionalmente a través del Centro de Orientación Vocacional Universitario (COVU).'), 
    (NULL, '23', '1', 'Estudiantes en riesgo académico reciben asesoría y tutoría como formas de atención.'), 
    (NULL, '23', '1', 'Implementar la Bolsa Universitaria de Trabajo en alianza con la Secretaría del Trabajo y Seguridad Social para identificar espacios laborales que favorezcan la empleabilidad de los egresados de la UNAH.'), 
    (NULL, '24', '1', 'Implementado de forma gradual y progresiva la estrategia de Atención Primaria en Salud estudiantil (APS) bajo el modelo de Universidades con Estilos de Vida Saludables que marquen la pauta para la construcción de la Política de Salud Universitaria.'), 
    (NULL, '24', '1', 'Instalados los servicios de salud en todos los Centros Regionales bajo el modelo de Universidades con Estilos de Vida Saludables que respondan a las necesidades de atención, promoción y formación de los estudiantes en los distintos contextos y zonas geográficas'), 
    (NULL, '24', '1', 'Expandidos los servicios de laboratorio para su auto-sostenibilidad en coordinación con la Escuela de Microbiología, ofreciendo servicios de calidad y a bajo costo a la población en general'), 
    (NULL, '25', '1', 'Realizado festivales y encuentros culturales con la participación de estudiantes de CU y CR.'), 
    (NULL, '25', '1', 'Desarrollado el Festival Interuniversitario de Cultura y Arte (FICCUA) para consolidar procesos de integración cultural en la región Centroamericana.'), 
    (NULL, '25', '1', 'Desarrollados programas socio-culturales para el fomento de una cultura y valores de paz, integración y cohesión estudiantil, familiar y social.'), 
    (NULL, '25', '1', 'Realizados los primeros Juegos Universitarios Deportivos de la UNAH (JUDUNAH) para promover el intercambio estudiantil universitario y la identificación de atletas  para la conformación de delegaciones que representan a la UNAH en instancias deportivas nacionales y regionales.');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '26', '1', 'Reformulada las políticas de estímulos educativos bajo criterios de equidad y calidad:'), 
    (NULL, '26', '1', 'Becas Municipales'), 
    (NULL, '26', '1', 'Becas de Inclusión Social (Pueblos Indígenas y Afrodescendientes)'), 
    (NULL, '26', '1', 'Becas por Desempeño Estudiantil (museos, bibliotecas, librería, centros de arte, deportes y cultura)'), 
    (NULL, '26', '1', 'Vigentes: excelencia, equidad, cultura y arte y deporte)'), 
    (NULL, '26', '1', 'En estudio: exoneración de matrícula a estudiantes de excelencia.'), 
    (NULL, '27', '1', 'Aplicación de Sistema de Seguimiento a graduados.  Base de Datos de Egresados, Actualizadas y Monitoreada.'), 
    (NULL, '28', '1', 'Graduados universitarios y Personal Administrativo participan en programa de relevo docente.'), 
    (NULL, '29', '1', 'Las unidades académicas participan en redes académicas a través de la movilidad y el uso de las TICS por campo del conocimiento para la generación y promoción de la gestión del conocimiento.'), 
    (NULL, '30', '1', 'Resultados permanentes y sostenidos de contribución al Desarrollo Humano Sostenible regional, generados por las 8 Redes Educativas Regionales de la UNAH.'), 
    (NULL, '31', '1', 'Gestión exitosa del Sistema de Difusión Científica y Cultural de la UNAH, con participación sostenida y permanente en redes asociativas nacionales e internacionales.'), 
    (NULL, '32', '1', 'Transversalizado el EJE CURRICULAR DE ÉTICA en los planes de estudio de la UNAH, que propicie un sello de “Lo Esencial” en los graduados de la UNAH. (R. de Desarrollo Curricular Integral).');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '33', '1', 'Fortalecida la IDENTIDAD NACIONAL E INSTITUCIONAL, con un saber local revalorizado e internacionalizado.'), 
    (NULL, '34', '1', 'Gestionados una serie de instrumentos culturales (en especial la POLÍTICA DE CULTURA, y oferta educativa, encaminada hacia la formación integral – profesional en la relación de cultura y desarrollo.'), 
    (NULL, '35', '1', 'Impregnados los currículos de una preocupación por los derechos humanos, lo socio-cultural, la interculturalidad y la gestión de vida cultural, desde actividades curriculares, extracurriculares, y la vinculación universidad – sociedad.'), 
    (NULL, '36', '1', 'Aplicación del modelo de innovación educativa que integre como ámbitos de innovación educativa: el currículo, las metodologías, las estrategias de enseñanza y aprendizaje, los materiales y recursos didácticos, el uso educativo de las TIC, la relación con el entorno, la profesionalización docente y directiva.'), 
    (NULL, '37', '1', 'Consolidado en todas las Unidades Académicas de la UNAH, el Sistema de Gestión de la Calidad, con procesos permanentes y sostenidos de autoevaluación y acreditación institucional,  de programas y carreras; de certificación y recertificación profesional de los profesores universitarios.'), 
    (NULL, '38', '1', 'Consolidado en todos los niveles de gestión académica, el Sub-sistema de Planificación, Monitoria y Evaluación de la Gestión Académica.'), 
    (NULL, '38', '1', 'Mejora continua de indicadores (de calidad y pertinencia) institucionales, nacionales e internacionales, sobre la producción, difusión, gestión e innovación científica y técnica.'), 
    (NULL, '39', '1', ' Comisiones mixtas de Seguridad e Higiene'), 
    (NULL, '39', '1', 'Sistema en Gestión Ambiental (ISO 14001)'), 
    (NULL, '39', '1', 'Adhesión al programa de Universidades Promotoras de la Salud (OPS)'), 
    (NULL, '39', '1', 'Sistema de Gestión de Seguridad e Higiene Ocupacional (OSHAS 18001)'), 
    (NULL, '39', '1', 'Oficina de Responsabilidad Social Universitaria en funcionamiento'), 
    (NULL, '40', '1', 'La UNAH  promueve posgrados en base a la demanda del país y las necesidades en ciencia y tecnología.'), 
    (NULL, '41', '1', 'Las facultades y centros regionales cuentan con posgrados integrados plenamente a los departamentos correspondientes.'), 
    (NULL, '42', '1', 'Las facultades y centros regionales realizan procesos de utoevaluación, evaluación, rediseño y acreditación de sus posgrados.'), 
    (NULL, '42', '1', 'Las facultades y los centros regionales promueven la creación o reconversión de algunos posgrados de la UNAH en posgrados regionales. ');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '43', '1', ' Las facultades y centros regionales definen y articulan los temas prioritarios de posgrado a los ya definidos por la UNAH.'), 
    (NULL, '43', '1', 'Las facultades y centros regionales impulsan la integración de los estudiantes de posgrado a los grupos de investigación de la UNAH.'), 
    (NULL, '43', '1', 'Las facultades y centros regionales impulsan la publicación de artículos de trabajos de graduación de los estudiantes de posgrado en las revistas de la UNAH.'), 
    (NULL, '43', '1', 'Las facultades y centros regionales participan en el congreso de gestión de posgrados en la UNAH organizado por la Dirección del Sistema de Estudios de Posgrado.'), 
    (NULL, '44', '1', ' Las facultades y los centros regionales fortalecen los vínculos de la UNAH con el Estado, sectores productivos, sectores sociales y cooperación internacional, a efecto de procurar financiamiento o apoyos a posgrados específicos de interés nacional y sectorial.'), 
    (NULL, '44', '1', 'Las facultades y los centros regionales se vinculan con otras universidades, instituciones  u organizaciones, para asegurar la participación de profesores e investigadores internacionales, a través de conferencias, asesorías, investigaciones y otros.'), 
    (NULL, '44', '1', 'Las facultades y los centros regionales definen espacios, áreas geográficas e institucionales y temáticas en las que pueden insertarse los estudiantes de posgrados profesionalizantes o académicos para realizar sus trabajos de graduación.'), 
    (NULL, '43', '1', 'Las facultades y los centros regionales a través de sus posgrados dan seguimiento, sistematizan y divulgan la inserción laboral de los egresados de posgrado.'), 
    (NULL, '44', '1', 'Las facultades y los centros regionales crean y fortalecen los vínculos de los posgrados de la UNAH con otras universidades e instituciones afines al área de estudio, para contribuir de forma integral al conocimiento y solución de los principales problemas del país.'), 
    (NULL, '45', '1', 'Las facultades y los centros regionales diseñan y desarrollan una oferta educativa de posgrados en los centros universitarios regionales en base a las necesidades de la región y del centro universitario.'), 
    (NULL, '45', '1', ' Las facultades y los centros regionales establecen vínculos de cooperación con universidades publicas de la región centroamericana (SICAR/CSUCA) para movilidad de docentes, investigadores y estudiantes en la participación de cursos, proyectos, pasantías y otros. '), 
    (NULL, '45', '1', 'Las facultades y los centros regionales comparten capital humano y recursos institucionales a posgrados regionales para el desarrollo de los mismo.'), 
    (NULL, '45', '1', 'Las facultades y los centros regionales desarrollan estrategias de internacionalización de cada posgrado para proyectar la UNAH a nivel internacional.'), 
    (NULL, '45', '1', 'Las facultades y los centros regionales establecen vínculos de colaboración, comunicación e  información con posgrados de otros países a través de las tecnologías de información y comunicación. '), 
    (NULL, '46', '1', 'Las facultades y centros regionales promueven que los posgrados participen en el programa de capacitación ofertado por la Dirección del Sistema de Estudios de Posgrado.'), 
    (NULL, '46', '1', 'Las facultades y centros regionales impulsan los cursos de actualización a los egresados de posgrado de la UNAH,  de acuerdo a su temática.');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '47', '1', 'Plataforma tecnológica eficiente, accesible en todos los predios de las sedes, modalidades y unidades académicas de la UNAH.'), 
    (NULL, '48', '1', '\"Macro proyecto de Desarrollo Físico implementado, incluyendo Centros Regionales, CRAED, ITS.\r\n2) Infraestructura física de CRAED pilotos en proceso de construcción.\"'), 
    (NULL, '49', '1', '\"Aulas equipadas con proyectores y equipos de ayuda multimedia, 2) Fortalecida la red de bibliotecas universitarias, librerías universitarias y la editorial, tanto virtuales como físicas.\"'), 
    (NULL, '50', '1', 'Docentes regularizados y contratados de acuerdo a la meta propuesta.'), 
    (NULL, '51', '1', 'Normativa aprobada y en ejecución.'), 
    (NULL, '52', '1', 'Consolidado un sistema de desarrollo del talento humano con relevo de docentes y personal administrativo de excelencia y liderazgo.'), 
    (NULL, '53', '1', 'Todas las unidades  académicas de la UNAH deberán estar articuladas e integradas a un sistema de gestión que integra la planificación, monitoria, evaluación y control; basado en  una estructura organizativa ágil y flexible y cumpliendo con las normas y estándares definidos.'), 
    (NULL, '53', '1', 'Impulsar la conectividad, acceso a información digital, uso de herramientas informáticas, laboratorios, plataformas de interacción y de educación virtual y facilitar la generación e introducción de innovaciones tecnológicas para el mejoramiento de los aprendizajes, incorporando la ciencia y la tecnología a los procesos de enseñanza y a la creación de conocimiento.'), 
    (NULL, '54', '1', 'Incremento de las movilidades internacionales realizadas'), 
    (NULL, '54', '1', 'Proyectos y/o programas de cooperación e investigación gestionados por la unidad');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '55', '1', 'Relaciones internacionales con otras instituciones fortalecidas'), 
    (NULL, '56', '1', 'Actividades en internacionalización registradas y monitoreadas'), 
    (NULL, '57', '1', 'Instancias que conforman las autoridades de dirección superior, desarrollando su respectivo rol en forma coordinada.'), 
    (NULL, '57', '1', 'Manejo oportuno y eficiente de los conflictos internos que se originen producto de discrepancias o problemas entre los distintos sectores de la UNAH.'), 
    (NULL, '58', '1', 'Sistema de educación superior regularizado en términos de calidad y pertinencia.'), 
    (NULL, '58', '1', 'Plan de Desarrollo de la Educación Superior implementado y consolidado.'), 
    (NULL, '59', '1', 'La Dirección de Educación Superior es reconocida en su rol de conductor de la política educativa de nivel superior, bien organizada y con los recursos humanos y materiales que requiere para su eficaz y eficiente funcionamiento.'), 
    (NULL, '59', '1', 'La Dirección de Educación Superior es fedataria pública de los actos del nivel superior, da seguimiento eficaz y asegura el  cumplimiento de las resoluciones de los órganos de gobierno de El nivel Superior y responde en tiempo y forma las solicitudes presentadas por los centros de educación superior y por peticionarios de validación de estudios.'), 
    (NULL, '59', '1', 'Servicios ofrecidos con plena satisfacción de los usuarios'), 
    (NULL, '59', '1', 'Plan Estratégico DES  y planes operativos anuales de la DES, y de los Departamentos cumplidos,  Informes de proyectos impulsados por la Dirección de Educación Superior, observatorio de la Educación Superior funcionando, Sistemas informativos y bases de dato funcionando, sitios web actualizados y activos, edición y distribución de publicaciones varias.');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '60', '1', 'Sistema de Educación Superior vinculado con los sistemas educativos regionales y mundiales, convenios de cooperación suscritos y en ejecución, adaptación de las grandes tendencias internacionales a las políticas educativas del país. Vinculación amplia con expertos, asesoría, pasantías.'), 
    (NULL, '60', '1', 'Sistema de Educación Superior integrado a redes socioeducativas nacionales e internacionales.'), 
    (NULL, '60', '1', 'Documento de Plan Plan Estratégico de Desarrollo del Sistema validado y aprobado. Objetivos propuestos cumplidos.  Sistema de Educación Superior en camino a su desarrollo.'), 
    (NULL, '60', '1', 'Proyectos de país desarrollados por los Centros de Educación Superior.  Financiamiento disponible.  '), 
    (NULL, '60', '1', 'El sistema de educación superior integrado a redes académicas. Alianzas estratégicas formalizadas a través de convenios.'), 
    (NULL, '60', '1', 'Plataformas tecnológicas desarrolladas y en funcionamiento.'), 
    (NULL, '61', '1', 'Proyectos conducentes a la integración curricular desde los niveles pre-básica hasta el nivel superior.'), 
    (NULL, '60', '1', 'Incidir para el desarrollo del modelo de la Educación Técnica en los Niveles de Educación Media y Superior y su instauración en el Sistema Educativo Nacional.'), 
    (NULL, '60', '1', 'Promover procesos de formación docente para los niveles pre-básico, básico, medio y superior de la educación nacional.Promover procesos de formación docente para los niveles pre-básico, básico, medio y superior de la educación nacional.'), 
    (NULL, '61', '1', 'Proyectos conducentes a la integración curricular desde los niveles pre-básica hasta el nivel superior.'), 
    (NULL, '61', '1', 'Incidir para el desarrollo del modelo de la Educación Técnica en los Niveles de Educación Media y Superior y su instauración en el Sistema Educativo Nacional.'), 
    (NULL, '61', '1', 'Promover procesos de formación docente para los niveles pre-básico, básico, medio y superior de la educación nacional.Promover procesos de formación docente para los niveles pre-básico, básico, medio y superior de la educación nacional.'), 
    (NULL, '62', '1', 'Comunidad Universitaria con mayor conocimiento en el uso de las TIC en las Facultades y Centros Regionales'), 
    (NULL, '63', '1', 'Portal Web activo y actualizado difundiendo información en el ámbito Universitario.');

INSERT INTO `ResultadoInstitucional` (`idResultadoInstitucional`, `idAreaEstrategica`, `idEstadoResultadoInstitucional`, `resultadoInstitucional`) 
VALUES (NULL, '64', '1', 'Comunidad Universitaria haciendo uso de nuevos recursos de aprendizaje de acuerdo a la tendencia del nuevo modelo educativo.'), 
    (NULL, '65', '1', 'Unidades académicas, administrativas y de servicio aplicando las buenas prácticas para el uso adecuado, ético y solidario de las TICs'), 
    (NULL, '66', '1', 'Servicios y procesos de la biblioteca estandarizados'), 
    (NULL, '67', '1', 'Fortalecida la interoperabilidad y comunicación con diferentes instituciones  a nivel nacional e internacional con las que la UNAH mantiene relaciones.'), 
    (NULL, '68', '1', 'Sistema de Educación a Distancia fortalecido a través de la oferta virtual ampliada en las diferentes carreras de la UNAH.'), 
    (NULL, '69', '1', 'Dinamizado y enriquecido los procesos de enseñanza-aprendizaje en las Unidades académicas haciendo uso de las TICs.'), 
    (NULL, '70', '1', 'Red de datos segura y confiable operando a nivel nacional y con servicio QoS'), 
    (NULL, '71', '1', 'Sistemas de información y aplicaciones informáticas funcionando'), 
    (NULL, '72', '1', 'Unidades académicas, administrativas y de servicio con equipo informático pertinente para las funciones académicas y administrativas respectivamente en buen funcionamiento y actualizado'), 
    (NULL, '73', '1', 'Facilitado el acceso a servicios académicos y administrativos disponibles electrónicamente para los usuarios.'), 
    (NULL, '74', '1', 'Información disponible en línea'), 
    (NULL, '75', '1', 'Información oportuna y pertinente generada para la toma de decisiones a nivel gerencial.'), 
    (NULL, '76', '1', 'Recursos TI normados y regulados');






    






