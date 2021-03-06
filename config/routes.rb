Sc2News::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  # support of legacy routes
  get "/News" => redirect("/articles")
  get "/News/Details/:legacy_id" => "articles#show"
  get "/TagsCloud" => redirect("/tags")
  get "/Home/Jobs" => redirect("/pages/jobs")
  get "/Home/About" => redirect("/pages/about")
  get "/Account/Register" => redirect("/users/sign_up")
  get "/Account/PasswordReset" => redirect("/users/password/new")
  get "/Account/LogOn" => redirect("/users/sign_in")

  devise_for :users

  resources :articles do
    put :restore, on: :member
    resources :comments, only: [:create, :update, :destroy]
  end

  get "articles/tag/:tagged_with" => "articles#index", :as => :tagged_articles

  resources :chat_messages, :only => [:index, :create, :destroy]

  resources :users

  resources :tags, only: [:index, :edit, :update, :destroy]

  resources :pages, except: [:show]
  get "pages/:permalink" => "pages#show", as: :page_permalink

  resources :profiles, only: [:show, :edit, :update] do
    put :sync, on: :member
  end
  get "profile/:username" => "profiles#show", as: :user_profile
  get "Profile/:username" => "profiles#show"

  resources :our_friends

  resources :teams do
    put :leave, on: :member

    resources :members, only: [:index, :destroy]
  end

  resources :invites, only: [:index, :create] do
    put :accept, on: :member
    put :reject, on: :member
  end

  root :to => 'articles#index'
end
