class SeedsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @seed = current_user.seeds.build(params[:seed])
    if @seed.save
      flash[:success] = "Seed created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @seed.destroy
    redirect_to root_url
  end

  def zone
    if params[:zone].present?
    @seeds = Seed.paginate(page: params[:page]).find(:all, :conditions => ['CAST(zone as TEXT) LIKE ?', params[:zone]])
    else
      @seeds = Seed.paginate(page: params[:page]).find(:all)
    end
  end

   private

    def correct_user
      @seed = current_user.seeds.find_by_id(params[:id])
      redirect_to root_url if @seed.nil?
    end
end