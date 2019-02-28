class CreatePortfolioTags < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolio_tags do |t|
      t.references :portfolio
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
