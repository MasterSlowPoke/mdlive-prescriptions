class users::registrationsController < Devise::registrationsController
  def sign_up_params
    params.require(:user).permit(:name, email)
  end

  def account_update_params
    params.require(:user).permit(:name, email)
  end
end
