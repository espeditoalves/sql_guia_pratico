FROM python:3.11-slim

# Instala dependências necessárias para o Poetry e Jupyter
RUN apt-get update && apt-get install -y curl && \
    curl -sSL https://install.python-poetry.org | python3 - --version 1.8.4 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Adiciona o Poetry ao PATH
ENV PATH="/root/.local/bin:$PATH"

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o arquivo pyproject.toml e poetry.lock para o diretório de trabalho no container
COPY pyproject.toml poetry.lock* ./  

# Instala as dependências do projeto utilizando o Poetry, incluindo o jupyter e ipykernel
RUN poetry install --no-dev --no-interaction --no-ansi && \
    poetry add jupyter ipykernel

# Copia todo o conteúdo do projeto para o diretório de trabalho no container
COPY . .  

# Registra o kernel do Jupyter
RUN poetry run python -m ipykernel install --name=meu_projeto --display-name "sql_gui_pratico"

# Exponha a porta padrão do Jupyter Notebook
EXPOSE 8888

# Comando padrão ao iniciar o container (executa o Jupyter Notebook)
CMD ["poetry", "run", "jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
