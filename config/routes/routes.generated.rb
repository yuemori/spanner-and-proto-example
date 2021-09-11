Rails.application.routes.draw do
# Auth
  post "auth/create_user" => "auth#create_user"
  post "auth/create_session" => "auth#create_session"
  post "auth/login" => "auth#login"
end
