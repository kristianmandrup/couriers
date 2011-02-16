module BankAccountExt
  module ClassMethods
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