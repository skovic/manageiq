module PhysicalServer::Operations::Led

  # Start method will initiate the start_server method of 
  # provider manager for this PhysicalServer instance
  def raw_turn_on_loc_led
    via_provider(:start_server)
  end

  # Stop method will initiate the stop_server method of 
  # provider manager for this PhysicalServer instance
  def raw_turn_off_loc_led
    via_provider(:stop_server)
  end

  private
  
  # Locate the provider for this model instance and
  # send to requested action to it.
  def via_provider (verb)
    unless ext_management_system
      raise _("VM/Template <%{name}> with Id: <%{id}> is not associated with a provider.") % {:name => name, :id => id}
    end
    unless ext_management_system.authentication_status_ok?
      raise _("VM/Template <%{name}> with Id: <%{id}>: Provider authentication failed.") % {:name => name, :id => id}
    end

    _log.info("Invoking [#{verb}] through EMS: [#{ext_management_system.name}]")
    options = {:user_event => "Console Request Action [#{verb}], VM [#{name}]"}.merge(options)
    ext_management_system.send(verb, self, options)
  end

end