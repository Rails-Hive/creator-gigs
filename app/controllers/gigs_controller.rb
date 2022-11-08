class GigsController < ApplicationController
  before_action :authorize_request
  before_action :set_gig, only: [:show, :update]

  def index

    if params[:brand_name] || params[:creator] 
      @gigs = Gig.filter(params)
    else
     @gigs = Gig.all
    end
    
    render_response( GigSerializer, @gigs, 'Gigs list fetched successfully', 200, 'Success')
  end

  def show
    class_name = params[:relationship].present? ? GigWithPaymentSerializer : GigSerializer
    render_response( class_name, @gig, 'Gig fetched successfully', 200, 'Success')
  end

  def create
    @gig = Gig.new(gig_params)

    if @gig.save
      render_response( class_name, @gig, 'Gig saved successfully', 200, 'Created')
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  def update
    if @gig.update(gig_params)
      render_response( GigSerializer, @gig, 'Gig updated successfully', 200, 'Success')
    else
      render json: @gig.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gig
      @gig = Gig.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Gig not found' }, status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def gig_params
      params.require(:gig).permit(:brand_name, :state, :creator_id)
    end
end
