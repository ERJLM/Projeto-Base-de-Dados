# Projeto-Base-de-Dados


## Instalação de dependências

Precisa de ter o Python 3 e o gestor de pacotes pip instalado.
Experimente executar `python3 --version` e `pip3 --version` para saber
se já estão instalados. Em caso negativo, pode por exemplo em Ubuntu
executar:

```
sudo apt-get install python3 python3-pip
```

Tendo Python 3 e pip instalados, deve instalar as bibliotecas Python `Flask`, `PyMySQL`, e `cryptography` em Python, executando o comando:

```
pip3 install --user Flask==1.1.4 PyMySQL==1.0.2 cryptography==36.0.0
``` 
(em README da app base)

## Serviço MySQL (se necessário)
terminal aparte (notar localizacoes)
```
sudo service mysql start
``` 
depois...
```
sudo mysql
``` 
e depois...
```
source tabelas.sql
``` 
finalmente...
```
source dados.sql
``` 

## Servidor
```
python3 server.py
``` 
