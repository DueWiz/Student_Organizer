Rails.application.routes.draw do

  get 'latte/info'

  post 'latte/create'

  delete 'latte/destroy'

  get 'homework/result'

  get 'group/search'

  get 'group/:id' => 'group#show', as: :groupshow

  get 'user_homework/index'

  get 'group/index'

  get 'group/new'

  get 'group/edit'

  controller :group do
    post 'group/create' => :create
    post 'group/join' => :join
  end
  get 'group/create'
  get 'group/update'
  get 'group/join'

  get 'group/destroy'

  root to: "homework#index"
  get 'homework' => 'homework#index'
  # resources :homework
  #
  get 'homework/:id' => 'homework#show', as: :homeworkshow
  get 'homework/new'

  get 'homework/:id/edit' => 'homework#edit', as: :homeworkedit
  get 'homework/:id/update' => 'homework#update', as: :homeworkupdate
  controller :homework do
    post 'homework/create' => :create
  end
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
  #mount ActionCable.server => '/cable'
end
