module Api
  class PhysicalServersController < BaseController
    def turn_on_loc_led_resource(server)
      task_id = queue_object_action(server, desc, :method_name => "turn_on_loc_led", :role => "ems_operations")
      action_result(true, desc, :task_id => task_id)
      rescue => err
        action_result(false, err.to_s)
    end

    def turn_off_loc_led_resource(server)
      task_id = queue_object_action(server, desc, :method_name => "turn_off_loc_led", :role => "ems_operations")
      action_result(true, desc, :task_id => task_id)
      rescue => err
        action_result(false, err.to_s)
    end
  end
end