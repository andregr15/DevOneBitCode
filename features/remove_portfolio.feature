# language:pt

@javascript
Funcionalidade: Remoção de Portfólios
  Remove Portfólios

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E acessa a lista de portfólios

  Cenário: Usuário remove o portfólio
    Quando remove o portfólio
    Então o portfólio é removido