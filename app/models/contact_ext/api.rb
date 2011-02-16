module ContactExt
  module Api
    def for_json
      {:name => full_name, :phone => channel.phone, :company_name => 'Flowers4u'} #:email => channel.email
    end
  end
end