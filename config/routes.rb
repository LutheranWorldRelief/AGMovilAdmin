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
    #resources :articles
    resources :articles do
      collection do
        post 'get_sections'
      end
    end
    resources :upload_files
    resources :apps
    resources :category_apps
    resources :categories
    resources :massive_notifications do 
      member do
        put "move_trash"
        put "move_draft"
        post "sent_notification"
        delete "destroy_imagen"
      end
    end
  end

  # API
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :notifications do
        collection do 
          post "send" => 'notifications#send'
          post "save_token" => 'notifications#save_token'
        end
      end
      resources :categories, only: [:index]
      resources :guides, only: [:show] do
        member do
          get "guide"
        end
      end
      resources :sections, only: [:show]
      resources :articles, only: [:show]
      resources :apps do 
        collection do 
          get 'cocoa_price' => 'apps#cocoa_price'
        end
      end
      resources :upload_files, only: [:show]
    end
  end
end
