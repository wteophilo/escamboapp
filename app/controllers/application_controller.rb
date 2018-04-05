class ApplicationController < ActionController::Base
  #set pundit
  include Pundit
  rescue_from Pundit::NotAuthorizedError,with: :user_not_authorized
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #set layout
  layout :layout_by_resource

  protected

  def user_not_authorized
    flash[:alert] = "Você não está autorizado..."
    redirect_to(request.referrer ||root_path)
    
  end
  
  def layout_by_resource
  	if devise_controller? && resource_name == :admin
  		"backoffice_devise"
  	else
  		"application"
  	end
  end
end
