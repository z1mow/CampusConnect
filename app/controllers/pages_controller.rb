class PagesController < ApplicationController
  def home
    if current_user
      @default_groups = CommunityGroup.where(default: true).order(:id).limit(4)
    else
      redirect_to login_path
    end
  end
end 