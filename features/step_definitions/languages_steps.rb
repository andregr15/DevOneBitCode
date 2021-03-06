Dado "o portfólio possui um bloco de linguagens" do
  create(:block, kind: :language, side: :right, portfolio_id: @portfolio.id)
end

Dado "o portfólio possui 1 linguagem" do
  create(:block, kind: :language, side: :right, portfolio_id: @portfolio.id)
  @language = create(:language, portfolio_id: @portfolio.id)
end

Quando "adiciona uma linguagem" do
  @language = attributes_for(:language)
  fill_in "language-title", with: @language[:title]
  fill_in "language-percent", with: @language[:percent]
  find("#add-language").click
  wait_for_ajax
end

Quando "remove a linguagem" do
  find(".remove-language").click
  wait_for_ajax
end

Então "a linguagem é adicionada ao portfólio" do
  wait_for_ajax
  @portfolio.reload
  expect(@portfolio.languages.count).to eq(1)
  expect(page).to have_css(".resource-language", count: 1)
end

Então "a linguagem é removida do portfólio" do
  wait_for_ajax
  @portfolio.reload
  expect(@portfolio.languages.count).to eq(0)
  expect(page).not_to have_css('.resource-language')
end