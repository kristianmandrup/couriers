class Courier < User
  module Scopes
    scope :by_number, lambda { |number| where(:number => number) }

    # For the backend, retrieves all accounts that are pending
    scope :pending, :where => {:account_state => 'pending'}  
  end
end