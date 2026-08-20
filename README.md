# 🎮 Quake 3 Log Parser API

Uma API RESTful desenvolvida em Ruby on Rails focada no processamento, agregação e análise dos arquivos de log de partidas do jogo Quake 3 Arena (`games.log`).

## 💡 Solução Proposta

A solução foi construída utilizando os princípios de **Programação Orientada a Objetos (POO)** e uma arquitetura **Database-less** (sem dependência de banco de dados relacional como o PostgreSQL/SQLite).

- **Encapsulamento e Responsabilidade Única:** O processamento do log é dividido em serviços customizados. O parser lê o arquivo linha a linha, identifica os eventos de início/fim de jogo, gerencia os kills e aplica as regras de negócio especificadas.
- **Regras de Negócio de Kills:**
  - Jogadores que morrem para o `<world>` perdem **-1 kill**.
  - O `<world>` não é contabilizado na lista de jogadores nem no dicionário de kills.
  - O `total_kills` inclui todas as mortes da partida (inclusive as causadas pelo `<world>`).
- **Agregação e Relatórios:** A API consolida os dados de cada jogo em memória para expor as estatísticas por ID da partida e gerar o ranking geral de jogadores.

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Ruby 3.2+
- **Framework:** Ruby on Rails (API mode)
- **Testes:** RSpec
- **Containerização:** Docker & Docker Compose

---

## ⚙️ Como Fazer o Setup

Você pode rodar a aplicação de duas maneiras: utilizando **Docker** (recomendado) ou **Localmente**.

### Opção 1: Via Docker (Recomendado)

#### Pré-requisitos

- Docker Engine e Docker Compose instalados.

#### Passos

1. Clone o repositório:

```bash
git clone git@github.com:AndressaVilin/quake_parser_api.git
cd quake_parser_api
```

2. Suba o ambiente containerizado:

```bash
docker compose up -d --build
```

3. A API estará pronta e acessível em `http://localhost:3000/api/v1`.

### Opção 2: Execução Local (Sem Docker)

#### Pré-requisitos

- Ruby 3.2+ e Bundler instalados.

#### Passos

1. Clone o repositório:

```bash
git clone git@github.com:AndressaVilin/quake_parser_api.git
cd quake_parser_api
```

2. Instale as dependências:

```bash
bundle install
```

3. Inicie o servidor do Rails:

```bash
bundle exec rails server
```

4. A API estará acessível em `http://localhost:3000/api/v1`.

---

## 🧪 Suíte de Testes (Diferencial)

Para garantir a qualidade, integridade do parser e regressão das regras de negócio, o projeto conta com uma suíte de testes automatizados utilizando **RSpec**.

Para executar os testes unitários e de integração:

**Via Docker:**

```bash
docker compose run --rm test bundle exec rspec
```

**Localmente:**

```bash
bundle exec rspec
```

---

## ⚡ Rake Tasks (CLI)

Além dos endpoints da API, o projeto disponibiliza uma Rake task para gerar o relatório impresso diretamente no terminal (atendendo aos requisitos de execução via linha de comando).

### Executando o Relatório no Terminal

**Via Docker:**

```bash
docker compose exec web bundle exec rake report:generate
```

**Localmente:**

```bash
bundle exec rake report:generate
```

Esta task processa o arquivo de log e imprime formatado no terminal:

- Relatório individual detalhado de cada partida (`game_1`, `game_2`, etc.).
- Ranking global consolidado de pontuação/kills dos jogadores.

---

## 📌 Endpoints da API

Abaixo estão os endpoints expostos pela aplicação para consulta dos dados processados do log:

| Método | Endpoint                         | Descrição                                                                         |
| :----- | :------------------------------- | :-------------------------------------------------------------------------------- |
| `GET`  | `/api/v1/games`                  | Relatório completo com todas as partidas agrupadas (Task 1 & Task 2).             |
| `GET`  | `/api/v1/games/:id`              | Busca o resultado detalhado de um jogo específico por ID (ex: `game_1`) (Task 3). |
| `GET`  | `/api/v1/reports/global_ranking` | Exibe o ranking geral consolidado de kills de todos os jogadores (Task 2).        |

---

## 📄 Exemplos de Retorno da API

### 1. Detalhes de um Jogo (`GET /api/v1/games/game_1`)

```json
{
  "game_1": {
    "total_kills": 45,
    "players": ["Dono da bola", "Isgalamido", "Zeh"],
    "kills": {
      "Dono da bola": 5,
      "Isgalamido": 18,
      "Zeh": 20
    }
  }
}
```

### 2. Ranking Geral de Jogadores (`GET /api/v1/reports/global_ranking`)

```json
{
  "ranking_global": {
    "Zeh": 120,
    "Isgalamido": 95,
    "Dono da bola": 42
  }
}
```

---

## 📁 Estrutura Principais Arquivos

```text
.
├── app/
│   ├── controllers/
│   │   └── api/
│   │       └── v1/            # Controllers RESTful da API
│   │           ├── games_controller.rb
│   │           └── reports_controller.rb
│   └── services/              # Regras de negócio e parser POO
│       ├── game.rb
│       ├── log_parser.rb
│       └── report_generator.rb
├── lib/
│   └── tasks/                 # Rake tasks auxiliares
│       └── report.rake
├── spec/                      # Suíte de testes automatizados (RSpec)
│   ├── requests/
│   │   └── api/
│   │       └── v1/
│   │           ├── games_spec.rb
│   │           └── reports_spec.rb
│   ├── services/
│   │   ├── log_parser_spec.rb
│   │   └── report_generator_spec.rb
│   ├── rails_helper.rb
│   └── spec_helper.rb
│
├── storage/                   # Onde o arquivo games.log fica armazenado
│   └── games.log
├── docker-compose.yml         # Orquestração do ambiente
└── Dockerfile                 # Configuração da imagem da aplicação
```

---

## 🧑‍💻 Autora

Desenvolvido por **Andressa** como parte do desafio técnico para a vaga de Desenvolvedor Júnior Ruby on Rails.

[LinkedIn](https://www.linkedin.com/in/andressa-evilin-986427359/) • [GitHub](https://github.com/AndressaVilin)
