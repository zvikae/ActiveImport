module ImportDbHelper
  require 'csv'
  def self.import_users_create
    start_time = Time.zone.now
    csv = File.read('users.csv')
    CSV.parse(csv, headers: true).each do |row|
      User.create(row.to_h)
    end
    end_time = Time.zone.now
    ap 'import_users_create ran: ' + ((end_time - start_time).round(2)).to_s + ' second!'
  end

  def self.import_users_bulk_with_validate
    start_time = Time.zone.now
    csv = File.read('users.csv')
    users = []
    CSV.parse(csv, headers: true).each do |row|
      users << User.new(row.to_h)
    end
    User.import(users)
    end_time = Time.zone.now
    ap 'import_users_bulk ran: ' + ((end_time - start_time).round(2)).to_s + ' second!'
  end

  def self.import_users_bulk_without_validate
    start_time = Time.zone.now
    csv = File.read('users.csv')
    users = []
    CSV.parse(csv, headers: true).each do |row|
      users << User.new(row.to_h)
    end
    User.import(users, validate: false)
    end_time = Time.zone.now
    ap 'import_users_bulk ran: ' + ((end_time - start_time).round(2)).to_s + ' second!'
  end
end