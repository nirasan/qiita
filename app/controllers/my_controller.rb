class MyController < ApplicationController
  before_action :authenticate_user!

  def index
    #TODO フィードの表示
  end
end
