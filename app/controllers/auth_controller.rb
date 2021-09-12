class AuthController < ApplicationController
  rescue_from(ActiveRecord::RecordNotFound) do |e|
    render_error(:INVALID_ARGUMENT, e)
  end

  def create_user
    resp = CreateUserUsecase.new.call(device_id: params.device_id, name: params.name)

    if resp.success?
      render_ok
    else
      render_error(:INVALID_ARGUMENT, resp.error)
    end
  end

  def create_session
    session_token = SecureRandom.base64(13)

    SpannerRecord.transaction do
      user = User.find_by!(device_id: params.device_id)
      user.update!(session_token: session_token)
    end

    render_ok(session_token: session_token)
  end

  def login
    user = User.find_by!(session_token: params.session_token)
    inventory = UserInventory.find_by_user_id(user.id)

    render_ok(
      user_id: Protocol::Core::UserId.new(value: user.user_id),
      user_inventory: UserInventorySerializer.new.serialize(inventory)
    )
  end
end
