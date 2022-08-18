class Api::V1::TeamsController < ApplicationController
  before_action :set_game
  before_action :set_division
  before_action :set_team, only: %i[show update destroy]

  def index
    render json: @division.teams
  end

  def show
    render json: @team
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      render json: @team, status: :created
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end


  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
  end
  private

  def set_team
    @team = @division.teams.find_by!(id: params[:id]) if @division
  end

  def set_division
    #have doubt on find
    @division = @game.divisions.find(params[:division_id]) if @game
  end

  def set_game
    @game = Game.find(params[:game_id])
  end


  def team_params
    params.permit(:division_id, :name, :managerName, :managerContact)
  end
end