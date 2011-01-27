class BankAccount
  include Mongoid::Document

  field :bank_name,       :type => String
  field :account_number,  :type => String
  field :bank_id,         :type => String

  validates :bank_name,       :presence => true, :length => {:within => 2..40}, :company_name => true
  validates :account_number,  :presence => true, :length => {:within => 10..10}
  
  # embedded_in :courier, :inverse_of => :bank_account
  
  class << self
    def names
      ['Commerzbank', 'Sparkasse+', 'Mini bank', 'Big bank']
    end

    def make_account_number
      10.times.inject('') {|res, n| res << rand(10).to_s}
    end
    
    def create_random
      bank_account = BankAccount.new
      bank_account.bank_name      = names.pick_one
      bank_account.account_number = make_account_number
      bank_account.bank_id = 'DDR'
      bank_account      
    end
  end
end
