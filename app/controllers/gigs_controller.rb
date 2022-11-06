class GigsController < ApplicationController
  before_action :set_gig, only: [:show, :update]

  def index

    if params[:brand_name] || params[:creator] 
      @gigs = Gig.filter(params)
    else
     @gigs = Gig.all
    end

  end

  def show
    @relationship = params[:relationship]
  end

  def create
    @gig = Gig.new(gig_params)

    if @gig.save
      render json: @gig, status: :created, location: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  def update
    if @gig.update(gig_params)
      render json: @gig
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gig
      @gig = Gig.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gig_params
      params.require(:gig).permit(:brand_name, :state, :creator_id)
    end
end
