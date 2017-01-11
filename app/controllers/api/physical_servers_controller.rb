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

   def turn_on_loc_led_resource(type, id, _data) 
      raise BadRequestError, "Must specify an id for turning on a #{type} resource" unless id  

      api_action(type, id) do |klass|
        server = resource_search(id, type, klass) 
        api_log_info("Turning on #{klass} #{server}")
        api_log_info("#{server_ident(server)}")
        desc = "Turn on Loc LED"
        task_id = queue_object_action(server, desc, :method_name => "turn_on_loc_led", :role => "ems_operations") 
        action_result(true, desc, :task_id => task_id) 
      end 
    end

    def turn_off_loc_led_resource(type, id, _data) 
      raise BadRequestError, "Must specify an id for turning off a #{type} resource" unless id  

      api_action(type, id) do |klass|
        server = resource_search(id, type, klass) 
        api_log_info("Turning off #{klass} #{server}")
        api_log_info("#{server_ident(server)}") 
        desc = "Turn off Loc LED"
        task_id = queue_object_action(server, desc, :method_name => "turn_off_loc_led", :role => "ems_operations") 
        action_result(true, desc, :task_id => task_id) 
      end 
    end

    private 

    def server_ident(server)
      "Server id:#{server.id} name:'#{server.name}'"
    end

  end
end
