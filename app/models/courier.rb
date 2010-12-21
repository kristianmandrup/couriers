class Courier < ServiceProvider
  include Mongoid::Document

  embeds_one :person 
  
  field :nick_name,  :type => String
end

{
  username: 'mike',
  password: 'xxxxx',  
  language: 'de',

  person: {
    first_name: 'mike',
    last_name: 'loehr',
    address: {
      street: 'sfsfsa 133',
      zip: 12345,
      city: 'Munchen',
      country: 'Germany'
    }

    profile: {
      description: 'sdgdsgdgs',
      webpage_url: 'sdgsdg',
      avatar: 'assf.jpg'
    }
  },    
        
  bank_account: {
    
  },
  price_structure: {
    
  },

  vehicles: [
    { name: Bicycle, count: 2},
    { name: Car, count: 1}
  ]    
}

