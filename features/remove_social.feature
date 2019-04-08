# language:pt

@javascript
Funcionalidade: Remover dados sociais do Portfólio
  Remove um dado social do Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui 1 dado social
    E acessa página de edição do portfólio

  Cenário: Usuário remove um dado social do portfólio
    Quando remove o dado social
    Então o dado social é removido do portfólio