class UsersController < Clearance::UsersController

  def new
    @user = User.new()
    render template: "users/new"
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private

  def avoid_sign_in
    warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
      "deprecated. Use `redirect_signed_in_users` instead. " +
      "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
      " or `skip_before_action :avoid_sign_in` as well"
    redirect_signed_in_users
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to Clearance.configuration.redirect_url
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  # def user_from_params
  #   email = user_params.delete(:email)
  #   password = user_params.delete(:password)

  #   Clearance.configuration.user_model.new(user_params).tap do |user|
  #     user.email = email
  #     user.password = password
  #   end
  # end

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :age, :email, :password)
  end
  # def user_params
  #   params[Clearance.configuration.user_parameter] || Hash.new
  # end
end


