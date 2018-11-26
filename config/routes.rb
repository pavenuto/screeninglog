
ScreeningLog::Application.routes.draw do
  resources :screenings
  resources :directors
  resources :films

  root 'screenings#recent'

  get 'screenings/year/:year' => 'screenings#year', as: 'screening_year'

  get 'films/year/:year' => 'films#year', as: 'year'
  get 'films-by-rating/:rating' => 'films#rating', as: 'rating'
  get 'films/year/:year/:type' => 'films#year', as: 'year_grid'
  get '/recent' => 'screenings#recent', as: 'recent'

  get '/search' => 'films#search'

  get '/top-tens' => 'films#toptens', as: 'top_tens'
  get '/decades' => 'films#decades', as: 'decades'
  get '/top-100' => 'films#top100', as: 'top_100'
  get '/worst' => 'films#worst', as: 'worst'
  get '/top-100/:type' => 'films#top100', as: 'top_100_grid'
  get '/no-directors' => 'films#no_directors', as: 'no_directors'

  get '/visualized' => 'screenings#visualized', as: 'visualized'

  get '/all' => "films#all", as: 'all'

  get '/no-images' => 'films#no_images', as: 'no_image'

end
