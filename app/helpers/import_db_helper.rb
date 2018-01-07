module ImportDbHelper
  EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

  require 'csv'

  def self.create_users_duplicate_emails
    ActiveRecord::Base.transaction do
      begin
        User.create!(email: 'david@test.com', first_name: 'David', last_name: 'Concordia', age: 35)
        User.create!(email: 'david@test.com', first_name: 'Mark', last_name: 'Sharise', age: 45)
      rescue => error
        ap "Users didn't created. Rollback"
        # raise ActiveRecord::Rollback
      end
    end
  end

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
      if is_email_valid(row['email'])
        users << User.new(row.to_h)
      end
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
      if is_email_valid(row['email'])
        values << "('#{row['first_name']}', '#{row['last_name']}', '#{row['email']}', #{row['age']}, now(), now())"
      end
    end
    values_array = values.join(', ')
    sql = "INSERT INTO users (first_name, last_name, email, age, created_at, updated_at) VALUES #{values_array}"
    ActiveRecord::Base.connection.execute(sql)
    end_time = Time.zone.now
    ap 'import_users_bulk ran: ' + ((end_time - start_time).round(2)).to_s + ' second!'
  end

  def self.is_email_valid(email)
    return (email =~ EMAIL_REGEX).nil? ? false : true
  end

  def self.transfer_money
  ActiveRecord::Base.transaction do
    david.update!(money: david.money + 200)
    mark.update!(money: mark.money - 200)
    end
  end



end
