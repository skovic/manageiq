module PhysicalServer::Operations::Led

  def turn_on_loc_led
    check_policy_prevent(:request_physical_server_turn_on_loc_led, :raw_turn_on_loc_led)
  end

  def turn_off_loc_led
    check_policy_prevent(:request_physical_server_turn_off_loc_led, :raw_turn_off_loc_led)
  end

end
