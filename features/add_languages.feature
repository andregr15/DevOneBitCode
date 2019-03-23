# language:pt

@javascript
Funcionalidade: Adicionar linguagens ao Portfólio
  Adiciona uma nova linguagem ao Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui um bloco de linguagens
    E acessa a página de edição do portfólio

  Cenário: Usuário adiciona uma nova linguagem ao portfólio
    Quando adiciona uma linguagem
    Então a linguagem é adicionada ao portfólio