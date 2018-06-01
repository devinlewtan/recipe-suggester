module SessionsHelper
	#login given user
	def log_in(user)
    	session[:user_id] = user.id
	end
	
	#returns the current logged-in user (if any)
	def current_user
		if @current_user.nil?
			@current_user = User.find_by(id: session[:user_id])
		else
			@current_user
		end
	end
	
	#boolean for dif. user views 
	def logged_in?
    !current_user.nil?
  end
  
  # Logout current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
