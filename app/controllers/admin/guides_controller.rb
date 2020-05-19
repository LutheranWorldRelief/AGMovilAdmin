class Admin::GuidesController < Admin::ApplicationController
	before_action :set_guide, only: [ :show, :edit, :update, :destroy, :update_order_section ]
	def index
		@active_item_2 = true
		@guides = Guide.all.order(order: :asc).paginate(:page => params[:page], :per_page => 10)
	end

	def new
		@guide = Guide.new
	end

	def create
		@guide = Guide.new(guide_params)
		if @guide.save
			redirect_to admin_guides_path, notice: "Guardado..."
		else
			redirect_to admin_guides_path, alert: "Ocurrio un error..."
		end
	end

	def edit
	end

	def update
		if @guide.update(guide_params)
			redirect_to admin_guides_path, notice: "Actualizado..."
		else
			redirect_to admin_guides_path, alert: "Ocurrio un error..."
		end
	end

	def destroy
		if @guide.destroy
			redirect_to admin_guides_path, notice: "Eliminado..."
		else
			redirect_to admin_guides_path, alert: "Ocurrio un error..."
		end
	end

	def show
		@active_item_2 = true
	end

	def update_order_section
		if params[:order].present?
			jsonArray = JSON.parse(params[:order])
			@guide.sections.order(order: :asc).each_with_index do |section, index|
				section.order = jsonArray[index]['id']
				section.save
			end
		end

		redirect_to admin_guide_path(@guide), notice: "Actualizado..."
	end

	private

		def set_guide
			@guide = Guide.friendly.find(params[:id])
		end

		def guide_params
			params.require(:guide).permit(:name, :order, :category_id, :image)
		end
end