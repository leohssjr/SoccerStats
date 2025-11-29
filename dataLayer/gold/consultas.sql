/*
    ARQUIVO: query_cartola.sql
    OBJETIVO: 10 Consultas focadas em desempenho de atletas no Cartola para Power BI
    PÚBLICO: Torcedores / Analistas que não são técnicos de dados.
    ESTRUTURA: CTEs comentadas para virar bases de visuais no BI.
*/

-- ============================================================================
-- 1. [CTE] Melhor Pontuação por Temporada
-- EXPLICAÇÃO: Mostra o recorde de pontuação em cada temporada.
-- Dá origem ao gráfico de linha "Melhor Pontuação por Temporada" e ao KPI
-- de maior pontuação geral.
-- ============================================================================
WITH Melhor_Pontuacao_Temporada AS (
    SELECT
        f.fcp_tmp            AS temporada,
        MAX(f.fcp_pts)       AS melhor_pontuacao
    FROM gold.fat_fcp f
    GROUP BY f.fcp_tmp
)
SELECT
    temporada,
    melhor_pontuacao
FROM Melhor_Pontuacao_Temporada
ORDER BY temporada;


-- ============================================================================
-- 2. [CTE] Recordista Geral: Atleta com a Maior Pontuação em uma Única Rodada
-- EXPLICAÇÃO: Quem fez a maior pontuação de todas, em qual partida e por qual clube.
-- Alimenta o KPI "Maior Pontuação" + nome do atleta.
-- ============================================================================
WITH Recordista_Geral AS (
    SELECT
        f.fcp_tmp                   AS temporada,
        da.atl_ape                  AS atleta,
        da.atl_pos                  AS posicao,
        dc.clb_nme                  AS clube,
        dp.par_rod                  AS rodada,
        dp.par_cnm || ' x ' || dp.par_vnm AS partida,
        f.fcp_pts                   AS pontos
    FROM gold.fat_fcp f
    JOIN gold.dim_atl da ON da.srk_atl = f.srk_atl
    LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
    JOIN gold.dim_par dp ON dp.srk_par = f.srk_par
    ORDER BY f.fcp_pts DESC
    LIMIT 1
)
SELECT *
FROM Recordista_Geral;


-- ============================================================================
-- 3. [CTE] Craque da Temporada: Maior Média de Pontos (com mínimo de jogos)
-- EXPLICAÇÃO: Atleta mais regular da temporada, não apenas um "jogo isolado".
-- Útil para o cartão "Atleta com a Maior Média".
-- Ajuste o mínimo de jogos se quiser (aqui usei 5).
-- ============================================================================
WITH Media_Atleta AS (
    SELECT
        f.fcp_tmp           AS temporada,
        da.atl_ape          AS atleta,
        da.atl_pos          AS posicao,
        dc.clb_nme          AS clube,
        COUNT(*)            AS qtd_jogos,
        AVG(f.fcp_pts)      AS media_pontos
    FROM gold.fat_fcp f
    JOIN gold.dim_atl da ON da.srk_atl = f.srk_atl
    LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
    GROUP BY f.fcp_tmp, da.atl_ape, da.atl_pos, dc.clb_nme
)
SELECT
    temporada,
    atleta,
    posicao,
    clube,
    qtd_jogos,
    media_pontos
FROM Media_Atleta
WHERE qtd_jogos >= 5
ORDER BY media_pontos DESC
LIMIT 1;


-- ============================================================================
-- 4. [CTE] Clube com Maior Média de Pontuação de seus Jogadores
-- EXPLICAÇÃO: Mostra qual clube rende mais pontos em média para o cartoleiro
-- em determinada temporada.
-- Alimenta o cartão "Clube com a Maior Média".
-- ============================================================================
WITH Media_Clube AS (
    SELECT
        f.fcp_tmp       AS temporada,
        dc.clb_nme      AS clube,
        AVG(f.fcp_pts)  AS media_pontos_clube
    FROM gold.fat_fcp f
    LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
    GROUP BY f.fcp_tmp, dc.clb_nme
)
SELECT
    temporada,
    clube,
    media_pontos_clube
FROM Media_Clube
WHERE clube IS NOT NULL
ORDER BY media_pontos_clube DESC;


-- ============================================================================
-- 5. [CTE] TOP 10 Atletas com Maior Média de Pontos
-- EXPLICAÇÃO: Ranking dos jogadores mais regulares (usado no gráfico de barras).
-- Ideal para o visual "TOP 10 Atletas com Maior Média de Pontuação".
-- ============================================================================
WITH Media_Atletas AS (
    SELECT
        f.fcp_tmp           AS temporada,
        da.atl_ape          AS atleta,
        da.atl_pos          AS posicao,
        dc.clb_nme          AS clube,
        COUNT(*)            AS qtd_jogos,
        AVG(f.fcp_pts)      AS media_pontos
    FROM gold.fat_fcp f
    JOIN gold.dim_atl da ON da.srk_atl = f.srk_atl
    LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
    GROUP BY f.fcp_tmp, da.atl_ape, da.atl_pos, dc.clb_nme
)
SELECT
    temporada,
    atleta,
    posicao,
    clube,
    qtd_jogos,
    media_pontos
FROM Media_Atletas
WHERE qtd_jogos >= 5
ORDER BY media_pontos DESC
LIMIT 10;


