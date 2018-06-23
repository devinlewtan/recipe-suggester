module SessionsHelper

	#login given user
	def log_in(user)
			#this stores the user id up until session ends/browser closes
    	session[:user_id] = user.id
	end

	#returns the current logged-in user (if any)
	def current_user
		#stores current user in instance for first time login
		if @current_user.nil?
			@current_user = User.find_by(id: session[:user_id])
		else
			#returns current user that already logged in earlier in session
			@current_user
		end
	end

	#boolean for dif. user views
	def logged_in?
		#if current user exsists, display different header views
    !current_user.nil?
  end

  # Logout current user
  def log_out
		#removes user_id key from sessions hash
    session.delete(:user_id)
		#resets user to no one
    @current_user = nil
  end
end
