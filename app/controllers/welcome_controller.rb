class WelcomeController < ApplicationController

  def index
    render 'devise/registrations/new'
  end

end
