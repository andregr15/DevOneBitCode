# language:pt

@javascript
Funcionalidade: Usuário adiciona informação adicional ao Portfólio
  Usuário adiciona informação adicional ao Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui 1 bloco de informação adicional
    E acessa a página de edição do portfólio

  Cenário: Usuário adiciona informação adicional do portfólio
    Quando adiciona a informação adicional
    Então a informação adicional é adicionada