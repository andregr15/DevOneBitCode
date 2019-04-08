class ContactsController < PortfolioResourcesController
  protected

  def load_portfolio_resources
    load_portfolio_resource
  end

  def load_portfolio_resource
    @portfolio.contact || @portfolio.create_contact(email: 'example@example.com', phone: '11 1111 11111')
  end

  def build_portfolio_resource
    @portfolio.build_contact
  end

  def portfolio_resource_params
    params.require(:contact).permit(:email, :phone, :website, :address_country, :address_city)
  end
end