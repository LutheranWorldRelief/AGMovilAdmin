class Admin::MassiveNotificationsController < Admin::ApplicationController
	before_action :set_massive_notification, only: [:edit, :update, :move_draft, :move_trash, :destroy, :sent_notification, :destroy_imagen]
	
	def index
			@title = "Borradores"
			@massive_notifications = MassiveNotification.where(status: :draft)
		if params[:sent].present?
			@massive_notifications = MassiveNotification.where(status: :sended)
			@title = "Enviados"
		end
		if params[:trash].present?
			@title = "Papelera"
			@massive_notifications = MassiveNotification.where(status: :trashed)
		end
	end

	def new
		@massive_notification = MassiveNotification.new
	end

	def create
		@massive_notification = MassiveNotification.new(massive_notification_params)
		if @massive_notification.save
			redirect_to edit_admin_massive_notification_path(@massive_notification), notice: "Registro guardado"
		else
			render :new
			flash[:alert] = "Ocurrio un error"
		end
	end

	def edit
		@send = false
		@ready_customers = []
		customers = UserDevice.all
		customers.each do |customer|	
			@ready_customers << customer.token
		end

		if @massive_notification.validates_form
			@send = true
		end

		unless @massive_notification.draft?
			redirect_to users_massive_notifications_path
		end
	end

	def update
		if @massive_notification.update(massive_notification_params)
			if @massive_notification.save
				redirect_to edit_admin_massive_notification_path(@massive_notification), notice: "Configuración guardada"
			end
		else
			render :edit
			flash[:alert] = "Ocurrio un error"
		end
	end

	def sent_notification
		@ready_customers = []
		customers = UserDevice.all
		customers.each do |customer|	
			@ready_customers << customer.token
		end
		fcm_client = FCM.new("AAAArGmGj_s:APA91bGIqfV6s3WUnXT1zS__8NRWjjyE8SkDFfjfIDsAGTafJpax3t7SwmYmI_ZnxB9Y-jR2vV3dQvZng1ALvXZCSxaWO9mBJ2omC2SrAls0zU4v2oHl3CxJSI_p4SnMbowXh2sPnR3x") # set your FCM_SERVER_KEY
    options = { priority: 'high',
                data: { message: @massive_notification.title, icon: @massive_notification.big_picture.present? ? "#{Rails.root}"+ @massive_notification.big_picture.url : "" },
                notification: { 
                title: @massive_notification.title,
                body: @massive_notification.message,
                image: @massive_notification.big_picture.present? ? "#{Rails.root}"+ @massive_notification.big_picture.url : "" ,
                icon: @massive_notification.big_picture.present? ? "#{Rails.root}"+ @massive_notification.big_picture.url : "" 
                },
                badge: 1,
                sound: 'default'
              }
    @ready_customers.each_slice(20) do |registration_id|
        response = fcm_client.send(registration_id, options)
        puts response
        @massive_notification.update(status:"sended")
        redirect_to admin_massive_notifications_path, notice: "Registro enviados"
    end
	end

	def move_draft
		if @massive_notification.draft!
			redirect_to edit_admin_massive_notification_path(@massive_notification)
		else
			redirect_to admin_massive_notifications_path(sent: true), notice: "Ocurrio un error"
		end
	end

	def destroy_imagen
		@massive_notification.remove_big_picture!
		@massive_notification.save
		redirect_to edit_admin_massive_notification_path(@massive_notification)
	end

	def move_trash
		if @massive_notification.trashed!
			redirect_to admin_massive_notifications_path, notice: "Registro enviado a la papelera"
		else
			redirect_to admin_massive_notifications_path, notice: "Ocurrio un error"
		end
	end

	def destroy
		if @massive_notification.destroy
			redirect_to admin_massive_notifications_path(trash: true), notice: "Registro eliminado"
		else
			redirect_to admin_massive_notifications_path(trash: true), notice: "Ocurrio un error"
		end
	end

	private

		def massive_notification_params
			params.require(:massive_notification).permit(:big_picture, :message, :title, :status, :players => [])
			#params.require(:massive_notification).permit(:big_picture, :message, :title, :status)
		end

		def set_massive_notification
			@massive_notification = MassiveNotification.find(params[:id])
		end
end
