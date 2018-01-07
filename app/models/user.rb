class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true

  
  after_commit :transaction_success
  after_rollback :transaction_failed

  def self.transfer_money
    ActiveRecord::Base.transaction do
      david.update!(money: david.money + 200)
      mark.update!(money: mark.money - 200)
    end
  end

  private
  def transaction_success
    Logger.info "Transfer succeed for User #{self.email}"
  end

  def transaction_failed
    Logger.error "Transfer failed for User #{self.email}"
  end

  
end