-- ============================================================================
-- 6. Tabela Detalhada de Partidas
-- EXPLICAÇÃO: Base de detalhe para tabela do BI (Partida x Atleta x Pontuação).
-- Permite drill-down e conferência dos cálculos.
-- ============================================================================
SELECT
    f.fcp_tmp                                           AS temporada,
    dp.par_rod                                          AS rodada,
    dp.par_cnm || ' x ' || dp.par_vnm                   AS partida,
    da.atl_ape                                          AS atleta,
    da.atl_pos                                          AS posicao,
    COALESCE(dc.clb_nme, 'Sem Clube')                   AS clube,
    f.fcp_pts                                           AS pontuacao,
    f.fcp_prc                                           AS valor,
    f.fcp_med                                           AS media_no_campeonato,
    f.fcp_var                                           AS variacao_rodada,
    f.fcp_caf                                           AS casa_ou_fora
FROM gold.fat_fcp f
JOIN gold.dim_atl da ON da.srk_atl = f.srk_atl
LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
JOIN gold.dim_par dp ON dp.srk_par = f.srk_par;


-- ============================================================================
-- 7. Desempenho por Posição (ex.: Goleiros)
-- EXPLICAÇÃO: Mesma ideia da página "Goleiro" do BI.
-- Basta trocar o filtro de posição para 'Lateral', 'Zagueiro', etc.
-- ============================================================================
WITH Media_Posicao AS (
    SELECT
        f.fcp_tmp           AS temporada,
        da.atl_pos          AS posicao,
        da.atl_ape          AS atleta,
        dc.clb_nme          AS clube,
        COUNT(*)            AS qtd_jogos,
        AVG(f.fcp_pts)      AS media_pontos,
        MAX(f.fcp_pts)      AS melhor_pontuacao
    FROM gold.fat_fcp f
    JOIN gold.dim_atl da ON da.srk_atl = f.srk_atl
    LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
    GROUP BY f.fcp_tmp, da.atl_pos, da.atl_ape, dc.clb_nme
)
SELECT
    temporada,
    atleta,
    clube,
    posicao,
    qtd_jogos,
    media_pontos,
    melhor_pontuacao
FROM Media_Posicao
WHERE posicao = 'Goleiro'        
  AND qtd_jogos >= 5
ORDER BY media_pontos DESC
LIMIT 10;


-- ============================================================================
-- 8. Custo-Benefício: Pontos por Cartoleta
-- EXPLICAÇÃO: Mostra quem entrega mais pontos por unidade de preço.
-- Útil para montar um visual de "melhor custo-benefício".
-- ============================================================================
WITH Custo_Beneficio AS (
    SELECT
        f.fcp_tmp           AS temporada,
        da.atl_ape          AS atleta,
        da.atl_pos          AS posicao,
        dc.clb_nme          AS clube,
        COUNT(*)            AS qtd_jogos,
        AVG(f.fcp_pts)      AS media_pontos,
        AVG(f.fcp_prc)      AS preco_medio,
        AVG(f.fcp_pts) / NULLIF(AVG(f.fcp_prc), 0) AS pontos_por_cartoleta
    FROM gold.fat_fcp f
    JOIN gold.dim_atl da ON da.srk_atl = f.srk_atl
    LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
    GROUP BY f.fcp_tmp, da.atl_ape, da.atl_pos, dc.clb_nme
)
SELECT
    temporada,
    atleta,
    posicao,
    clube,
    qtd_jogos,
    media_pontos,
    preco_medio,
    pontos_por_cartoleta
FROM Custo_Beneficio
WHERE qtd_jogos >= 5
  AND preco_medio IS NOT NULL
ORDER BY pontos_por_cartoleta DESC
LIMIT 10;


-- ============================================================================
-- 9. Partidas Mais "Farm de Pontos"
-- EXPLICAÇÃO: Soma das pontuações de todos os atletas de uma partida.
-- Ajuda a identificar confrontos que tendem a ser bons para escalar jogadores.
-- ============================================================================
WITH Pontos_Por_Partida AS (
    SELECT
        dp.par_tmp                          AS temporada,
        dp.par_rod                          AS rodada,
        dp.par_cnm || ' x ' || dp.par_vnm   AS partida,
        SUM(f.fcp_pts)                      AS pontos_totais_partida
    FROM gold.fat_fcp f
    JOIN gold.dim_par dp ON dp.srk_par = f.srk_par
    GROUP BY dp.par_tmp, dp.par_rod, dp.par_cnm, dp.par_vnm
)
SELECT
    temporada,
    rodada,
    partida,
    pontos_totais_partida
FROM Pontos_Por_Partida
ORDER BY pontos_totais_partida DESC
LIMIT 10;


-- ============================================================================
-- 10. Risco x Retorno: Média e Desvio Padrão de Pontos por Atleta
-- EXPLICAÇÃO: Calcula média e volatilidade (stddev) da pontuação do atleta.
-- Útil para gráfico de dispersão "regular x explosivo".
-- ============================================================================
WITH Estatistica_Atleta AS (
    SELECT
        f.fcp_tmp                  AS temporada,
        da.atl_ape                 AS atleta,
        da.atl_pos                 AS posicao,
        dc.clb_nme                 AS clube,
        COUNT(*)                   AS qtd_jogos,
        AVG(f.fcp_pts)             AS media_pontos,
        STDDEV_POP(f.fcp_pts)      AS desvio_pontos
    FROM gold.fat_fcp f
    JOIN gold.dim_atl da ON da.srk_atl = f.srk_atl
    LEFT JOIN gold.dim_clb dc ON dc.srk_clb = f.srk_clb
    GROUP BY f.fcp_tmp, da.atl_ape, da.atl_pos, dc.clb_nme
)
SELECT
    temporada,
    atleta,
    posicao,
    clube,
    qtd_jogos,
    media_pontos,
    desvio_pontos
FROM Estatistica_Atleta
WHERE qtd_jogos >= 5
ORDER BY media_pontos DESC;
