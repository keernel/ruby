# -*- encoding : utf-8 -*-
require_relative "../boot"

# Create Payment Request.
#
# You need to set your PagSeguro::ApplicationCredentials (APP_ID, APP_KEY) in
# the application config.
#
# P.S: See the boot file example for more details.

payment = PagSeguro::PaymentRequest.new
payment.abandon_url = "http://example.com/?abandoned"
payment.notification_url = "http://example.com/?notification"
payment.redirect_url = "http://example.com/?redirect"

# if you don't want use the application config, can give your credentials object to payment request
#
payment.credentials = PagSeguro::AccountCredentials.new('bbbbbbbbbb@gmail.com', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')

payment.items << {
  id: 1234,
  description: %[Televisão 19" Sony],
  amount: 459.50,
  weight: 0
}

payment.reference = "REF1235"
payment.sender = {
  name: "John Galt",
  email: "bbbbbbbbbb@gmail.com",
  cpf: "99999999999",
  phone: {
    area_code: 86,
    number: "888888888"
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
