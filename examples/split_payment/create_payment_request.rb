require_relative "../boot"

# Create Split Payment.
#
# You need to set your ApplicationCredentials (EMAIL, TOKEN) in the application
# config.
#
# P.S: See the boot file example for more details.

payment = PagSeguro::PaymentRequest.new
payment.abandon_url = "http://example.com/?abandoned"
payment.notification_url = "http://example.com/?notification"
payment.redirect_url = "http://example.com/?redirect"

# If you don't want to use the application config, can give your credentials
# object to payment request.

payment.credentials = PagSeguro::ApplicationCredentials.new(
  'xxxxxxxxxxxxx',
  'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
  'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
)

payment.items << {
  id: 1234,
  description: %[Televisão 19" Sony],
  quantity: 1,
  amount: 459.50,
  weight: 0
}

payment.receivers = [
  {
    email: 'aaaaaaaaaaaaaaaaaaaaa@sandbox.pagseguro.com.br',
    split: { amount: '400.00', },
  },
  {
    email: 'bbbbbbbbbb@gmail.com',
    split: { amount: '59.50', },
  }
]

payment.reference = "REF1234"
payment.sender = {
  name: "John Galt",
  email: "bbbbbbbbbb@gmail.com",
  cpf: "21639716866",
  phone: {
    area_code: 11,
    number: "12345678"
  }
}

payment.shipping = {
  type_name: "sedex",
  address: {
    street: "R. Vergueiro",
    number: 1421,
    complement: "Sala 213",
    city: "São Paulo",
    state: "SP",
    district: "Vila Mariana"
  }
}

# Add extras params to request
# payment.extra_params << { paramName: 'paramValue' }
# payment.extra_params << { senderBirthDate: '07/05/1981' }
# payment.extra_params << { extraAmount: '-15.00' }

puts "=> REQUEST"
puts PagSeguro::PaymentRequest::RequestSerializer.new(payment).to_params

response = payment.register

puts
puts "=> RESPONSE"
puts response.url
puts response.code
puts response.created_at
puts response.errors.to_a
