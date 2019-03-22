Dado "o portfólio possui um bloco de habilidades" do
  create(:block, kind: :skill, side: :right, portfolio_id: @portfolio.id)
end

Dado "o portfólio possui 1 habilidade" do
  create(:block, kind: :skill, side: :right, portfolio_id: @portfolio.id)
  @skill = create(:skill, portfolio_id: @portfolio.id)
end

Quando "adiciona uma habilidade" do
  @skill = attributes_for(:skill)
  fill_in "skill-title", with: @skill[:title]
  fill_in "skill-percent", with: @skill[:percent]
  find("#add-skill").click
  wait_for_ajax
end

Quando "remove a habilidade" do
  find(".remove-skill").click
  wait_for_ajax
end

Então "a habilidade é adicionada ao portfólio" do
  @portfolio.reload
  expect(@portfolio.skills.count).to eq(1)
  expect(page).to have_css(".resource-skill", count: 1)
end

Então "a habilidade é removida do portfólio" do
  @portfolio.reload
  expect(@portfolio.skills.count).to eq(0)
  expect(page).not_to have_css(".resource-skill")
end