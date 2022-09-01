class Api::V1::DivisionsController < ApplicationController
  before_action :authorize
  before_action :set_game
  before_action :set_division, only: %i[show update destroy]
  
  def index
    render json: is_admin ? Division.order('created_at DESC') : @user.divisions.where("game_Id = ?", params[:game_id])
  end

  def show
    render json: @division
  end
  
  def create
    @division = Division.new(division_params.merge(game: @game, user: @user))
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
    # @division = @user.divisions.find_by!(id: params[:id]) if @game
    puts "Is admin:: #{is_admin}"
    @division = is_admin ? Division.find(params[:id]) : @user.divisions.find(params[:id])
  end

  def set_game
    @game = is_admin ? Game.find(params[:game_id]) : @user.games.find(params[:game_id])
  end


  def division_params
    params.permit(:name)
  end
end