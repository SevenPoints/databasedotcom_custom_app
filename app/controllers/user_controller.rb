class UserController < ApplicationController
  include Databasedotcom::Rails::Controller
  def index
    @users = User.all
  end

  def new
  end

  def create
  end
end
