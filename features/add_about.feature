# language: pt
Funcionalidade: Usuário adiciona sobre mim ao Portfólio
  O usuário adiciona o sobre mim ao Portfólio

  Cenário de Fundo:
    Dado usuário está logado
    E possui o portfólio com slug 'my_portfolio'
    E o portfólio possui um bloco de sobre mim
    E acessa a página de edição do portfólio

  Cenário: Usuário adiciona a decrição sobre mim
    Quando preenche a descrição sobre ele
    Então a descrição sobre ele é adicionada ao portfólio