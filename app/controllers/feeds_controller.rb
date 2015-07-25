class FeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    @feeds = Feed.search_by_user(current_user)
  end
end
