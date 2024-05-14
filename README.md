## Arquitetura do Projeto

Arquitetura utilizada: MVP

Esta arquitetura proporciona uma melhor separação das camadas do projeto. Tendo a Model
como a camada de dados, a View com todos os elementos gráficos em viewcode e finalmente 
o Presenter, que tem por sua missão integrar os dados da Model de uma forma 
apresentável para cada View. 
Foram aplicados design patterns como: delegate, usecase, protocols, singletons.

## Bibliotecas Utilizadas

Só foram utilizados frameworks nativos nesta aplicação

## Funcionalidades

Tela inicial com duas tabs:
Manchetes: Um tabel view exibindo artigos de tecnologia na lingua portuguesa;

<img src="https://github.com/rafaelnmelo/borngazette/assets/61908103/c22b6c88-a1bc-4618-8ced-bcccab79caeb" width="200">


Ler depois: Uma listagem dos artigos marcados como para leitura posterior;

<img src="https://github.com/rafaelnmelo/borngazette/assets/61908103/d777d5fc-d9cd-4d74-a249-3091270fe5d4" width="200">


Loading no carregamento da listagem de artigos;

<img src="https://github.com/rafaelnmelo/borngazette/assets/61908103/cf957b24-8544-4bda-b457-272f641a0d6d" width="200">


Tela de tratamento de erros (falta de internet e erro na api) na tela manchetes;

<img src="https://github.com/rafaelnmelo/borngazette/assets/61908103/1f2055cf-09ee-4ce1-a533-954063a8ce5a" width="200">


Tela de detalhe do artigo com informações como foto, data e conteúdo;

<img src="https://github.com/rafaelnmelo/borngazette/assets/61908103/d9f63036-c3d8-4209-bc95-095e3c7a12a6" width="200">


A tela do artigo possui um botão para fazer a leitura completa na fonte;

<img src="https://github.com/rafaelnmelo/borngazette/assets/61908103/98291f27-a760-4987-85d4-5564ce9aa460" width="200">


Ela possui também um botão de salvar o artigo para leitura futura;

<img src="https://github.com/rafaelnmelo/borngazette/assets/61908103/8c42711b-ebd2-4200-8798-45737b3a4710" width="200">


Accent color escura pra ter uma sensação mais agradável para leitura
