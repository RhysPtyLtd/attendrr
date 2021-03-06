class FollowersController < ApplicationController
  before_action :set_follower, only: [:show, :edit, :update, :destroy]
  before_action :admin_club, only: [:index, :show, :edit, :update, :destroy]


  # GET /followers
  # GET /followers.json
  def index
    @followers = Follower.all
  end

  # GET /followers/1
  # GET /followers/1.json
  def show
  end

  # GET /followers/new
  def new
    @follower = Follower.new
  end

  # GET /followers/1/edit
  def edit
  end

  # POST /followers
  # POST /followers.json
  def create
    @follower = Follower.new(follower_params)

      if @follower.save
        FollowerMailer.follower_alert.deliver_now
        flash[:success] = "Subscription successful. Welcome to the club."
        redirect_to blog_posts_path
      else
        render 'new'
      end
  end

  # PATCH/PUT /followers/1
  # PATCH/PUT /followers/1.json
  def update
    respond_to do |format|
      if @follower.update(follower_params)
        format.html { redirect_to @follower, notice: 'Follower was successfully updated.' }
        format.json { render :show, status: :ok, location: @follower }
      else
        format.html { render :edit }
        format.json { render json: @follower.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followers/1
  # DELETE /followers/1.json
  def destroy
    @follower.destroy
    respond_to do |format|
      format.html { redirect_to followers_url, notice: 'Follower was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Confirms admin
    def admin_club
      redirect_to(root_url) unless current_club && current_club.admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_follower
      @follower = Follower.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follower_params
      params.require(:follower).permit(:name, :email, :active)
    end
end
