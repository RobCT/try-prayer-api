class Api::V1::RegistrationsController < Devise::RegistrationsController
  #skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    user = User.new(user_params)
    user_save = user.save
    user.generate_authentication_token!
    if user_save
      #sign_in user
      render json: user, status: 201, location: [:api, user]
      #sign_out user
      #render :status => 201,:json => { :success => true,:info => "Registered" }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => user.errors,
                        :data => {} }
    end
  end
      def user_params
      params.require(:user).permit(:email, :username, :firstname, :lastname, :password, :password_confirmation)
    end
end