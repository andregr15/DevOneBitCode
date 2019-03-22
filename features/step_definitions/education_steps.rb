Dado "o portfólio possui um bloco de educação" do
  create(:block, kind: :education, side: :right, portfolio_id: @portfolio.id)
end

Dado "o portfólio possui 1 educação" do
  create(:block, kind: :education, side: :right, portfolio_id: @portfolio.id)
  @education = create(:education, portfolio_id: @portfolio.id)
end

Quando "adiciona uma educação" do
  @education = attributes_for(:education)
  fill_in "education-title", with: @education[:title]
  fill_in "education-institution", with: @education[:institution]
  fill_in "education-description", with: @education[:description]
  fill_in "education-start-date", with: @education[:start_date]
  fill_in "education-end-date", with: @education[:end_date]
  find("#add-education").click
  wait_for_ajax
end

Quando "remove a educação" do
  find(".remove-education").click
  wait_for_ajax
end

Então "a educação é adicionada ao portfólio" do
  @portfolio.reload
  expect(@portfolio.educations.count).to eq(1)
  expect(page).to have_css(".resource-education", count: 1)
end

Então "a educação é removida do portfólio" do
  @portfolio.reload
  expect(@portfolio.educations.count).to eq(0)
  expect(page).not_to have_css(".resource-education")
end