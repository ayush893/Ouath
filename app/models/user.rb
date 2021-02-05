class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:omniauthable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"],:uid => access_token.uid).first
    # if user

    #   token = JsonWebToken.encode(uid: access_token.uid)
    #   time = Time.now + 24.hours.to_i
    
    # else
    #   render json: { error: 'unauthorized' }, status: :unauthorized
    # end
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data["name"],
           email: data["email"],
           uid: access_token.uid,
           provider: access_token.provider,
           password: Devise.friendly_token[0,20]
        )
    end
    user
end
end
