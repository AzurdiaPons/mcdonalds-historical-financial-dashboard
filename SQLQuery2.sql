USE macdonalds;
SELECT * FROM macdonalds;

USE macdonalds;
GO
-- ====================================================================
-- OBJETIVO: Crecimiento Interanual (YoY) de Ingresos y Ganancias
-- DESCRIPCIÓN: Evaluar la estabilidad y el crecimiento histórico de la empresa 
-- utilizando funciones de ventana (LAG) para comparar cada año con su periodo anterior,
-- protegiendo contra divisiones por cero (NULLIF) y estandarizando los decimales (ROUND).
-- ====================================================================


SELECT 
	Anio,
	Ingresos_B as Ingresos_enBillones,
	LAG(Ingresos_B, 1) over (order by Anio) as Ingresos_ano_Anterior,
ROUND(
	((Ingresos_B - LAG(Ingresos_B, 1) over (order by Anio)) /
NULLIF(LAG(Ingresos_B, 1) over (order by Anio), 0)) * 100, 2
	) as Crecimiento_Ingresos_YoY_Pct,
	Ganancias_B as Ganancias_EnBillones,
	ROUND(
	((Ganancias_B - LAG(Ganancias_B, 1) over (order by Anio)) /
NULLIF(LAG(Ganancias_B, 1) over (order by Anio), 0)) * 100, 2
  ) AS Crecimiento_Ganancias_YoY_Pct  
FROM macdonalds 
ORDER BY Anio DESC;


-- ====================================================================
-- OBJETIVO: Análisis de Rentabilidad y Apalancamiento (Margen Operativo y Deuda Total)
-- DESCRIPCIÓN: Evaluación del crecimiento interanual (YoY) del margen operativo 
-- y de la deuda total mediante funciones de ventana (LAG), protección contra 
-- divisiones por cero (NULLIF) y estandarización a dos decimales (ROUND).
-- ====================================================================


SELECT 
	Anio AS AÑO,
	Margen_Operativo,
	Deuda_Total_B,
	LAG(Margen_Operativo, 1) OVER (Order by Anio) AS Margen_Operativo_Anterior,
	ROUND(
		((Margen_Operativo - LAG(Margen_Operativo, 1) OVER (ORDER BY Anio)) /
	NULLIF(LAG(Margen_Operativo, 1) OVER (ORDER BY Anio), 0)) * 100, 2
	) AS Crecimiento_Margen_YoY_Pct,
	LAG(Deuda_Total_B, 1) OVER (Order by Anio) AS deuda_Anterior,
	ROUND(
		((Deuda_Total_B - LAG(Deuda_Total_B, 1) OVER (ORDER BY Anio)) /
	NULLIF(LAG(Deuda_Total_B, 1) OVER (ORDER BY Anio), 0)) * 100, 2
	) AS Crecimiento_Deuda_yoy_Pct
	FROM macdonalds
	ORDER BY Anio DESC;

	-- ====================================================================
-- OBJETIVO: Consolidación Financiera y KPI de Rendimiento usando CTE
-- DESCRIPCIÓN: Agrupa todas las métricas anteriores (Ingresos, Ganancias, 
-- Margen y Deuda con sus YoY) en una estructura limpia y calcula un 
-- indicador de desempeño (KPI) comercial basado en el comportamiento anual.
-- ====================================================================.

WITH FinanzasBase AS (
    SELECT 
        Anio,
        Ingresos_B,
        ROUND(
            ((Ingresos_B - LAG(Ingresos_B, 1) OVER (ORDER BY Anio)) / 
            NULLIF(LAG(Ingresos_B, 1) OVER (ORDER BY Anio), 0)) * 100, 
            2
        ) AS Crecimiento_Ingresos_YoY_Pct,
        
        Ganancias_B,
        ROUND(
            ((Ganancias_B - LAG(Ganancias_B, 1) OVER (ORDER BY Anio)) / 
            NULLIF(LAG(Ganancias_B, 1) OVER (ORDER BY Anio), 0)) * 100, 
            2
        ) AS Crecimiento_Ganancias_YoY_Pct,
        
        Margen_Operativo,
        ROUND(
            ((Margen_Operativo - LAG(Margen_Operativo, 1) OVER (ORDER BY Anio)) / 
            NULLIF(LAG(Margen_Operativo, 1) OVER (ORDER BY Anio), 0)) * 100, 
            2
        ) AS Crecimiento_Margen_YoY_Pct,
        
        Deuda_Total_B,
        ROUND(
            ((Deuda_Total_B - LAG(Deuda_Total_B, 1) OVER (ORDER BY Anio)) / 
            NULLIF(LAG(Deuda_Total_B, 1) OVER (ORDER BY Anio), 0)) * 100, 
            2
        ) AS Crecimiento_Deuda_YoY_Pct
    FROM macdonalds
    )

