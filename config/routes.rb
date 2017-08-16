Rails.application.routes.draw do
  root to: 'scan#index'
  post '/upload', to: 'scan#upload'
end
