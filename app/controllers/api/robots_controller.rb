class Api::RobotsController < ApplicationController
  
  before_action :authenticate_user
  
  def index
    all_robots = Robot.all
    render json: all_robots 
  end
  
  def show
    robot = Robot.find(params[:id])
    render json: robot  
  end
  
  def create
   if Robot.new(robot_params).save
    render json: "Robot Created successfully"
   else
    rendet json: "Errot accured"
   end
  end  
  
  def update   
  end

  def destroy
  end
  
  def commands
    robot = Robot.find(params[:id])
    placing_bot = params[:commands].first.split(' ')
    do_the_robot_placement
  end
  
  def do_the_robot_placement
   (placing_bot.first == 'PLACE') ? place_the_robot : throw_placing_error_messeage
  end
  
  def place_the_robot
    moving_coordinates = placing_bot.second.split(',')
    check_robot_placement_actions   
    (moving_coordinates.first.to_i.negative? || moving_coordinates.second.to_i.negative?) ? throw_placement_falling_error : proceed_robot_postion_placement
  end
  
  def throw_placement_falling_error
    render json: { error: 'Cannot place bot on falling position', status: 400 }, status: 400
  end
  
  def proceed_robot_postion_placement
    robot.update_attributes(x_position: moving_coordinates.first.to_i,y_position: moving_coordinates.second.to_i,
    facing: moving_coordinates.last)
    params[:commands].shift
    execute = Robot.new.execute_commands(robot, params[:commands])
    if execute == true && params[:commands].last == 'REPORT'
      render json: { location: [robot.x_position, robot.y_position, robot.facing] }, status: 200
    elsif execute == false
      render json: { error: 'Bot will fall off cannot execute these commands', status: 400 }, status: 400
    end
  end
  
  def throw_placing_error_messeage
    render json: { error: 'Please give the place command before moving the bot', status: 400 }, status: 400
  end
  
  private 
  
  def robot_params
    params.require(:robot).permit(:commands,:x_position,:y_position,:facing)
  end
  
end
