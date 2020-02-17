class SessionsController < ApplicationController
  def show
    @clicked = params[:subject]
    @subjects = Subject.all
  end

  def index
  end

end
