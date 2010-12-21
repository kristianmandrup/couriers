class BankAccount
  include Mongoid::Document

  field :bank_name,       :type => String
  field :account_number,  :type => String
  field :bank_id,         :type => String
  
  embedded_in :service_provider, :inverse_of => :bank_account
end
