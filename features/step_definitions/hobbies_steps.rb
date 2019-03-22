Dado "o portfólio possui um bloco de hobbies" do
  create(:block, kind: :hobby, side: :right, portfolio_id: @portfolio.id)
end

Dado "o portfólio possui 1 hobby" do
  create(:block, kind: :hobby, side: :right, portfolio_id: @portfolio.id)
  @hobby = create(:hobby, portfolio_id: @portfolio.id)
end

Quando "adiciona um hobby" do
  @hobby = attributes_for(:hobby)
  fill_in "hobby-title", with: @hobby[:title]
  fill_in "hobby-percent", with: @hobby[:percent]
  find("#add-hobby").click
  wait_for_ajax
end

Quando "remove o hobby" do
  find(".remove-hobby").click
  wait_for_ajax
end

Então "o hobby é adicionado ao portfólio" do
  @portfolio.reload
  expect(@portfolio.hobbies.count).to eq(1)
  expect(page).to have_css(".resource-hobby", count: 1)
end

Então "o hobby é removido do portfólio" do
  @portfolio.reload
  expect(@portfolio.hobbies.count).to eq(0)
  expect(page).not_to have_css(".resource-hobby")
end