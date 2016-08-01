class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
