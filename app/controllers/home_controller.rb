class HomeController < ApplicationController
  before_action :require_user
  
    def index
      @default_groups = CommunityGroup.where(default: true)
    end
  end