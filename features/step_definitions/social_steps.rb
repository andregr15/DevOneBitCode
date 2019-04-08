Dado "o portfólio possui um bloco de dados sociais" do
  create(:block, kind: :social, side: :left, portfolio_id: @portfolio.id)
end

Dado "o portfólio possui 1 dado social" do
  create(:block, kind: :social, side: :left, portfolio_id: @portfolio.id)
  @social = create(:social, portfolio_id: @portfolio.id)
end

Quando "adiciona um dado social" do
  @social = attributes_for(:social)
  # another way to select
  # find("#select-social-kind option[value='#{@social[:kind].to_s}']").select_option
  select @social[:kind].to_s.capitalize, from: 'select-social-kind'
  fill_in "social-url", with: @social[:url]
  find("#add-social").click
  wait_for_ajax
end

Então "o dado social é adicionado ao portfólio" do
  @portfolio.reload
  expect(@portfolio.socials.first.kind).to eql(@social[:kind].to_s)
  expect(@portfolio.socials.first.url).to eql(@social[:url])
end

Quando "remove o dado social" do
  find("a.remove-social").click
  wait_for_ajax
end

Então "o dado social é removido do portfólio" do
  @portfolio.reload
  expect(@portfolio.socials.count).to eql(0)
end