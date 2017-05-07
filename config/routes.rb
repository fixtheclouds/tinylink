Rails.application.routes.draw do

  get 'home/index'

  root 'home#index'

  resources :links

  get ':short_url' => 'links#redirect'

end
