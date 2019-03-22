# language:pt

@javascript
Funcionalidade: Adicionar hobbies ao Portfólio
  Adiciona um novo hobby ao Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui um bloco de hobbies
    E acessa a página de edição do portfólio

  Cenário: Usuário adiciona um hobby ao portfólio
    Quando adiciona um hobby
    Então o hobby é adicionado ao portfólio