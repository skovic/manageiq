module Api
  class PhysicalServersController < BaseController
    include Subcollections::Firmwares
  
    def show
      if params[:c_id]
        physical_server = PhysicalServer.find(params[:c_id])
        response_payload = physical_server.as_json
        firmwares = physical_server.firmwares.map(&:as_json)
        response_payload["firmwares"] = firmwares
        response_payload["host_id"] = case physical_server.host
                                      when nil then nil
                                      else physical_server.host.id
                                      end

        render json: response_payload
      else
        super
      end
    end

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

