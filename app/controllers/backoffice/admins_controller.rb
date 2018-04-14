class Backoffice::AdminsController < BackofficeController
  before_action :set_admin,only:[:edit,:update,:destroy]
  after_action :verify_authorized , only: :new
  after_action :verify_policy_scoped, only: :index
  def index
  	#@admins = Admin.all
    @admins = policy_scope(Admin)
  end

  def new
  	@admin = Admin.new
    authorize @admin
  end

  def edit
  end

  def create
  	@admin = Admin.new(params_admin)
  	if @admin.save
  		redirect_to backoffice_admins_path,notice: "Salvo com sucesso!"
  	else
  		render :new
  	end
  end

  def update
    
    if @admin.update(params_admin)
  		redirect_to backoffice_admins_path,notice: "Salvo com sucesso!"
  	else
  		render :new
  	end
  end

  def destroy
    admin_email = @admin.email
    if @admin.destroy
        redirect_to backoffice_admins_path,notice: "O Administrador #{admin_email} foi excluído com sucesso!"
    else
      render :index
    end
  end

  private

  def set_admin
  	@admin = Admin.find(params[:id])
  end 

  def params_admin
    passwd = params[:admin][:password]
    passwd_confirmation = params[:admin][:password_confirmation]
    
    if passwd.blank? && passwd_confirmation.blank?
      params[:admin].except!(:password,:password_confirmation)
    end
    
  	params.require(:admin).permit(policy(@admin).permitted_attributes)
  end
end
