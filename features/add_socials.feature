# language:pt

@javascript
Funcionalidade: Adicionar dados sociais ao Portfólio
  Adiona um novo dado social ao Portfólio

  Cenário de Fundo:
    Dado usuário esta logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui um bloco de dados sociais
    E acessa a página de edição do portfólio

  Cenário: Usuário adiciona um novo dado social
    Quando adiciona um dado social
    Então o dado social é adicionado ao portfólio