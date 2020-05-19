class Api::V1::NotificationsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token, if: :save_token

  #skip_before_action :verify_authenticity_token

  #def send
    #AAAArGmGj_s:APA91bGIqfV6s3WUnXT1zS__8NRWjjyE8SkDFfjfIDsAGTafJpax3t7SwmYmI_ZnxB9Y-jR2vV3dQvZng1ALvXZCSxaWO9mBJ2omC2SrAls0zU4v2oHl3CxJSI_p4SnMbowXh2sPnR3x
  #end

  def save_token
    if ud = UserDevice.find_by(token: params[:token])
      msg = "Token ya existe"
    else
      ud = UserDevice.create!(token: params[:token])
      
      msg = "Token creado"
    end
    render json: {token: ud.token, message: msg}
  end

end