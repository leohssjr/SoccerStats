# Dicionário de Dados

| Tabela       | Campo                        | Tipo        | Descrição                                                                 |
|-------------|-------------------------------|------------|--------------------------------------------------------------------------|
| **Atletas**   | id         | BIGINT (PK)  | Identificador do atleta  |
|               | apelido    | TEXT         | Apelido do Atleta        |
|               | clube_id   | BIGINT(FK)   | ID do clube do jogador   |
|               | posicao_id | BIGINT(FK)   | ID da posição do jogador |             
| **Clubes** | id         | BIGINT (PK) | Identificador do clube  |
|            | nome       | TEXT        | Nome do clube           |
|            | abreviacao | TEXT        | Abreviação do clube     |
|            | slug       | TEXT        | Identificador para APIs |
| **Partidas** | id                       | BIGINT (PK) | Identificador da partida                 |
|              | rodada                   | BIGINT (FK) | Rodada atual do Brasileirão (1 a 38)     |
|              | clube_casa_id            | BIGINT (FK) | ID do clube mandante                     |
|              | clube_visitante_id       | BIGINT (FK) | ID do clube visitante                    |
|              | placar_oficial_mandante  | BIGINT      | Quantidade de gols feitos pelo mandante  |
|              | placar_oficial_visitante | BIGINT      | Quantidade de gols feitos pelo visitante |
| **Scouts** | atleta_id     | BIGINT (FK)      | ID do atleta                                                                |
|            | rodada        | BIGINT           | Rodada atual do Brasileirão (1 a 38)                                        |
|            | clube_id      | BIGINT (FK)      | ID do clube do jogador                                                      |
|            | participou    | BOOLEAN          | Booleano indicando se o jogador participou da rodada                        |
|            | posicao_id    | BIGINT (FK)      | ID da posição do jogador                                                    |
|            | jogos_num     | BIGINT           | Número de partidas disputadas pelo jogador                                  |
|            | pontos_num    | BIGINT           | Pontos marcados pelo jogador na rodada atual                                |
|            | media_num     | BIGINT           | Média de pontos do jogador por rodada jogada                                |
|            | preco_num     | BIGINT           | Preço atual do jogador                                                      |
|            | variacao_num  | BIGINT           | Variação de preço em relação à rodada anterior                              |
|            | partida_id    | BIGINT (FK)      | ID da partida                                                               |
|            | mando         | BOOLEAN          | Booleano indicando se o time tinha mando de campo                           |
|            | titular       | BOOLEAN          | Booleano indicando se jogador entrou como titular                           |
|            | substituido   | BOOLEAN          | Booleano indicando se jogador foi substituido                               |
|            | tempo_jogado  | DOUBLE PRECISION | Tempo jogado como fração do total da partida (1 para 100%, 0 para 0%, ...)  |
|            | nota          | BIGINT           | Nota atribuída ao desempenho do atleta na partida.                          |
|            | FS            | BIGINT           | Número de faltas sofridas pelo atleta.                                      |
|            | PE            | BIGINT           | Número de passes errados pelo atleta.                                       |
|            | A             | BIGINT           | Número de assistências realizadas pelo atleta.                              |
|            | FT            | BIGINT           | Número de chutes na trave pelo atleta.                                      |
|            | FD            | BIGINT           | Número de defesas realizadas pelo atleta (goleiro).                         |
|            | FF            | BIGINT           | Número de chutes fora do gol realizados pelo atleta.                        |
|            | G             | BIGINT           | Número de gols marcados pelo atleta.                                        |
|            | I             | BIGINT           | Número de impedimentos cometidos pelo atleta.                               |
|            | PP            | BIGINT           | Número de pênaltis perdidos pelo atleta.                                    |
|            | RB            | BIGINT           | Número de desarmes bem-sucedidos pelo atleta.                               |
|            | FC            | BIGINT           | Número de faltas cometidas pelo atleta.                                     |
|            | GC            | BIGINT           | Número de gols contra do atleta.                                            |
|            | CA            | BIGINT           | Número de cartões amarelos recebidos pelo atleta.                           |
|            | CV            | BIGINT           | Número de cartões vermelhos recebidos pelo atleta.                          |
|            | SG            | BIGINT           | Número de partidas sem sofrer gols (apenas zagueiros, laterais e goleiros). |
|            | DD            | BIGINT           | Número de defesas difíceis realizadas (apenas goleiros).                    |
|            | DP            | BIGINT           | Número de pênaltis defendidos (apenas goleiros).                            |
|            | GS            | BIGINT           | Número de gols sofridos (apenas goleiros).                                  |
| **Pontuacao** | abreviacao  | TEXT             | Abreviação do tipo de pontuação           |
|               | nome        | TEXT             | Nome do tipo de pontuação                 |
|               | pontuacao   | DOUBLE PRECISION | Valor do tipo de pontuação                |
| **Posicao**   | id         | BIGINT (PK) | ID da posição         |
|               | nome       | TEXT        | Nome da posição       |
|               | abreviacao | TEXT        | Abreviação da posição |
| **Status**    | id         | BIGINT (PK) | ID do status   |
|               | nome       | TEXT        | Nome do status |




