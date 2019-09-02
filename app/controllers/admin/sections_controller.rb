class Admin::SectionsController < Admin::ApplicationController
	before_action :set_section, only: [ :show, :edit, :update, :destroy, :update_order_article ]
	def index
		@active_item_3 = true
		@sections = Section.all.order(guide_id: :asc).paginate(:page => params[:page], :per_page => 10)
		if params[:filter].present?
			if params[:filter][:guide].present?
				@sections = @sections.where(guide_id: params[:filter][:guide].to_i)
			end
		end
	end

	def new
		@section = Section.new
	end

	def create
		@section = Section.new(section_params)
		if @section.save
			redirect_to admin_sections_path, notice: "Guardado..."
		else
			redirect_to admin_sections_path, alert: "Ocurrio un error..."
		end
	end

	def edit
	end

	def update
		if @section.update(section_params)
			redirect_to admin_sections_path, notice: "Actualizado..."
		else
			redirect_to admin_sections_path, alert: "Ocurrio un error..."
		end
	end

	def destroy
		if @section.destroy
			redirect_to admin_sections_path, notice: "Eliminado..."
		else
			redirect_to admin_sections_path, alert: "Ocurrio un error..."
		end
	end

	def show
		@active_item_3 = true
	end

	def update_order_article
		if params[:order].present?
			jsonArray = JSON.parse(params[:order])
			@section.articles.order(order: :asc).each_with_index do |article, index|
				article.order = jsonArray[index]['id']
				article.save
			end
		end
		redirect_to admin_section_path(@section), notice: "Actualizado..."
	end

	private

		def set_section
			@section = Section.friendly.find(params[:id])
		end

		def section_params
			params.require(:section).permit(:name, :order, :guide_id)
		end
end