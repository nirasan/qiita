class InfosController < ApplicationController
  before_action :authenticate_user!

  def index
    @infos = current_user.infos
  end

end
