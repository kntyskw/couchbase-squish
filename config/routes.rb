CouchbaseTinyurl::Application.routes.draw do
  resources :links do
    get :short, :on => :member
  end
  root :to => 'links#new'
  match "/:id", :to => 'links#short', :as => :short
end
