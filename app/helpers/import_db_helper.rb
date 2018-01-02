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

  def self.import_users_bulk_sql
    start_time = Time.zone.now
    csv = File.read('users.csv')
    values = []
    CSV.parse(csv, headers: true).each do |row|
      values << "(#{row['first_name']}, #{row['last_name']}, #{row['age']})"
    end
    arr = values.join(", ")
    # # c = Student.count
    # sql = "INSERT INTO users (first_name, last_name, email, age, created_at, updated_at) VALUES #{values}"
    # # ActiveRecord::Base.connection.execute(sql)
    # insert into users (first_name, last_name, email, age, created_at, updated_at)
    # values ('aa', 'bb', 'zvi@dsd.com', 33, now(), now()),
    # ('a4', 'bb', 'zvi@dsd.com', 33, now(), now()),
    # ('65', 'bb', 'zvi@dsd.com', 33, now(), now()),
    # ('63', 'bb', 'zvi@dsd.com', 33, now(), now())

    end_time = Time.zone.now
    ap 'import_users_bulk ran: ' + ((end_time - start_time).round(2)).to_s + ' second!'
  end
end



