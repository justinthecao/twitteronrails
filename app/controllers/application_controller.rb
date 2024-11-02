class ApplicationController < ActionController::Base
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  private
  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end
