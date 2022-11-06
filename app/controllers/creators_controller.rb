class CreatorsController < ApplicationController
  before_action :set_creator, only: [:show]

  # GET /creators
  def index

    if params[:sort] && params[:sort_direction] || params[:limit] || params[:offset]
      @creators = Creator.build_query(params)
    else
      @creators = Creator.all
    end

    render json: @creators
  end

  def show
    render json: @creator
  end

  def create
    @creator = Creator.new(creator_params)

    if @creator.save
      render json: @creator.except, status: :created, location: @creator
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
