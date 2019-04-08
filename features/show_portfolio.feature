# language:pt

@javascript
Funcionalidade: Visualizar Portfólio
  Visualizar um Portfólio cadastrado

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E acessa a lista de portfólios

  Cenário: Usuário vê o portfólio
    Quando clica no botão visualizar o portfólio
    Então é redirecionado para a tela de visualização do portfólio