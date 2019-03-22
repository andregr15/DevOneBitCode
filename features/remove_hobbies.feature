# language:pt

@javascript
Funcionalidade: Remover hobbies do Portfólio
  Remove um hobby do Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui 1 hobby
    E acessa a página de edição do portfólio

  Cenário: Usuário remove um hobby do portfólio
    Quando remove o hobby
    Então o hobby é removido do portfólio