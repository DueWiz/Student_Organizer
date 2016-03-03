Rails.application.routes.draw do
  get 'homework/index'

  get 'homework/new'

  get 'homework/edit'

  get 'homework/create'

  get 'homework/update'

  get 'homework/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
