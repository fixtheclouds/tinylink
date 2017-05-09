Rails.application.routes.draw do

  root 'links#new'

  resources :links

  get ':short_url' => 'links#redirect'

end
