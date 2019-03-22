Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :portfolios, except: :new do
    resources :tags, only: %i[create destroy], param: :tag_id, controller: :portfolio_tags
    resources :blocks, only: %i[index create destroy]

    resources :profiles, only: %i[index update]
    resources :experiences, only: %i[index create destroy]
    resources :educations, only: %i[index create destroy]
  end

  resources :tags, only: :index
end
