Dado 'que o usuário tem dados válidos' do
  @user = attributes_for(:user)
end

Dado 'que o usuário tem dados inválidos' do
  @user = attributes_for(:user, password: '123' )
end

Quando 'preenche e submete o formulário de cadastro' do
  fill_in 'user[email]', with: @user[:email]
  fill_in 'user[password]', with: @user[:password]
  fill_in 'user[password_confirmation]', with: @user[:password_confirmation]
  find('button.btn.btn-large.custom-blue').click
end

Então 'o usuário é cadastrado e redirecionado para a listagem de portfólios' do
  expect(User.count).to eql(1)
  expect(User.first.email).to eql(@user[:email])
  expect(page.current_path).to eql("/portfolios")
end

Então 'o usuário é redirecionado para a página de sign up' do
  expect(page.current_path).to eql("/users")
end