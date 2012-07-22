Sc2News::Application.routes.draw do
  devise_for :users

  resources :articles, :only => [:index, :show]

  match "articles/tag/:by_tag" => "articles#index", :as => :tag_articles

  resources :chat_messages, :only => [:index, :create]

  resources :users


  root :to => 'articles#index'
end
