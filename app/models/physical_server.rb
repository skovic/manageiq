class PhysicalServer < ApplicationRecord
  include NewWithTypeStiMixin

  include_concern 'Operations'

  acts_as_miq_taggable

  def name_with_details
    details % {
      :name => name,
    }
  end

  def my_zone 
    ems = ext_management_system 
    ems ? ems.my_zone : MiqServer.my_zone 
  end

end
