Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get "/movies/directed_by/:director" => "movies#directed_by", :as => :directed_by
end