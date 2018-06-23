class SessionsController < ApplicationController
	def new
  	end

	#LOGIN METHOD
	
	def create
		#check if user exists
    	user = User.find_by(email: params[:session][:email].downcase)
			#params[:session][:email] = given email for user
    	if user && user.authenticate(params[:session][:password])
				#params[:session][:password] = given password for user
    	  # Log in the user
    	  log_in(user)
				#Redirect to the user's show page
    	  redirect_to user_url(user)
    	else
      	# Create an error message
      	flash[:danger] = 'Invalid email/password combination'
				#new form
      	render 'new'
    end
end

	def destroy
		#method in sessions_helper
		log_out
		#return home
		redirect_to root_url
  	end
end
