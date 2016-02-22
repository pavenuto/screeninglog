class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def sort_to_most_recent_rating
    @films.sort! do |a,b|
      if a.last_rating == b.last_rating
        b.title <=> a.title
      else
        a.last_rating <=> b.last_rating
      end
    end.reverse!
  end
end
