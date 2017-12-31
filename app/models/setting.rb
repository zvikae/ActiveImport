class Setting < ApplicationRecord
  def self.get_value(key)
    setting = Setting.find_by_key(key)
    return (setting.nil? ? nil : setting.value)
  end

  def self.version
    version = Setting.get_value('VERSION')
    return version.nil? ? '0.0.0' : version
  end

  def self.to_boolean(val = nil)
    return false if val.nil?
    t = val =~ /^(true|t)$/i
    return false if t.nil?
    return true if t.zero?
    return false
  end
end
