class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  skip_before_filter :blocked_relationships?
  def create
      # move specific user creation to a method on the User model
    auth = request.env['omniauth.auth']
    puts auth
    user = User.from_omniauth(auth) # this method creates a user
    user.create_player_items unless user.has_items?
    sign_in user
    redirect_to controller: :users, action: :show, id: user.id
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
