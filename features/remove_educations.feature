# language:pt

@javascript
Funcionalidade: Remover educações do Portfólio
  Remove uma educação do Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui 1 educação
    E acessa a página de edição do portfólio

  Cenário: Usuário remove uma educação do portfólio
    Quando remove a educação
    Então a educação é removida do portfólio