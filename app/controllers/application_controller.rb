class ApplicationController < ActionController::Base
	after_filter :store_location

	def store_location
	 # store last url - this is needed for post-login redirect to whatever the user last visited.
	    if (request.fullpath != "/users/sign_in" && \
	        request.fullpath != "/users/sign_up" && \
	        request.fullpath != "/users/password" && \
	        !request.xhr?) # don't store ajax calls
	      session[:previous_url] = request.fullpath 
	    end
	end

	def after_sign_in_path_for(resource)
	  request.env['omniauth.origin'] || stored_location_for(resource) || root_path
	end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

end
