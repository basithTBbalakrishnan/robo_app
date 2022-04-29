class Robot < ApplicationRecord
  
   def execute_commands(robot, commands)
    new_y_position = robot.y_position
    new_x_position = robot.x_position
    commands.each do |command|
      if command == 'MOVE' && robot.facing == 'NORTH'
        new_y_position += 1
        new_y_position.negative? || new_y_position > 10 ? new_y_position -= -1 : new_y_position
      elsif command == 'MOVE' && robot.facing == 'SOUTH'
        new_y_position -= 1
        new_y_position.negative? || new_y_position > 10 ? new_y_position += 1 : new_y_position
      elsif command == 'MOVE' && robot.facing == 'WEST'
        new_x_position -= 1
        new_x_position.negative? || new_x_position > 10 ? new_x_position += 1 : new_x_position
      elsif command == 'MOVE' && robot.facing == 'EAST'
        new_x_position += 1
        new_x_position.negative? || new_x_position > 10 ? new_x_position -= 1 : new_x_position
      elsif command == 'LEFT'
        if robot.facing == 'NORTH'
          robot.facing = 'WEST'
        elsif robot.facing == 'WEST'
          robot.facing = 'SOUTH'
        elsif robot.facing == 'SOUTH'
          robot.facing = 'EAST'
        elsif robot.facing == 'EAST'
          robot.facing = 'NORTH'
        end
      elsif command == 'RIGHT'
        if robot.facing == 'NORTH'
          robot.facing = 'EAST'
        elsif robot.facing == 'WEST'
          robot.facing = 'NORTH'
        elsif robot.facing == 'SOUTH'
          robot.facing = 'WEST'
        elsif robot.facing == 'EAST'
          robot.facing = 'SOUTH'
        end
      end
    end

    if (new_y_position.negative? || new_x_position.negative?) || (new_y_position > 10 || new_x_position > 10)
      false
    else
      robot.update_attributes(x_position: new_x_position, y_position: new_y_position, facing: robot.facing)
      true
    end
  end
  
end
