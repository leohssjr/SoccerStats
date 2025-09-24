# Modelo Entidade-Relacionamento

## Entidades
### Atletas
- **PK:** id
- **Atributos:** apelido
- **FK:**
  - clube_id → Clubes.id
  - posicao_id → Posicoes.id
- **Relacionamentos:**
  - Um atleta pertence a um clube (N:1)
  - Um atleta possui uma posição (N:1)
  - Um atleta possui vários scouts (1:N)

### Clubes
- **PK:** id
- **Atributos:** nome, abreviacao, slug
- **Relacionamentos:**
  - Um clube possui vários atletas (1:N)
  - Um clube participa de várias partidas (1:N)
  - Um clube possui vários scouts (1:N)

### Posicoes
- **PK:** id
- **Atributos:** nome
- **Relacionamentos:**
  - Uma posição pode estar vinculada a vários atletas (1:N)
  - ~Uma posição pode estar vinculada a vários scouts (1:N)~ *Analisar remoção*

### Partidas
- **PK:** id
- **Atributos:** rodada, placar_oficial_mandante, placar_oficial_visitante
- **FK:**
  - clube_casa_id → Clubes.id
  - clube_visitante_id → Clubes.id
- **Relacionamentos:**
  - Uma partida possui vários scouts (1:N)

### Scouts
- **PK composta:** atleta_id + rodada + partida_id
- **Atributos:** participou, jogos_num, pontos_num, media_num, preco_num, variacao_num, mando, titular, substituido, tempo_jogado, nota, FS, PE, A, FT, FD, FF, G, I, PP, RB, FC, GC, CA, CV, SG, DD, DP, GS
- **FK:**
  - atleta_id → Atletas.id
  - clube_id → Clubes.id
  - partida_id → Partidas.id
  - ~posicao_id → Posicoes.id~ *Analisar remoção*
- **Relacionamentos:**
  - Cada scout pertence a um atleta, clube, partida e ~posição~ *Analisar remoção* (N:1)
