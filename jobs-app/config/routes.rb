Rails.application.routes.draw do
  resources :listings
  resources :bookings
  resources :reservations

  resources :missions, only: [:index] do
    collection do
      post 'generate' => 'missions#generate'
    end
  end
end
