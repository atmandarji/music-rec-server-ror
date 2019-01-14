Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'user/login'
  post 'user/signup'
  get 'user/search'
  get 'user/history'
  delete 'user/history'
end
