class AuthController < ApplicationController
  rescue_from(ActiveRecord::RecordNotFound) do |e|
    render_error(:INVALID_ARGUMENT, e)
  end

  def create_user
    user = User.new(device_id: params.device_id, name: params.name)

    if user.save
      render_ok
    else
      render_error(:INVALID_ARGUMENT, user.errors)
    end
  end

  def create_session
    user = User.find_by!(device_id: params.device_id)

    session_token = SecureRandom.base64(13)

    user.update!(session_token: session_token)

    render_ok(session_token: session_token)
  end

  def login
    user = User.find_by!(session_token: params.session_token)

    render_ok(user_id: Protocol::UserId.new(value: user.user_id))
  end
end
