Rails.application.routes.draw do
  root 'bart#index'
  
  get '/getServiceAdvisories' => 'bart#get_advisories'
  get '/getTrainCount' => 'bart#get_train_count'
  get '/getElevatorStatus' => 'bart#get_elevator_status'
  
  get '/getEtd' => 'bart#get_etd'
  get '/getEtdFilter' => 'bart#get_etd_filter'
  
  get '/getRoutes' => 'bart#get_routes'
  get '/getRoutesInfo' => 'bart#get_routeinfo'
  
  get '/getArrivals' => 'bart#get_arrive'
  get '/getDepartures' => 'bart#get_depart'
  get '/getFares' => 'bart#get_fare'
  get '/getHolidays' => 'bart#get_holiday'
  get '/getLoad' => 'bart#get_load'
  get '/getRouteSchedules' => 'bart#get_route_schedule'
  get '/getSchedules' => 'bart#get_schedules'
  get '/getSpecialSchedules' => 'bart#get_special'
  get '/getStationSchedules' => 'bart#get_station_schedule'
  
  get '/getStations' => 'bart#get_station_info'
  get '/getStationInfo' => 'bart#get_station_access'
  get '/getStationAccess' => 'bart#get_station_list'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
