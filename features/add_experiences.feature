# language: pt

@javascript
Funcionalidade: Adicionar experiências ao Portfólio
  Adiciona uma nova experiência no Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui um bloco de experiência
    E acessa a página de edição do portfólio
  
  Cenário: Usuário adiciona uma nova experiência ao Portfólio
    Quando adiciona uma experiência
    Então a experiência é adicionada ao Portfólio