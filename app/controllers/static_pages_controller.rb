class StaticPagesController < ApplicationController
  def home
    redirect_to "/introduction" unless user_signed_in?
  end
end
