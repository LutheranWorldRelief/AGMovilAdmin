Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new"
	  get "/" => "devise/sessions#new"
	end

  namespace :admin do
  	resources :home, only: [:index, :edit, :update]
  	resources :guides do
      member do
        post "update_order_section"
      end
    end
    resources :sections do
      member do
        post "update_order_article"
      end
    end
    resources :articles
    resources :upload_files
    resources :apps
    resources :category_apps
    resources :categories
  end

  # API
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :categories, only: [:index]
      resources :guides, only: [:show] do
        member do
          get "guide"
        end
      end
      resources :sections, only: [:show]
      resources :articles, only: [:show]
      resources :apps, only: [:index]
      resources :upload_files, only: [:show]
    end
  end
end
