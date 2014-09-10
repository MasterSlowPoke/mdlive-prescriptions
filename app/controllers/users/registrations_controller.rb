class Users::RegistrationsController < Devise::RegistrationsController
	def create
		super do |user|
			next unless user.persisted?
			UserMailer.welcome_email(user).deliver
		end
	end

	def sign_up_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def account_update_params
		params.require(:user).permit(:name, :email)
	end
end




