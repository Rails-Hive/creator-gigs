class CreatorsController < ApplicationController
  before_action :authorize_request
  before_action :set_creator, only: [:show]

  def index

    if params[:sort] && params[:sort_direction] || params[:limit] || params[:offset]
      @creators = Creator.build_query(params)
    else
      @creators = Creator.all
    end
    
    render_response( CreatorSerializer,  @creators, 'Creators fetched successfully', 200, 'Success')
  end

  def show
    render_response( CreatorSerializer,  @creator, 'Creator fetched successfully', 200, 'Success')
  end

  def create
    # process_operation!(Creator::Operation::Create)
    @creator = Creator.new(creator_params)

    if @creator.save
      render_response( CreatorSerializer,  @creator, 'Creators saved successfully', 200, 'Success')
    else
      render json: ErrorSerializer.new(@creator.errors), status: :unprocessable_entity
    end
  end

  private

    def set_creator
      @creator = Creator.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      e = Errors::NotFound.new
      render json: ErrorSerializer.new(e), status: e.status
    end

    def creator_params
      params.permit(:first_name, :last_name)
    end
end
