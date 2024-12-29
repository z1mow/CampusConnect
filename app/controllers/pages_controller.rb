class PagesController < ApplicationController
  before_action :require_user
    def home
      @default_groups = CommunityGroup.where(default: true)
    end
end 