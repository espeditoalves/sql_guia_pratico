
# Projeto de Ciência de Dados com Docker e PostgreSQL:sql_guia_pratico

Este projeto é uma estrutura básica para iniciar projetos de ciência de dados utilizando Python e PostgreSQL em um ambiente Docker. Ele inclui um `Dockerfile` e um `docker-compose.yml` para criar e gerenciar o ambiente. E também conta com o arquivo **pyproject.toml** do poetry para gerenciamento das dependencias do projeto.

## Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas em sua máquina:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Estrutura do Projeto

```
/sql_guia_pratico
│
├── Dockerfile             # Arquivo de configuração para construir a imagem Docker
├── docker-compose.yml     # Arquivo de configuração do Docker Compose
├── pyproject.toml          # Arquivo com as dependências do projeto (bibliotecas Python)
└── README.md              # Documentação do projeto
```

## Como usar

## 1. Clone o repositório

Clone este repositório para o seu ambiente local:

```bash
git clone https://github.com/espeditoalves/sql_guia_pratico.git
cd sql_guia_pratico
```


## 2. Construir a imagem Docker

Execute o comando abaixo para construir a imagem Docker:

```bash
docker-compose build
```

## 3. Iniciar os containers

Inicie os containers executando o seguinte comando:

```bash
docker-compose up
docker-compose up -d # Para inicio os containers em segundo plano
```

## 4. Para usar no Vscode

### 4.1 devcontainer

O arquivo **`.devcontainer/devcontainer.json`** inicia automaticamente o container quando você abre o projeto no VSCode. Aqui está como isso funciona:
Minha configuração:
```bash
{
    "name": "Postgresql Data Science Project",
    "dockerComposeFile": "../docker-compose.yml",
    "service": "python_app",  // O nome do serviço deve ser o nome exato usado no arquivo docker-compose.yml
    "workspaceFolder": "/app",
    "settings": {
      "python.pythonPath": "/root/.local/share/virtualenvs/meu_projeto/bin/python",
      "python.formatting.provider": "black",  // Exemplo de configuração para formatação
      "python.linting.enabled": true,
      "python.linting.pylintEnabled": true
    },
    "extensions": [
      "ms-python.python",
      "ms-toolsai.jupyter",
      "esbenp.prettier-vscode",  // Para formatação de código
      "ms-vscode.cpptools"  // Se você usar C/C++ em algum momento
    ],
    "postCreateCommand": "poetry install",  // Comando a ser executado após a criação do container
    "remoteUser": "root"  // Usuário para conectar no container
  }

```
#### Como Funciona

**`Abrir o Projeto no VSCode:`**

Quando você abre a pasta do seu projeto no VSCode, se a extensão **Remote - Containers** estiver instalada, você verá uma opção para Reabrir em Container na parte inferior direita da janela do VSCode.

**`Reabrir em Container:`** Ao selecionar essa opção, o VSCode lê o arquivo **devcontainer.json** e cria um container Docker com base nas definições do **`docker-compose.yml`**.

- Inicia o serviço especificado (neste caso, python_app).
- Executa o comando postCreateCommand (neste caso, poetry install) para instalar as dependências do seu projeto.
- Configura o ambiente de desenvolvimento, incluindo a instalação das extensões especificadas.

**`Ambiente Pronto:`** Após o container ser iniciado e o ambiente configurado, você estará pronto para trabalhar diretamente no projeto dentro do VSCode.

**`Vantagens
Automação:`** Você não precisa iniciar o container manualmente toda vez que quiser trabalhar no projeto. O VSCode faz isso automaticamente para você.

**`Facilidade de Uso:`** Com essa configuração, o ambiente é facilmente reutilizável, e qualquer novo desenvolvedor que clonar o repositório pode começar a trabalhar rapidamente.

**`Consistência:`** Garante que todos que trabalham no projeto estejam utilizando o mesmo ambiente, reduzindo problemas de "funciona na minha máquina".

## 5. Para usar Jupyter Notebook Navegador

Para acessar pelo navegar utilize o **prompt** de comando ou o **power shell**, navegue até a pasta onde está o projeto.
use os comandos:
- docker-compose start - Para iniciar os containers existentes
- docker-compose logs - Para ter acesso ao link de conexão ao jupyter notebook


## 6. Acessar o container

Se você deseja abrir o bash no container e interagir diretamente, execute:

```bash
docker exec -it sql_guia_pratico-python_app-1 sh
```
**`docker exec:`** Comando direto no Docker para interagir com containers específicos, requer nome ou ID do container.
**`docker-compose exec:`** Usa o arquivo `docker-compose.yml` para interagir com serviços, simplificando o gerenciamento em projetos com múltiplos containers.

## 7. Acessar o PostgreSQL

Para acessar o PostgreSQL a partir do terminal, use o seguinte comando:

```bash
docker-compose exec postgres_db psql -U usuario -d meu_banco
```

## 8. Rodar scripts Python com conexão ao PostgreSQL

Você pode rodar scripts Python dentro do container, incluindo conexão ao PostgreSQL usando `psycopg2`. Por exemplo, se tiver um arquivo `main.py`:

```bash
docker-compose exec python_app python3 main.py
```

### 8.1 Configurações do PostgreSQL

- Porta exposta: `5432`
- Usuário padrão: `usuario`
- Senha: `senha`
- Banco de dados: `meu_banco`

## 9. Personalização

- Para adicionar novos pacotes, basta adicionar no `poetry`.

- O volume configurado no `docker-compose.yml` sincroniza automaticamente o diretório local com o diretório `/app` dentro do container, facilitando o desenvolvimento.

- 
## 10 Comandos uteis
### 10.1 Cria e inicia containers
```bash
docker-compose up
```
### 10.2 Fecha os containers e apaga eles
```bash
docker-compose down
```
### 10.3 Inicia os containers já existes

```bash
docker-compose start
```
### 10.4 Fecha os containers já existentes
```bash
docker-compose stop
```
todos esses comandos do **`Docker Compose`** precisam ser executados no diretório onde está localizado o arquivo **docker-compose.yml** do seu projeto. Isso é importante porque o **`Docker Compose`** procura o arquivo **`docker-compose.yml`** no diretório atual para saber como deve configurar e gerenciar os containers.

