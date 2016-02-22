
ScreeningLog::Application.routes.draw do
  resources :screenings

  resources :directors

  resources :films

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
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

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
