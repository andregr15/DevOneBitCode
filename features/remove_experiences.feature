# language:pt

@javascript
Funcionalidade: Remover experiências do Portfólio
  Remove uma experiência do Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui 1 experiência
    E acessa a página de edição do portfólio

  Cenário: Usuário remove uma experiência do Portfólio
    Quando remove a experiência
    Então a experiência é removida do Portfólio