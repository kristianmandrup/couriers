module CompanyExt
  module ClassMethods
    include ::OptionExtractor

    def names
      ['messenger', 'twister', 'courier AG']
    end
  
    def create_for options = {}
      company = Company.new 
      company.name    = names.pick_one
      company.contact = extract_contact options
      company.address = extract_address options
      company
    end
  end
end