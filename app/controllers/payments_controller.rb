class PaymentsController < ApplicationController
  before_action :set_portfolio

  def index
    @order = @portfolio.order
  end

  private

  def set_portfolio
    @portfolio = Portflio.where(id: params[:id], user_id: current_user.id).first
    redirect_to portfolios_path unless @portfolio.present?
  end
end
