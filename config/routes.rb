ActionController::Routing::Routes.draw do |map|
  map.root :controller => :sessions, :action => :new
  map.resources :users
  map.resource :sessions
end
