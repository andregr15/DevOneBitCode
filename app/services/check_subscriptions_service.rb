class CheckSubscriptionsService
  def call
    Order.where(status: :active).each do |order|
      if order.due_date <= Time.now
        order.update(status: :inactive)
        order.portfolio.update(featured: false)
      end

      if order.due_date - 3.days <= Time.now
        PremiumExpirationMailer.with({
          user: order.portfolio.user,
          portfolio: order.portfolio,
          order: order
        }).notify.deliver_later
      end
    end
  end
end
