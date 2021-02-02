
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
	user = User.from_omniauth(request.env['omniauth.auth'],current_user)
	if user.persisted?
		render json: user
	else
		render "There was an error while trying to authenticate you..."

	end
end