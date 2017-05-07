Rails.application.routes.draw do

  root 'home#index'

  resources :links

  get ':short_url' => 'links#redirect'

end
