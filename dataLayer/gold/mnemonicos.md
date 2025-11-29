# Mnemônicos - Camada Gold 

Este documento detalha a padronização mnemônica utilizada nas tabelas da camada **Gold** do Data Warehouse Cartola.


## Tabelas Dimensões


### `DIM_ATL` (Dimensão Atleta)

| Atributo | Tipo (SQL) | Descrição Completa | Mnemônico Explicado |
| :--- | :--- | :--- | :--- |
| **srk_atl** | BIGSERIAL (PK) | Surrogate Key do Atleta | `srk` (Surrogate Key) + `atl` (Atleta) |
| **atl_idn** | BIGINT | ID natural do atleta (ID do Cartola) | `idn` (ID Natural) + `atl` (Atleta) |
| **atl_ape** | TEXT | Apelido do atleta | `ape` (Apelido) + `atl` (Atleta)|
| **atl_pid** | BIGINT | Código da posição (ID) | `pid` (Posição ID) + `atl` (Atleta) |
| **atl_pos** | TEXT | Nome/descrição da posição | `pos` (Posição) + `atl` (Atleta)|

---

### `DIM_CLB` (Dimensão Clube)

| Atributo | Tipo (SQL) | Descrição Completa | Mnemônico Explicado |
| :--- | :--- | :--- | :--- |
| **srk_clb** | BIGSERIAL (PK) | Surrogate Key do Clube | `srk` (Surrogate Key) + `clb` (Clube)|
| **clb_idn** | BIGINT | ID natural do clube no Cartola | `idn` (ID Natural) + `clb` (Clube)|
| **clb_nme** | TEXT | Nome completo do clube | `nme` (Nome) + `clb` (Clube)|
| **clb_abv** | TEXT | Abreviação do clube | `abv` (Abreviação) + `clb` (Clube)|
| **clb_slg** | TEXT | Slug ou nome curto para identificação textual | `slg` (Slug) + `clb` (Clube)|

---

### `DIM_PAR` (Dimensão Partida)

| Atributo | Tipo (SQL) | Descrição Completa | Mnemônico Explicado |
| :--- | :--- | :--- | :--- |
| **srk_par** | BIGSERIAL (PK) | Surrogate Key da Partida | `srk` (Surrogate Key) + `par` (Partida) |
| **par_idn** | BIGINT | ID natural da partida | `idn` (ID Natural) + `par` (Partida)|
| **par_tmp** | INTEGER | Temporada do jogo | `tmp` (Temporada) + `par` (Partida)|
| **par_rod** | BIGINT | Número da rodada | `rod` (Rodada) + `par` (Partida)|
| **par_cid** | BIGINT | ID do clube mandante | `cid` (Clube ID) + `par` (Partida)|
| **par_cnm** | TEXT | Nome do clube mandante | `cnm` (Clube Nome Mandante) + `par` (Partida)|
| **par_vid** | BIGINT | ID do clube visitante | `vid` (Visitante ID) + `par` (Partida)|
| **par_vnm** | TEXT | Nome do clube visitante | `vnm` (Visitante Nome) + `par` (Partida)|
| **par_plm** | DOUBLE PRECISION | Placar do mandante | `plm` (Placar Mandante) + `par` (Partida)|
| **par_plv** | DOUBLE PRECISION | Placar do visitante | `plv` (Placar Visitante) + `par` (Partida)|

---

## Tabela Fato


### `FAT_FCP` (Fato Cartola Pontuação)

