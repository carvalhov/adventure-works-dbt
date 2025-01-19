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


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
