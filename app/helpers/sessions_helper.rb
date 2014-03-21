module SessionsHelper

    def sign_in(user)
      cookies.permanent[:remember_token] = user.remember_token
      self.current_user = user
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end

    def current_user?(user)
      puts "we are in current user method"
      user == current_user
    end

    def signed_in?
      !current_user.nil?
    end

    def sign_out
      self.current_user = nil
      cookies.delete(:remember_token)
    end

    def signed_in_user
      unless signed_in?
        puts "signed_in_user_method"
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      if params[:user_id]
        @user = User.find(params[:user_id])
      else
        @user = User.find(params[:id])
      end
      redirect_to root_path unless current_user?(@user)
      # render :js => "window.location.pathname = '#{signin_path}'" unless current_user?(@user)
    end

    def find_item(item_id)
      Item.find_by_defindex(item_id.to_s)
    end
end
  