class DetailLinksController < ApplicationController
  before_action :logged_in_user
  def new
    @detail_link= DetailLink.new
  end

  def create
    @detail_link = DetailLink.new params_detail_link
    if @detail_link.save
      @mes_success = 'Thanh cong'
    else
      @mes_fail = "That bai"
    end
  end

  private

  def params_detail_link
    params.require(:task).permit :name, :link, :subject_id
  end
end
