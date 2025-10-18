# SoccerStats
O projeto processa informações de jogadores por rodada do Campeonato Brasileiro (2014–2017) usando a arquitetura de dados em camadas (raw/bronze → silver → gold).

## Como rodar (Windows + PowerShell)

Pré‑requisitos:
- Docker Desktop (composições Docker)
- Python 3.10+ (recomendado 3.11)

### 1) Configurar variáveis de ambiente
1. Duplique o arquivo `.env.example` para `.env` na raiz do projeto.
2. Ajuste valores se necessário (porta, usuário/senha). Padrões:
	 - POSTGRES_USER=postgres
	 - POSTGRES_PASSWORD=postgres
	 - POSTGRES_DB=db_soccerstats
	 - POSTGRES_PORT=5432

### 2) Subir Postgres com Docker
- No diretório do projeto, execute:

```powershell
docker compose up -d
```

O serviço cria o banco `db_soccerstats` e os schemas `raw`, `silver`, `gold` automaticamente (ver `postgres/init`). Aguarde o container ficar saudável (healthcheck).

Para ver os logs do banco:

```powershell
docker compose logs -f postgres
```

### 3) Preparar ambiente Python

Crie e ative um venv e instale as dependências:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### 4) Executar os notebooks de ETL

Há dois caminhos:

- Usando VS Code/Jupyter: abra os notebooks em `transformer/ETL/`:
	- `raw_to_silver.ipynb`
	- `silver_to_gold.ipynb`
	Certifique-se de selecionar o kernel do venv `.venv`.

- Via terminal (opcional):
	- Você pode usar ferramentas como `papermill` ou `jupyter nbconvert --execute` caso deseje automação em linha de comando (não incluso por padrão neste repo).

Os notebooks leem dados de `dataLayer/raw` e gravam resultados em `dataLayer/silver`/`gold` e/ou no Postgres usando a URL `DATABASE_URL` do `.env` (bibliotecas `sqlalchemy`, `psycopg2-binary` e `python-dotenv`).

### 5) Encerrar serviços

```powershell
docker compose down
```

## Estrutura relevante
- `docker-compose.yml`: serviço Postgres 16 com scripts de init.
- `postgres/init`: cria DB e schemas.
- `dataLayer/raw`: CSVs de origem (2014–2017).
- `transformer/ETL`: notebooks para transformar raw → silver → gold.
- `requirements.txt`: dependências Python para ETL e exploração.

## Dicas e problemas comuns
- Porta em uso (5432): altere `POSTGRES_PORT` no `.env` (e reconstrua `docker compose up -d`).
- Conexão ao DB falha: confirme que o container está saudável e que `DATABASE_URL` aponta para `localhost:<porta>`.
- Permissão para ativar venv no PowerShell: execute uma vez como Admin:
	```powershell
	Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
	```
	Depois, reabra o PowerShell.

## Licença
Uso acadêmico/educacional. Veja o repositório para detalhes adicionais.
