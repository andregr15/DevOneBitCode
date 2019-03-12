Quando 'clica para cria um novo portfólio' do
  find(:xpath, "//a[@class='new-portfolio']").click
end

Então "o usuário deve ter {int} portfólios cadastrados" do |count|
  expect(@user.portfolios.count).to eq count
end

Então 'deve ver os dados iniciais do portfólio' do
  expect(page).to have_content(@user.portfolios.last.slug)
end

Então 'é direcionado para a página de edião do portfólio' do
  expect(page).to have_current_path(edit_portfolio_path(@user.portfolios.last))
end