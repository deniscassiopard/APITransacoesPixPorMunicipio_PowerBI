## Este projeto fornece uma consulta em Power Query (M) que obtém dados de transações Pix por município diretamente da API do Banco Central do Brasil. <br> A consulta automatiza a coleta de dados de múltiplos meses, processando e estruturando-os para análise no Power BI <br> ##

## **Accesso a API** ##
https://olinda.bcb.gov.br/olinda/servico/Pix_DadosAbertos/versao/v1/aplicacao#!/recursos/TransacoesPixPorMunicipio

## **Documentação da API** ##
https://olinda.bcb.gov.br/olinda/servico/Pix_DadosAbertos/versao/v1/documentacao

## **Funcionalidades** ##
Conexão direta com a API do Banco Central do Brasil. <br>
Coleta automática de transações Pix para múltiplos meses. <br>
Estrutura os dados retornados em um formato tabular. <br>
Ordena os dados por AnoMês de forma decrescente. <br>
Aplica tipagem correta para melhor análise. <br>

## **Requisitos** ##
Power BI através do Power Query (M). <br>
Conexão com a internet para acessar a API do Banco Central. <br>
Altere a variável ***Meses*** no código para incluir ou remover anos/meses para novos dados. <br>

## **Como Usar** ##
Abra o Power BI. <br>
Crie uma nova consulta no editor de consultas Power Query Editor. <br>
Copie e cole o código do arquivo TransacoesPixPorMunicipio.pq no editor de consultas. <br>
Execute a consulta para carregar os dados. <br>
Recomendo renomaer a consulta para ***f_APITransacoesPixPorMunicipio***.
Utilize os dados no Power BI para criar visualizações e relatórios. <br>
