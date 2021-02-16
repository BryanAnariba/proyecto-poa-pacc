-- Inserts para llenado de la Base de datos Proyecto POA-PACC
-- Llena dimemsiones administrativas y estrategicas, asi coo los objetivos 
--institucionales y sus respectivas areas estrategicas

-- INSERTANDO DIMENSIONES ADMINISTRATIVAS
INSERT INTO `dimensionadmin` (`idDimension`, `dimensionAdministrativa`, `idEstadoDimension`) 
VALUES (NULL, 'TALLERES SEMINARIOS', '1'), 
    (NULL, 'CONTRATACION DE PERSONAL', '1'), 
    (NULL, 'EQUIPO DE OFICINA', '1'), 
    (NULL, 'EQUIPO TECNOLÓGICOS', '1'), 
    (NULL, 'ACTIVIDADES ESPECIALES', '1'), 
    (NULL, 'BECAS', '1'), 
    (NULL, 'INFRAESTRUCTURA', '1'), 
    (NULL, 'VENTA DE SERVICIOS', '1');


-- INSERTANDO DIMENSIONES ESTRATEGICAS
INSERT INTO `dimensionestrategica` (`idDimension`, `idEstadoDimension`, `dimensionEstrategica`) 
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
INSERT INTO `objetivoinstitucional` (`idObjetivoInstitucional`, `idDimensionEstrategica`, `idEstadoObjetivoInstitucional`, `objetivoInstitucional`) 
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
INSERT INTO `areaestrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
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

INSERT INTO `areaestrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
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

INSERT INTO `areaestrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
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

INSERT INTO `areaestrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
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

INSERT INTO `areaestrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
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

INSERT INTO `areaestrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '26', 'Lograr que la UNAH lleve a cabo en forma sostenida y permanente, un ejercicio pleno y responsable del principio de autonomía, que le permita participar activamente en la transformación de la sociedad hondureña.'), 
    (NULL, '1', '27', 'Fortalecer la atribución que la Constitución de la República le otorga a la UNAH de organizar, dirigir y desarrollar la educación superior y profesional.'), 
    (NULL, '1', '29', 'a. Conducir en coordinación con la Rectoría de la UNAH, el cumplimiento de la atribución que la Constitución de la República le otorga a la UNAH de organizar, dirigir y desarrollar la educación superior y profesional de Honduras'), 
    (NULL, '1', '29', 'b. Conducir e impulsar el cumplimiento de los trece objetivos estratégicos del Sistema de Educación Superior formulados en el Plan Estratégico de Desarrollo 2014-2023, en forma proactiva y con gestión de apoyo financiero nacional e internacional.'), 
    (NULL, '1', '29', 'c. Consolidar el funcionamiento del Consejo Nacional de Educación, ejerciendo la Rectoría de la UNAH la Vice-Presidencia del mismo y la Dirección de Educación Superior, la Secretaría, así como la conducción de proyectos de integración de la Educación Nacional a través de la Comisión Bipartita. '), 
    (NULL, '1', '30', 'Promover  la  capacitación continua de los miembros de la comunidad universitaria para  el desarrollo de las competencias de las TIC.'),
    (NULL, '1', '30', 'Apoyar mediante el uso de los espacios y recursos web, las actividades propias de difusión y posicionamiento de la institución en todas las áreas del contexto nacional e internacional'), 
    (NULL, '1', '30', 'Promover el uso adecuado, ético y solidario de las TIC para el desarrollo de la academia, la ciencia y la cultura.'), 
    (NULL, '1', '30', 'Contar con un Sistema de Unidades de Recursos de Información certificado'), 
    (NULL, '1', '30', 'Intercambiar información con otras instituciones de manera rápida y eficiente. ');

INSERT INTO `areaestrategica` (`idAreaEstrategica`, `idEstadoAreaEstrategica`, `idObjetivoInstitucional`, `areaEstrategica`) 
VALUES (NULL, '1', '31', 'Promover las TICs en apoyo a la docencia no presencial para el fortalecimiento del Sistema de Educación a Distancia'), 
    (NULL, '1', '31', 'Fortalecer la docencia presencial a travès de las TICs.'), 
    (NULL, '1', '32', 'Apoyar el desarrollo permanente, sostenibilidad y seguridad de la UNAHnet.'), 
    (NULL, '1', '32', 'Disponer de los sistemas de información y aplicaciones informáticas para el desarrollo institucional observando las normas y políticas institucionales y las leyes nacionales.'), 
    (NULL, '1', '32', 'Optimizar la adquisición y mantenimiento de equipo informático observando las normas y políticas institucionales y las leyes nacionales. (Plan de Renovación, Plan de Adquisición y Plan de Mantenimiento - REFERENCIA)'), 
    (NULL, '1', '33', 'Gestionar la administración electrónica a través de la automatización de los servicios académicos y administrativos.'), 
    (NULL, '1', '33', 'Disponer de informacion institucional en soporte electrónico o de manera digital, con el fin de mejorar todas las gestiones tanto administrativas como academicas.  (Repositorios - REFERENCIA)'), 
    (NULL, '1', '33', 'Modernizar los procesos institucionales incrementando su eficiencia y ejecución (Inteligencia de Negocios - REFERENCIA)'), 
    (NULL, '1', '33', 'Contar con un marco regulatorio que garantice un crecimiento estandarizado y un uso eficiente de los recursos de TI en la institución.');



