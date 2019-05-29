class Dashboard::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404", status: 404 unless current_user.role == 1
  end
end
