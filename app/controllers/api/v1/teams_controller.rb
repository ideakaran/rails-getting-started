class Api::V1::TeamsController < ApplicationController
  before_action :authorize
  before_action :set_game
  before_action :set_division
  before_action :set_team, only: %i[show update destroy]

  def index
    render json: is_admin ? Team.order('created_at DESC') : @user.teams.where("division_id = ?", params[:division_id])
    # render json: @division.teams
  end

  def show
    render json: @team
  end

  def create
    @team = Team.new(team_params.merge(division: @division, user: @user))

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
    @game = is_admin ? Game.find(params[:game_id]) : @user.games.find(params[:game_id])
  end


  def team_params
    params.permit(:name, :managerName, :managerContact)
  end
end