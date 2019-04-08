Dado "o portfólio possui 1 bloco de informação adicional" do
  create(:block, kind: :additional_information, side: :left, portfolio_id: @portfolio.id)
  # @additional_information = create(:additional_information, portfolio_id: @portfolio.id)
end

Quando "adiciona a informação adicional" do
  @additional_information = attributes_for(:additional_information)

  fill_in 'additional-information-title', with: @additional_information[:title]
  within_frame find("#cke_additional_information_description iframe") do
    find("body").base.send_keys @additional_information[:description]
  end

  find('body').click
  sleep(2)
end

Então "a informação adicional é adicionada" do
  @portfolio.reload
  expect(@portfolio.additional_information.title).to eql(@additional_information[:title])
  expect(@portfolio.additional_information.description).to eql("<p>#{@additional_information[:description]}My description</p>\n")
end