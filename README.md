Esse projeto trata-se da etapa de transformação de um pipeline de dados. Os dados tratam principalmente das vendas (sales) da empresa 'Adventure Works' que foram extraídos do postgres através do meltano e carregados na plataforma de dados snowflake-gcp. O projeto utiliza a divisão clássica do [dbt](https://docs.getdbt.com/docs/build/documentation) em layers sendo staging, intermediate e marts.

# Transforming with dbt
## 1. Clone this repository

A primeira etapa para trabalhar com esse projeto é realizar a clonagem do repositório via chave SSH. [Saiba mais](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)


## 2. Create virtual Enviroment

Criando o ambiente virtual no linux para poder instalar as bibliotecas do projeto.

python3 -m venv .venv
source .venv/bin/activate

## 3. Install requeriments

Instalando as bibliotecas presentes no requeriments.

pip install -r requeriments.txt


## 4. Configure suas credenciais criando um arquivo '.env'

Nessa etapa, deve-se crir um arquivo .env realizando a declaração de credenciais para assegurar a proteção de dados do cliente.

Exemplo:

export DBT_DEFAULT_TARGET="dev";

export DBT_SNOWFLAKE_ACCOUNT_ID='account_id'
export DBT_SNOWFLAKE_DATABASE='database_name'
export DBT_SNOWFLAKE_PASSWORD='password'
export DBT_SNOWFLAKE_ROLE='role_dbt'
export DBT_SNOWFLAKE_USER='username'
export DBT_SNOWFLAKE_WAREHOUSE='COMPUTE_WH'

export DBT_SNOWFLAKE_SCHEMA='dev_firstname_lastname'

# credentials for prod
export DBT_SNOWFLAKE_DATABASE_PROD='prod_database_name'
export DBT_SNOWFLAKE_SCHEMA_PROD='prod_schema'

## 5. Verifique se as conexões estão adequadas

Tente usar o seguinte comando para verficar a conexão:

```bash
dbt debug
```

## 6. Alguns comandos do dbt
- dbt build
- dbt build -m model (Para um modelo específico)
- dbt build -m +model (Para todos os modelos que estão associados a aquele modelo)
- dbt run
- dbt run -m model
- dbt run -m +model
- dbt test
- dbt test --select model

## 7. Direcionando modelos para prod
É importante configurar o dbt_project.yml para operacionar a materialização de forma diferente nos ambientes
'dev' e 'prod', quando for dev (default) todos os modelos irão para o Snowflake como tabela, enquanto quando
prod, apenas os modelos na marts serão materializados como table, enquanto o restante irá como 'ephemeral'.

```bash
models:
  adventure_works_dbt:
    staging:
      +materialized: "{{ 'table' if target.name == 'dev' else 'ephemeral' }}"
    intermediate:
      +materialized: "{{ 'table' if target.name == 'dev' else 'ephemeral' }}"
    marts:
      +materialized: "{{ 'table' }}"
```

Ao final, os comandos precisam ser direcionados para prod usando o target:
Por exemplo, o comando dbt build deve ser utilizado como:
- dbt build --target prod

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
