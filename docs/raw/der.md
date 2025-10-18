# Diagrama Entidade-Relacionamento (DER)

O diagrama abaixo representa as entidades e relacionamentos do domínio (camada raw) conforme o MER e o dicionário de dados.

```mermaid
erDiagram
	CLUBES {
		int id
		string nome
		string abreviacao
		string slug
	}

	POSICOES {
		int id
		string nome
		string abreviacao
	}

	ATLETAS {
		int id
		string apelido
		int clube_id
		int posicao_id
	}

	PARTIDAS {
		int id
		int rodada
		int clube_casa_id
		int clube_visitante_id
		int placar_oficial_mandante
		int placar_oficial_visitante
	}

	SCOUTS {
		int atleta_id
		int rodada
		int clube_id
		int partida_id
		boolean participou
		boolean mando
		boolean titular
		boolean substituido
		float tempo_jogado
		int nota
		int jogos_num
		int pontos_num
		int media_num
		int preco_num
		int variacao_num
		int FS
		int PE
		int A
		int FT
		int FD
		int FF
		int G
		int I
		int PP
		int RB
		int FC
		int GC
		int CA
		int CV
		int SG
		int DD
		int DP
		int GS
	}

	PONTUACAO {
		string abreviacao
		string nome
		float pontuacao
	}

	STATUS {
		int id
		string nome
	}

		CLUBES ||--o{ ATLETAS : "possui (1:N)"
		POSICOES ||--o{ ATLETAS : "define (1:N)"
		CLUBES ||--o{ PARTIDAS : "mandante (1:N)"
		CLUBES ||--o{ PARTIDAS : "visitante (1:N)"
		ATLETAS ||--o{ SCOUTS : "tem (1:N)"
		CLUBES ||--o{ SCOUTS : "clube_no_jogo (1:N)"
		PARTIDAS ||--o{ SCOUTS : "ocorre_em (1:N)"
```

Notas
- Chave composta de `SCOUTS` (atleta_id, rodada, partida_id) é conceitual; Mermaid ER não suporta declarar PK composta no bloco, por isso está documentada aqui.
- `Scouts.posicao_id`: presente no dicionário, mas passível de remoção futura (informação já está em Atletas → Posicoes).
- Tabelas `PONTUACAO` e `STATUS` são referenciais/apoio e não se relacionam diretamente às demais neste modelo conceitual.

<font size="3"><p style="text-align: center"><b>Autores:</b>  <a href="https://github.com/leohssjr">Leonardo Sauma</a>, <a href="https://github.com/lramon2001">Lucas Ramon</a>. 2025</p></font>
