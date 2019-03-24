Dado "o portfólio possui um bloco de sobre mim" do
  create(:block, kind: :about, side: :left, portfolio_id: @portfolio.id)
end

Quando "preenche a descrição sobre ele" do
  @about = attributes_for(:about)
  fill_in "about-description", with: @about[:description]
  page.execute_script("document.getElementById('about-description').disaptchEvent(new Event('blur')")
  wait_for_ajax
end

Então "a descrição sobre ele é adicionada ao portfólio" do
  @about = @portfolio.about
  expect(@portfolio.about.count).to eq(1)
  expect(@portfolio.about.description).to eq(@about.description)
end