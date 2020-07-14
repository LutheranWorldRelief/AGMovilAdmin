class Api::V1::NotificationsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_notification, only: [:show]

  def save_token
    if ud = UserDevice.find_by(token: params[:token])
      msg = "Token ya existe"
    else
      ud = UserDevice.create!(token: params[:token])
      
      msg = "Token creado"
    end
    render json: {token: ud.token, message: msg}
  end
  def index
    if MassiveNotification.where(status:"sended").count > 0 
      @nt = MassiveNotification.where(status: "sended").order(created_at: :desc).map do |notimassive|
        { 
          :id => notimassive.id, 
          :title => notimassive.title,
          :message => notimassive.message.truncate(27)
        }
      end
    else
      @nt = "No se encontraron resultados"
    end
    render json: { notifications: @nt }.to_json
  end

  def show    
    notification = []
    notification << {"id": @notification.id, "title": @notification.title, "message": @notification.message, "image": @notification.big_picture.present? ? "https://admin.cacaomovil.com#{@notification.big_picture.url}" : "" , "date": @notification.created_at.strftime("%d-%m-%Y")}
    render json: {notification: notification}.to_json
  end

  private

    def set_notification
      @notification = MassiveNotification.find(params[:id])
    end

end
