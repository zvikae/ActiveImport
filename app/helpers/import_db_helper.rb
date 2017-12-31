module ImportDbHelper
  require 'csv'
  def self.import_person_create
    start_time = Time.zone.now
    csv = File.read('users.csv')
    CSV.parse(csv, headers: true).each do |row|
      User.create(row.to_h)
    end
    end_time = Time.zone.now
    ap 'import_person_create ran: ' + ((end_time - start_time).round(2)).to_s + ' second!'
  end
end