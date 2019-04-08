Dado "o portfólio possui um bloco de sobre mim" do
  create(:block, kind: :about, side: :left, portfolio_id: @portfolio.id)
end

Quando "preenche a descrição sobre ele" do
  @about = attributes_for(:about)
  
  within_frame find("#cke_about_description iframe") do
    find('body').base.send_keys @about[:description]
  end

  find('body').click
  sleep(2)
end

Então "a descrição sobre ele é adicionada ao portfólio" do
  @portfolio.reload
  expect(@portfolio.about.description).to eql("<p>#{@about[:description]}My description</p>\n")
end