SELECT  
    Anio as Año,
    Ingresos_B AS ingresos_Billones,
    Crecimiento_Ingresos_YoY_pct,
    Crecimiento_Ganancias_YoY_pct,
    Crecimiento_Margen_YoY_pct,
    Crecimiento_Deuda_YoY_pct,
CASE 
    WHEN Crecimiento_Ingresos_YoY_pct > 0 and Crecimiento_Ganancias_YoY_Pct > 0 then 'Saludable / Expansión'
    WHEN Crecimiento_Ingresos_YoY_Pct < 0 AND Crecimiento_Ganancias_YoY_Pct < 0 THEN 'Alerta / Contracción'
        ELSE 'Transición / Mixto'
    end as KPI_Estado_Financiero
    from FinanzasBase
    ORDER BY Anio Desc;

SELECT  * FROM macdonalds;

-- ====================================================================
-- OBJETIVO: Promedio Móvil de Ingresos a 3 Años
-- DESCRIPCIÓN: Calcula el promedio móvil de los ingresos utilizando una 
-- ventana de 3 filas (el año actual y los dos anteriores), ordenado 
-- cronológicamente y redondeado a 2 decimales.
-- ====================================================================

SELECT 
    Anio,
    Ingresos_B,
    ROUND(
        AVG(Ingresos_B) over (Order by Anio ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
        2
        ) as Promedio_Movil_Ingresos_3Y
        fROM macdonalds
        ORDER BY Anio;


select * from macdonalds;

-- ====================================================================
-- OBJETIVO: Análisis de Apalancamiento y Clasificación de Riesgo (KPI)
-- DESCRIPCIÓN: Calcula el ratio de deuda frente a los ingresos usando 
-- división protegida (NULLIF) y evalúa el nivel de riesgo mediante CASE/WHEN.
-- ====================================================================

with CTE_Apalancamiento as (SELECT 
        Anio,
        Deuda_Total_B, 
        Ingresos_B,
        ROUND(Deuda_Total_B / NULLIF(Ingresos_B, 0), 2) AS Ratio_Deuda_Ingresos
  FROM macdonalds
  )
  SELECT 
    Anio AS Año,
    Ingresos_B AS Ingresos_Billones,
    Deuda_Total_B AS Deuda_Billones,
    Ratio_Deuda_Ingresos,
        CASE 
            WHEN Ratio_Deuda_Ingresos <= 1.0 THEN 'Apalancamiento Saludable / Seguro'
            WHEN Ratio_Deuda_Ingresos > 1.0 THEN 'Alto Apalancamiento / Riesgo'
            ELSE 'SIN DATOS SUFICIENTES'
            END AS Estado_Apalancamiento
        from CTE_Apalancamiento
        order by Anio;

-- ====================================================================
-- OBJETIVO: Calcular el acumulado histórico de ingresos (Running Total)
-- DESCRIPCIÓN: Suma de forma progresiva los ingresos desde el primer 
-- registro disponible hasta el año actual evaluado.
-- ====================================================================
    SELECT 
        Anio,
        Ingresos_B,
    SUM(Ingresos_B) OVER (ORDER BY Anio ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Ingresos_Historicos
    from Macdonalds
    ORDER BY Anio;

    -- ====================================================================
-- OBJETIVO: Asignar un ranking histórico por nivel de ingresos
-- DESCRIPCIÓN: Utiliza la función RANK() para ordenar de mayor a menor 
-- los ingresos y etiquetar los años dorados de la compañía.
-- ====================================================================

    SELECT
        Anio,
        Ingresos_B,
        RANK() OVER (ORDER BY Ingresos_B desc) as ranking_Ingresos,
        RANK() OVER (ORDER BY Deuda_Total_B desc) as ranking_Deuda,
        RANK() OVER (ORDER BY Ganancias_B desc) as ranking_Ganancias

        from macdonalds
    ORDER BY Anio;


    -- ====================================================================
-- OBJETIVO: Crear la Vista Maestra de Análisis Financiero
-- DESCRIPCIÓN: Agrupa en una sola tabla virtual todas las métricas de YoY,
-- promedios móviles, acumulados, apalancamiento, KPIs y rankings.
-- ====================================================================

CREATE VIEW vw_AnalisisFinancieroMacdonalds AS

WITH FinanzasCalculadas AS (
    SELECT 
        Anio,
        Ingresos_B,
        Ganancias_B,
        Margen_Operativo,
        Deuda_Total_B,
        
        -- Crecimientos Interanuales (YoY)
        ROUND(((Ingresos_B - LAG(Ingresos_B, 1) OVER (ORDER BY Anio)) / NULLIF(LAG(Ingresos_B, 1) OVER (ORDER BY Anio), 0)) * 100, 2) AS Crecimiento_Ingresos_YoY_Pct,
        ROUND(((Ganancias_B - LAG(Ganancias_B, 1) OVER (ORDER BY Anio)) / NULLIF(LAG(Ganancias_B, 1) OVER (ORDER BY Anio), 0)) * 100, 2) AS Crecimiento_Ganancias_YoY_Pct,
        ROUND(((Margen_Operativo - LAG(Margen_Operativo, 1) OVER (ORDER BY Anio)) / NULLIF(LAG(Margen_Operativo, 1) OVER (ORDER BY Anio), 0)) * 100, 2) AS Crecimiento_Margen_YoY_Pct,
        ROUND(((Deuda_Total_B - LAG(Deuda_Total_B, 1) OVER (ORDER BY Anio)) / NULLIF(LAG(Deuda_Total_B, 1) OVER (ORDER BY Anio), 0)) * 100, 2) AS Crecimiento_Deuda_YoY_Pct,
        
        -- Tendencias y Acumulados
        ROUND(AVG(Ingresos_B) OVER (ORDER BY Anio ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS Promedio_Movil_Ingresos_3Y,
        SUM(Ingresos_B) OVER (ORDER BY Anio ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Ingresos_Historicos_Acumulados,
        
        -- Ratio Financiero
        ROUND(Deuda_Total_B / NULLIF(Ingresos_B, 0), 2) AS Ratio_Deuda_Ingresos,
        
        -- Rankings de Rendimiento
        RANK() OVER (ORDER BY Ingresos_B DESC) AS ranking_Ingresos,
        RANK() OVER (ORDER BY Deuda_Total_B DESC) AS ranking_Deuda,
        RANK() OVER (ORDER BY Ganancias_B DESC) AS ranking_Ganancias
    FROM macdonalds
)
SELECT 
    Anio AS Año,
    Ingresos_B AS Ingresos_Billones,
    Ganancias_B AS Ganancias_Billones,
    Margen_Operativo,
    Deuda_Total_B AS Deuda_Billones,
    Crecimiento_Ingresos_YoY_Pct,
    Crecimiento_Ganancias_YoY_Pct,
    Crecimiento_Margen_YoY_Pct,
    Crecimiento_Deuda_YoY_Pct,
    Promedio_Movil_Ingresos_3Y,
    Ingresos_Historicos_Acumulados,
    Ratio_Deuda_Ingresos,
    
    -- Semáforos y KPIs de Negocio
    CASE 
        WHEN Crecimiento_Ingresos_YoY_Pct > 0 AND Crecimiento_Ganancias_YoY_Pct > 0 THEN 'Saludable / Expansión'
        WHEN Crecimiento_Ingresos_YoY_Pct < 0 AND Crecimiento_Ganancias_YoY_Pct < 0 THEN 'Alerta / Contracción'
        ELSE 'Transición / Mixto'
    END AS KPI_Estado_Financiero,
    
    CASE 
        WHEN Ratio_Deuda_Ingresos <= 1.0 THEN 'Apalancamiento Saludable / Seguro'
        WHEN Ratio_Deuda_Ingresos > 1.0 THEN 'Alto Apalancamiento / Riesgo'
        ELSE 'SIN DATOS SUFICIENTES'
    END AS Estado_Apalancamiento,
    
    ranking_Ingresos,
    ranking_Deuda,
    ranking_Ganancias
FROM FinanzasCalculadas;

SELECT * FROM vw_AnalisisFinancieroMacdonalds ORDER BY Año DESC;