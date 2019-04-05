# language:pt

@user_sign_up
Funcionalidade: Fazer cadastro
  O usuário é cadastrado no sistema

  Cenário de Fundo:
    Dado que o usuário está na página principal

  Cenário: Insere dados válidos
    Dado que o usuário tem dados válidos
    Quando preenche e submete o formulário de cadastro
    Então o usuário é cadastrado e redirecionado para a listagem de portfólios

  Cenário: Insere dados inválidos
    Dado que o usuário tem dados inválidos
    Quando preenche e submete o formulário de cadastro
    Então o usuário é redirecionado para a página de sign up