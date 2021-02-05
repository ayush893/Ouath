
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
	user = User.find_for_google_oauth2(request.env['omniauth.auth'],current_user)
	if user.persisted?
		sign_in_and_redirect user, event: :authentication
		#render json: user
		#render_bind json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     #name: data["name"] }, status: :ok
	else
		#render "There was an error while trying to authenticate you..."
		redirect_to new_admin_session_path
	end

	end
end