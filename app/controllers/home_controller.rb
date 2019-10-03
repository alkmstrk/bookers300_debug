class HomeController < ApplicationController

  before_action :signin_user_check

  private

	  def signin_user_check
	  	if user_signed_in?
	    	redirect_to user_path(current_user)
	    end
	  end

end
