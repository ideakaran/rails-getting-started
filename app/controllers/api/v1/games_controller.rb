class Api::V1::GamesController < ApplicationController
  before_action :set_game, only: %i[show update destroy]
  def index
    games = Game.order('created_at DESC')
    #todo handle exception
    render json: {status: 'SUCCESS', message: 'All Games Loaded', data: games}, status: :ok
  end

  def show
    render json: @game
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      render json: {status: 'SUCCESS', message: 'Game Save Success', data: @game}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Game Save Fail', data: @game.errors}, status: :unprocessable_entity
    end
  end

  def update
    if @game.update(game_params)
      render json: {status: 'SUCCESS', message:'Game Update Success', data:@game},status: :ok
    else
      render json: {status: 'ERROR', message:'Game Update Fail', data:@game.errors},status: :unprocessable_entity
    end
  end

  def destroy
    @game.destroy
    render json: {status: 'SUCCESS', message:'Game Delete Success', data:@game},status: :ok
  end

  def divisions
    render json: @game.divisions
  end

  def set_game
    @game = Game.find(params[:id])
  end

  private
  def game_params
    params.permit(:name, :governingBody)
  end
end
