USE BNP_Inventario;

-----------------------------------------------------
--- >>> CARGA PARA Ações DTVM - COSIF - VJORA <<< ---
-----------------------------------------------------

WITH EventoContabil AS (
    SELECT
        ValAtributo01,
        ValAtributo02,
        LEFT(DesHistDescritivoEvento, CHARINDEX('|', DesHistDescritivoEvento) - 1) AS descricao,
        x.SeqEventoContabil,
        DesHistDescritivoEvento,
        CodEventoContabilSistemaLegado
    FROM
        IVT_EventoContabil x
    WHERE
        x.SeqEventoContabil IN (
            SELECT DISTINCT rc.SeqEventoContabil
            FROM IVT_RoteiroClassificado rc
            WHERE 
                rc.SeqEsquemaContabil = (
                    SELECT SeqEsquemaContabil 
                    FROM IVT_EsquemaContabil 
                    WHERE NomEsquemaContabil = 'COSIF'
                )
                AND rc.SeqRoteiroContabil = (
                    SELECT SeqRoteiroContabil 
                    FROM IVT_Roteiro 
                    WHERE NomRoteiroSistemaLegado = 'Ações DTVM'
                )
        )
)

INSERT INTO IVT_RoteiroClassificado
    (SeqRoteiroContabil, SeqEsquemaContabil, CodCtaCreditoLancamento, CodCtaDebitoLancamento, CodCentroCustoDebito, CodCentroCustoCredito, SeqEventoContabil)
SELECT
    rc.SeqRoteiroContabil,
    rc.SeqEsquemaContabil,
    rc.CodCtaCreditoLancamento,
    rc.CodCtaDebitoLancamento,
    rc.CodCentroCustoDebito,
    rc.CodCentroCustoCredito,
    iec.SeqEventoContabil
FROM 
    IVT_RoteiroClassificado rc
INNER JOIN 
    EventoContabil ec ON ec.SeqEventoContabil = rc.SeqEventoContabil
INNER JOIN 
    IVT_EventoContabil iec ON iec.DesHistDescritivoEvento = ec.descricao + '| VJORA | VIS' 
        AND iec.ValAtributo01 = 'VJORA'
        AND iec.ValAtributo02 = 'VIS' 
        AND ec.CodEventoContabilSistemaLegado = iec.CodEventoContabilSistemaLegado
WHERE
    rc.SeqEsquemaContabil = (
        SELECT SeqEsquemaContabil 
        FROM IVT_EsquemaContabil 
        WHERE NomEsquemaContabil = 'COSIF'
    )
    AND rc.SeqRoteiroContabil = (
        SELECT SeqRoteiroContabil 
        FROM IVT_Roteiro 
        WHERE NomRoteiroSistemaLegado = 'Ações DTVM'
    )
    AND NOT EXISTS (
        SELECT 1
        FROM IVT_EventoContabil x
        WHERE 
            x.SeqEventoContabil IN (
                SELECT DISTINCT rc.SeqEventoContabil
                FROM IVT_RoteiroClassificado rc
                WHERE 
                    rc.SeqEsquemaContabil = (
                        SELECT SeqEsquemaContabil 
                        FROM IVT_EsquemaContabil 
                        WHERE NomEsquemaContabil = 'COSIF'
                    )
                    AND rc.SeqRoteiroContabil = (
                        SELECT SeqRoteiroContabil 
                        FROM IVT_Roteiro 
                        WHERE NomRoteiroSistemaLegado = 'Ações DTVM'
                    )
            )
            AND ValAtributo01 = 'VJORA'
    );

-----------------------------------------------------
--- >>> CARGA PARA Ações BANCO - COSIF - VJORA <<< ---
-----------------------------------------------------

WITH EventoContabil AS (
    SELECT
        ValAtributo01,
        ValAtributo02,
        LEFT(DesHistDescritivoEvento, CHARINDEX('|', DesHistDescritivoEvento) - 1) AS descricao,
        x.SeqEventoContabil,
        DesHistDescritivoEvento,
        CodEventoContabilSistemaLegado
    FROM
        IVT_EventoContabil x
    WHERE
        x.SeqEventoContabil IN (
            SELECT DISTINCT rc.SeqEventoContabil
            FROM IVT_RoteiroClassificado rc
            WHERE 
                rc.SeqEsquemaContabil = (
                    SELECT SeqEsquemaContabil 
                    FROM IVT_EsquemaContabil 
                    WHERE NomEsquemaContabil = 'COSIF'
                )
                AND rc.SeqRoteiroContabil = (
                    SELECT SeqRoteiroContabil 
                    FROM IVT_Roteiro 
                    WHERE NomRoteiroSistemaLegado = 'Ações BANCO'
                )
        )
)

INSERT INTO IVT_RoteiroClassificado
    (SeqRoteiroContabil, SeqEsquemaContabil, CodCtaCreditoLancamento, CodCtaDebitoLancamento, CodCentroCustoDebito, CodCentroCustoCredito, SeqEventoContabil)
SELECT
    rc.SeqRoteiroContabil,
    rc.SeqEsquemaContabil,
    rc.CodCtaCreditoLancamento,
    rc.CodCtaDebitoLancamento,
    rc.CodCentroCustoDebito,
    rc.CodCentroCustoCredito,
    iec.SeqEventoContabil
FROM 
    IVT_RoteiroClassificado rc
INNER JOIN 
    EventoContabil ec ON ec.SeqEventoContabil = rc.SeqEventoContabil
INNER JOIN 
    IVT_EventoContabil iec ON iec.DesHistDescritivoEvento = ec.descricao + '| VJORA | VIS' 
        AND iec.ValAtributo01 = 'VJORA'
        AND iec.ValAtributo02 = 'VIS' 
        AND ec.CodEventoContabilSistemaLegado = iec.CodEventoContabilSistemaLegado
WHERE
    rc.SeqEsquemaContabil = (
        SELECT SeqEsquemaContabil 
        FROM IVT_EsquemaContabil 
        WHERE NomEsquemaContabil = 'COSIF'
    )
    AND rc.SeqRoteiroContabil = (
        SELECT SeqRoteiroContabil 
        FROM IVT_Roteiro 
        WHERE NomRoteiroSistemaLegado = 'Ações BANCO'
    )
    AND NOT EXISTS (
        SELECT 1
        FROM IVT_EventoContabil x
        WHERE 
            x.SeqEventoContabil IN (
                SELECT DISTINCT rc.SeqEventoContabil
                FROM IVT_RoteiroClassificado rc
                WHERE 
                    rc.SeqEsquemaContabil = (
                        SELECT SeqEsquemaContabil 
                        FROM IVT_EsquemaContabil 
                        WHERE NomEsquemaContabil = 'COSIF'
                    )
                    AND rc.SeqRoteiroContabil = (
                        SELECT SeqRoteiroContabil 
                        FROM IVT_Roteiro 
                        WHERE NomRoteiroSistemaLegado = 'Ações BANCO'
                    )
            )
            AND ValAtributo01 = 'VJORA'
    );