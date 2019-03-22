# language:pt

@javascript
Funcionalidade: Adicionar educações ao Portfólio
  Adiciona uma nova educação ao Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui um bloco de educação
    E acessa a página de edição do portfólio
  
  Cenário: Usuário adiciona uma nova educação ao Portfólio
    Quando adiciona uma educação
    Então a educação é adicionada ao portfólio