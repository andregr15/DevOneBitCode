module SearchPortfolioService
  class << self
    def call(options = {})
    @results = {}
    @filters = options
    perform_basic_search
    perform_featured_search
    @results
  end

  private

  def perform_basic_search
    @basic_search = Portfolio.where(listed: true, active: true)
    search_by_tag if @filter[:tag].present?
    search_by_place if @filter[:place].present?
    search_by_remote_ok if @filter[:remote_ok] == "1"
  end

  def search_by_tag
    @basic_search.joins!(:tags).where!(tags: { title: @filters[:tag] })
  end

  def search_by_place
    @basic_search.joins!(:contact).where!(
      "contacts.address_country = :place OR contacts.address.city = :place", 
      place: @filters[:place]
    )
  end

  def search_by_remote_ok
    @basic_search.where!(remote_ok: true)
  end

  def perform_featured_search
    @results[:featured] = @basic_search.where(featured: true).order("RANDOM()").limit(2)
    @results[:general] = @basic_search.where(featured: false).page(@filters[:page])
  end
end