| Atributo | Tipo (SQL) | Descrição Completa | Mnemônico Explicado |
| :--- | :--- | :--- | :--- |
| **srk_fcp** | BIGSERIAL (PK) | Surrogate Key da fato de pontuação | `srk` (Surrogate Key) + `fcp` |
| **srk_atl** | BIGINT (FK) | Chave estrangeira para Dimensão Atleta | Referência à `DIM_ATL` |
| **srk_clb** | BIGINT (FK) | Chave estrangeira para Dimensão Clube | Referência à `DIM_CLB` |
| **srk_par** | BIGINT (FK) | Chave estrangeira para Dimensão Partida | Referência à `DIM_PAR` |
| **fcp_tmp** | INTEGER | Temporada da partida | `tmp` (Temporada) + `fcp` |
| **fcp_caf** | TEXT | Indica se foi "Casa" ou "Fora" | `caf` (Casa/Fora) + `fcp` |
| **fcp_med** | DOUBLE PRECISION | Média do atleta | `med` (Média) + `fcp` |
| **fcp_prc** | DOUBLE PRECISION | Preço do atleta | `prc` (Preço) + `fcp` |
| **fcp_pts** | DOUBLE PRECISION | Pontuação total do atleta | `pts` (Pontos) + `fcp` |
| **fcp_var** | DOUBLE PRECISION | Variação de preço | `var` (Variação) + `fcp` |
| **fcp_pfs** | BIGINT | Pontos por falta sofrida | `pfs` = Falta Sofrida |
| **fcp_ppe** | BIGINT | Pontos por passe errado | `ppe` = Passe Errado |
| **fcp_pas** | BIGINT | Pontos por assistência | `pas` = Assistência |
| **fcp_pft** | BIGINT | Finalização na trave | `pft` = Finalização na Trave |
| **fcp_pfd** | BIGINT | Finalização defendida | `pfd` = Finalização Defendida |
| **fcp_pff** | BIGINT | Finalização para fora | `pff` = Finalização Fora |
| **fcp_pgl** | BIGINT | Pontos por gol | `pgl` = Gol |
| **fcp_pim** | BIGINT | Pontos por impedimento | `pim` = Impedimento |
| **fcp_ppp** | BIGINT | Pontos por pênalti perdido | `ppp` = Pênalti Perdido |
| **fcp_prb** | BIGINT | Pontos por roubada de bola | `prb` = Roubada de Bola |
| **fcp_pfc** | BIGINT | Pontos por falta cometida | `pfc` = Falta Cometida |
| **fcp_pgc** | BIGINT | Pontos por gol contra | `pgc` = Gol Contra |
| **fcp_pca** | BIGINT | Pontos por cartão amarelo | `pca` = Cartão Amarelo |
| **fcp_pcv** | BIGINT | Pontos por cartão vermelho | `pcv` = Cartão Vermelho |
| **fcp_png** | BIGINT | Pontos por não sofrer gol | `png` = Não Sofrer Gol |
| **fcp_pdd** | BIGINT | Pontos por defesa difícil | `pdd` = Defesa Difícil |
| **fcp_pdp** | BIGINT | Pontos por defesa de pênalti | `pdp` = Defesa de Pênalti |
| **fcp_pgs** | BIGINT | Pontos por gol sofrido | `pgs` = Gol Sofrido |

---

## Glossário de Mnemônicos

Abaixo segue o resumo dos mnemônicos padronizados utilizados na etapa Gold.

| Mnemônico | Significado |
| :--- | :--- |
| **abv** | Abreviação |
| **ape** | Apelido |
| **atl** | Atleta |
| **caf** | Casa/Fora |
| **cat** | Categoria |
| **cid** | Clube ID (Mandante) |
| **clb** | Clube |
| **cnm** | Clube Nome Mandante |
| **cod** | Código |
| **dim** | Dimensão |
| **fcp** | Fato Cartola Pontuação |
| **fat** | Fato |
| **idn** | ID Natural |
| **med** | Média |
| **nme** | Nome |
| **par** | Partida |
| **pas** | Passe / País (dependendo do contexto, aqui não utilizado) |
| **pca** | Pontos Cartão Amarelo |
| **pcv** | Pontos Cartão Vermelho |
| **pdd** | Pontos Defesa Difícil |
| **pdp** | Pontos Defesa de Pênalti |
| **pfc** | Pontos Falta Cometida |
| **pfd** | Pontos Finalização Defendida |
| **pff** | Pontos Finalização Fora |
| **pft** | Pontos Finalização na Trave |
| **pfs** | Pontos Falta Sofrida |
| **pgc** | Pontos Gol Contra |
| **pgl** | Pontos Gol |
| **pgs** | Pontos Gol Sofrido |
| **pid** | Posição ID |
| **pim** | Impedimento |
| **ply** | Player (não usado, apenas exemplo) |
| **plm** | Placar Mandante |
| **plv** | Placar Visitante |
| **pos** | Posição |
| **prb** | Pontos Roubada de Bola |
| **prc** | Preço |
| **ppp** | Pênalti Perdido |
| **pts** | Pontos |
| **rod** | Rodada |
| **slg** | Slug |
| **srk** | Surrogate Key |
| **tmp** | Temporada |
| **var** | Variação |
| **vid** | Visitante ID |
| **vnm** | Visitante Nome |

---
