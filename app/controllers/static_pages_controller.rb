class StaticPagesController < ApplicationController
  def home
    redirect_to "/introduction" unless has_logged?
  end
end
