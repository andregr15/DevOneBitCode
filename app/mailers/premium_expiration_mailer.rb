class PremiumExpirationMailer < ApplicationMailer
  default from: 'dev@onebitcode.com'

  def notify
    @user = params[:user]
    @portfolio = params[:portfolio]
    @order = params[:order]
    
    mail(
      to: @user.email,
      subject: 'Seu premium vai expirar em breve'
    )
  end
end
