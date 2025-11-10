FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir jupyter nbconvert

COPY . .

WORKDIR /app/transformer/etl

CMD ["jupyter", "nbconvert", "--to", "notebook", "--execute", "raw_to_silver.ipynb", "--output", "raw_to_silver_executado.ipynb"]
CMD ["jupyter", "nbconvert", "--to", "notebook", "--execute", "silver_to_gold.ipynb", "--output", "silver_to_gold_executado.ipynb"]
