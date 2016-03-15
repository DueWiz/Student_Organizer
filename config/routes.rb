Rails.application.routes.draw do

  root to: "homework#index"

  get 'homework/index'

  get 'homework/new'

  get 'homework/edit'

  get 'homework/create'

  get 'homework/update'

  get 'homework/destroy'

  get 'welcome/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
