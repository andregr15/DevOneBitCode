# language:pt

@javascript
Funcionalidade: Remove linguagens do Portfólio
  Remove uma linguagem do Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui 1 linguagem
    E acessa a página de edição do portfólio

  Cenário: Usuário remove uma linguagem do portfólio
    Quando remove a linguagem
    Então a linguagem é removida do portfólio