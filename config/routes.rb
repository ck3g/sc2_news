Sc2News::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users

  resources :articles do
    put :restore, on: :member
    resources :comments, only: [:create, :update, :destroy]
  end

  get "articles/tag/:tagged_with" => "articles#index", :as => :tagged_articles

  resources :chat_messages, :only => [:index, :create]

  resources :users

  resources :tags, only: [:index, :edit, :update, :destroy]

  resources :pages, except: [:show]
  get "pages/:permalink" => "pages#show", as: :page

  root :to => 'articles#index'
end
