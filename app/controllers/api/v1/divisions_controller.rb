class Api::V1::DivisionsController < ApplicationController
  before_action :set_game
  before_action :set_division, only: %i[show update destroy]
  
  def index
    render json: @game.divisions
  end

  def show
    render json: @division
  end
  
  def create
    @division = Division.new(division_params)

    if @division.save
      render json: @division, status: :created
    else
      render json: @division.errors, status: :unprocessable_entity
    end
  end
  
  
  def update
    if @division.update(division_params)
      render json: @division
    else
      render json: @division.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @division.destroy
  end
  private


  def set_division
    @division = @game.divisions.find_by!(id: params[:id]) if @game
  end

  def set_game
    @game = Game.find(params[:game_id])
  end


  def division_params
    params.permit(:game_id, :name)
  end
end