class HomeController < ApplicationController
  before_filter :auth_user

  def index
  end
end
