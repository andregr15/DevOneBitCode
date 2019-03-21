class PortfolioResourcePolicy < PortfolioPolicy
  def index?
    permmited_action?
  end
end
