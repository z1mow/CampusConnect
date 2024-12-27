class HomeController < ApplicationController
  
    def index
      @default_groups = CommunityGroup.where(default: true)
    end
  end