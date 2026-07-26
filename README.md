# 📊 Análisis Financiero Histórico & Business Intelligence: McDonald's Corp.

Proyecto integral de Business Intelligence desarrollado para analizar el desempeño financiero histórico, la eficiencia operativa, el comportamiento de los ingresos y el riesgo de apalancamiento de **McDonald's Corporation** (periodo 2015–2022).

---

## 🎯 Problema que Resolvemos (Business Problem)
Las grandes corporaciones globales manejan voluminosos estados financieros históricos donde identificar patrones macroeconómicos, riesgos de apalancamiento y puntos de inflexión entre crecimiento o contracción suele ser un proceso complejo y fragmentado. 

**El desafío:** Transformar datos contables e históricos dispersos en un modelo analítico centralizado y visualmente intuitivo que permita a los tomadores de decisiones:
* Diagnosticar con precisión en qué estado financiero (Contracción, Expansión o Transición) se encuentra cada periodo anual.
* Evaluar la relación directa entre el crecimiento de los ingresos, el margen operativo y el nivel de endeudamiento/apalancamiento sin perderse entre múltiples tablas de datos.
* Automatizar el cálculo de métricas financieras complejas (mediante T-SQL y DAX) para reducir el tiempo de análisis y minimizar errores humanos en auditorías o proyecciones.

---

## 🚀 Vista General del Dashboard & Pantallazos por Estados

El tablero utiliza un diseño ejecutivo de UX/UI minimalista, optimizado para la lectura directiva y la exploración dinámica mediante segmentaciones interactivas. A continuación se muestran los diferentes comportamientos del modelo según el filtro aplicado:

### 1. Vista General del Tablero (Consolidado 2015–2022)
*Visualización global del modelo financiero y los KPIs principales.*

<img width="1201" height="692" alt="dash1" src="https://github.com/user-attachments/assets/32375ac3-b709-4e4e-a192-062062065559" />



### 2. ⚠️ Estado de Alerta / Contracción (2015, 2018, 2020, 2022)
*Foco en periodos de presión sobre márgenes y niveles elevados de apalancamiento/riesgo.*

<img width="1208" height="690" alt="dash2" src="https://github.com/user-attachments/assets/6954d661-13be-41f4-ac8d-57332ccea244" />


### 3. 🟢 Estado Saludable / Expansión (2019, 2021)
*Destaca el dinamismo positivo, especialmente el repunte de ganancias y eficiencia en el año 2021.*

<img width="1212" height="703" alt="dash3" src="https://github.com/user-attachments/assets/0fcb8d80-38e2-4585-ae79-b515bbaa1268" />


### 4. 🔄 Estado Transición / Mixto (2016, 2017)
*Años bisagra de estabilización donde los ingresos moderan su tendencia previa y las ganancias se mantienen resilientes.*

<img width="1205" height="733" alt="dash4" src="https://github.com/user-attachments/assets/e01539f1-6dbc-4767-aa70-f64948ed2151" />


## 📈 Hallazgos y Análisis Financiero por Estados Clave

El modelo interactivo permite clasificar el desempeño anual de la compañía en tres estados financieros principales, revelando dinámicas críticas de negocio:

### 1. ⚠️ Estado de Alerta / Contracción
* **Años identificados:** 2015, 2018, 2020 y 2022.
* **Análisis:** En estos periodos, la compañía experimentó presiones significativas en sus ingresos y márgenes, destacando el impacto de contracciones macroeconómicas o reestructuraciones internas (con caídas notables en el año 2020). 
* **Apalancamiento:** Se observa de manera consistente la etiqueta de **"Alto Apalancamiento / Riesgo"**, lo que indica que la estrategia de optimización de capital se apoyó fuertemente en deuda para sostener las operaciones o retornos durante los baches del ciclo económico.

### 2. 🟢 Estado Saludable / Expansión
* **Años identificados:** 2019 y 2021.
* **Análisis:** Representan los momentos de mayor dinamismo positivo. El 2021 destaca de forma sobresaliente con un crecimiento de ganancias explosivo y un incremento notable en el margen operativo y recuperación de ingresos.
* **Eficiencia:** A pesar de registrar niveles de apalancamiento elevados, la capacidad de generación de caja y optimización de ganancias permitió compensar el riesgo, posicionando a estos años con los mejores rankings de deuda y eficiencia.

### 3. 🔄 Estado Transición / Mixto
* **Años identificados:** 2016 y 2017.
* **Análisis:** Funcionan como años bisagra o de estabilización. Los ingresos muestran una desaceleración moderada en su tendencia lineal descendente previa, mientras que las ganancias logran mantenerse resilientes antes de entrar en fases de mayor volatilidad.

---

## 🛠️ Stack Tecnológico
* **SQL Server & T-SQL:** Ingesta, limpieza y estructuración de datos financieros mediante vistas optimizadas.
* **Power BI Desktop:** Modelado dimensional, medidas DAX avanzadas, tarjetas dinámicas con contextos de filtro y diseño de interfaz visual ejecutiva.
* **Git & GitHub:** Control de versiones y despliegue de documentación del portafolio.

---

## 📂 Estructura del Repositorio
* `/powerbi`: Archivo `.pbix` con el desarrollo completo del reporte interactivo.
* `/sql`: Scripts de consultas y vistas utilizadas para alimentar el modelo.
* `/assets`: Capturas de pantalla e imágenes de los diferentes estados del dashboard (`dash1_2.jpg`, `dash2_2.jpg`, `dash3_2.jpg`, `dash4_2.jpg`).
* `/docs`: Documentación técnica de soporte.

---
*Desarrollado con enfoque analítico para la toma de decisiones estratégicas.*
