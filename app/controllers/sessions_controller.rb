class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)
    if @user.user_items.empty?
      @items = @user.create_player_items(@user.steam_id)
      # create item_id_if_not_exist, if exists, then return, make it indempotent
      # put flag on db on the user, put false by default, everytime you scan user items, put to true
      # code should be in the model, not the controller
      # create if_not_exist_method
    end
      redirect_to controller: :users, action: :show, id: @user.id
      #  need to refactor
  end
end
