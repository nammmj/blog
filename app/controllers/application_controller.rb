class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #load_and_authorize_resource # Authenticate with Gem Cancan
  helper_method :sort_column, :sort_direction
  
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end


  before_action :configure_permitted_parameters, if: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = "Access denied"
		redirect_to root_url
	end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :username
      devise_parameter_sanitizer.for(:account_update) << :username
      devise_parameter_sanitizer.for(:sign_up) << :role
    end

    def sort_column
      Post.column_names.include?(params[:sort]) ? params[:sort] : "created_at"      
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

end
