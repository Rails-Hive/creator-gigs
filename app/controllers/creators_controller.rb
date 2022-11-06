class CreatorsController < ApplicationController
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
    @creator = Creator.new(creator_params)

    if @creator.save
      render_response( CreatorSerializer,  @creator, 'Creators saved successfully', 200, 'Success')
    else
      render json: @creator.errors, status: :unprocessable_entity
    end
  end

  private

    def set_creator
      @creator = Creator.find(params[:id])
    end

    def creator_params
      params.require(:creator).permit(:first_name, :last_name)
    end
end
