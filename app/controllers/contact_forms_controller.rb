class ContactFormsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @user = @portfolio.user

    ContactFormMailer.with({
      user: @user,
      portfolio: @portfolio,
      email: params[:email],
      title: params[:title],
      description: params[:description]
    }).contact.deliver

    render json: :ok
  end
end
