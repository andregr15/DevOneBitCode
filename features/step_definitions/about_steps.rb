Dado "o portfólio possui um bloco de sobre mim" do
  create(:block, kind: :about, side: :left, portfolio_id: @portfolio.id)
  # create(:about, portfolio_id: @portfolio.id)
end

Quando "preenche a descrição sobre ele" do
  @about = attributes_for(:about)
  
  within_frame find("#cke_about_description iframe") do
    find('body').base.send_keys @about[:description]
  end

  page.execute_script <<-SCRIPT
      var ckeditor = CKEDITOR.instances.about_description
      ckeditor.focus()
      ckeditor.updateElement()
  SCRIPT
  #fill_in "about_description", visible: false, with: @about[:description]
  #page.execute_script("document.getElementsByClassName('ckeditor')[0].dispatchEvent(new Event('blur'));")
  # page.find(".page-footer").click
  wait_for_ajax
end

Então "a descrição sobre ele é adicionada ao portfólio" do
  wait_for_ajax
  @portfolio.reload
  expect(@portfolio.about.description).to eq(@about[:description])
end