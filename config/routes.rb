Sc2News::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users

  resources :articles do
    resources :comments, only: [:create, :update, :destroy]
  end

  match "articles/tag/:by_tag" => "articles#index", :as => :tag_articles

  resources :chat_messages, :only => [:index, :create]

  resources :users


  root :to => 'articles#index'
end
