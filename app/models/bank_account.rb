class BankAccount
  include Mongoid::Document

  field :bank_name,       :type => String
  field :account_number,  :type => String
  field :bank_id,         :type => String

  validates :bank_name,       :presence => true, :length => {:within => 2..40}, :company_name => true

  # validates :account_number,  :presence => true, :length => {:within => 10..10}, :account_number => true
  
  # embedded_in :service_provider, :inverse_of => :bank_account
end
