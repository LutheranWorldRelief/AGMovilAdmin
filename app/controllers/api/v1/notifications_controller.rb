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
    user_key = params[:token]
    rnc = ReadNotification.where(user_key: user_key).count rescue 0
    delete_notifications = DeleteNotification.where(user_key: user_key).pluck(:notification_id)
    @nt = []
    count = 0
    @ntx = ""
    if MassiveNotification.where(status:"sended").count > 0 
      MassiveNotification.where(status: "sended").order(created_at: :desc).each do |notimassive|
        unless delete_notifications.include?(notimassive.id)
          @nt << { :id => notimassive.id, :title => notimassive.title, :message => notimassive.message.truncate(27) }
        end
      end
    else
      @ntx = "No se encontraron resultados"
    end
    count = (@nt.count - rnc) rescue 0
    render json: { notifications: (@nt.count > 0 ? @nt : @ntx), count: count }.to_json
  end

  def delete_notification
    user_key = params[:token]
    notification_id = params[:notification_id]
    message = ""
    unless DeleteNotification.where(user_key: user_key, notification_id: notification_id).count > 0
      DeleteNotification.create!(user_key: user_key, notification_id: notification_id)
      message = "Has eliminado la notificación exitosamente"
    else
      message = "Ha sucedido un error, por favor ponte en contacto con soporte. Error #206"
    end
    
    render json: {notification: notification_id, message: message}
  end

  def show    
    notification = []
    user_key = params[:token]
    notification << {"id": @notification.id, "title": @notification.title, "message": @notification.message, "image": @notification.big_picture.present? ? "https://admin.cacaomovil.com#{@notification.big_picture.url}" : "" , "date": @notification.created_at.strftime("%d-%m-%Y")}
    ReadNotification.create(user_key: user_key, notification_id: @notification_id)
    render json: {notification: notification}.to_json
  end

  private

    def set_notification
      @notification = MassiveNotification.find(params[:id])
    end

end
