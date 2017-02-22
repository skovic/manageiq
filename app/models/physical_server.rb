class PhysicalServer < ApplicationRecord
  include NewWithTypeStiMixin
  include_concern 'Operations'

  acts_as_miq_taggable

  belongs_to :ext_management_system, :foreign_key => :ems_id, :class_name => "ManageIQ::Providers::PhysicalInfraManager"

  default_value_for :enabled, true
  has_one :host, :foreign_key => "service_tag", :primary_key => "serial_number"

  def name_with_details
    details % {
      :name => name,
    }
  end

  def is_refreshable?
    refreshable_status[:show]
  end

  def is_refreshable_now?
    refreshable_status[:enabled]
  end

  def is_refreshable_now_error_message
    refreshable_status[:message]
  end

  def is_available?(_address)
    # TODO: (walteraa) remove bypass
    true
  end

  def smart?
    # TODO: (walteraa) remove bypass
    true
  end

  def my_zone
    ems = ext_management_system
    ems ? ems.my_zone : MiqServer.my_zone
  end
end
