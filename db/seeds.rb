# frozen_string_literal: true

puts "Criando usuário administrador..."
User.find_or_create_by!(email: "admin@sigel.com") do |user|
  user.nome = "Administrador"
  user.cpf = "00000000000"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = "admin"
end
puts "Usuário admin criado: admin@sigel.com / password123"

puts "\nCriando tipos de veículos..."
tipos = [
  "Automóvel",
  "Motocicleta",
  "Caminhão",
  "Ônibus",
  "Van",
  "Utilitário",
  "Reboque",
  "Trator"
]

tipos.each do |descricao|
  GTipoVeiculo.find_or_create_by!(descricao: descricao)
  puts "  - #{descricao}"
end

puts "\nCriando veículos de exemplo..."
tipo_automovel = GTipoVeiculo.find_by(descricao: "Automóvel")
tipo_moto = GTipoVeiculo.find_by(descricao: "Motocicleta")
tipo_caminhao = GTipoVeiculo.find_by(descricao: "Caminhão")

veiculos = [
  { numero_interno: "V001", placa: "ABC1234", chassi: "9BWZZZ377VT004251", renavam: "12345678901", marca: "Volkswagen", modelo: "Gol", ano: 2020, cor: "Branco", motor: "1.0 Flex", status: "pendente", apto: false, g_tipo_veiculo: tipo_automovel },
  { numero_interno: "V002", placa: "DEF5678", chassi: "9BWZZZ377VT004252", renavam: "12345678902", marca: "Fiat", modelo: "Uno", ano: 2019, cor: "Prata", motor: "1.0 Flex", status: "verificado_apto", apto: true, g_tipo_veiculo: tipo_automovel },
  { numero_interno: "V003", placa: "GHI9012", chassi: "9BWZZZ377VT004253", renavam: "12345678903", marca: "Honda", modelo: "CG 160", ano: 2021, cor: "Vermelho", motor: "160cc", status: "em_leilao", apto: true, g_tipo_veiculo: tipo_moto },
  { numero_interno: "V004", placa: "JKL3456", chassi: "9BWZZZ377VT004254", renavam: "12345678904", marca: "Yamaha", modelo: "Factor 150", ano: 2020, cor: "Preto", motor: "150cc", status: "arrematado", apto: true, g_tipo_veiculo: tipo_moto },
  { numero_interno: "V005", placa: "MNO7890", chassi: "9BWZZZ377VT004255", renavam: "12345678905", marca: "Chevrolet", modelo: "Onix", ano: 2022, cor: "Azul", motor: "1.0 Turbo", status: "impedido", apto: false, g_tipo_veiculo: tipo_automovel },
  { numero_interno: "V006", placa: "PQR1234", chassi: "9BWZZZ377VT004256", renavam: "12345678906", marca: "Mercedes-Benz", modelo: "Atego 1719", ano: 2018, cor: "Branco", motor: "Diesel", status: "pendente", apto: false, g_tipo_veiculo: tipo_caminhao }
]

veiculos.each do |attrs|
  GVeiculo.find_or_create_by!(placa: attrs[:placa]) do |v|
    v.assign_attributes(attrs)
  end
  puts "  - #{attrs[:marca]} #{attrs[:modelo]} (#{attrs[:placa]})"
end

puts "\nSeed concluído!"
puts "Total de tipos de veículos: #{GTipoVeiculo.count}"
puts "Total de veículos: #{GVeiculo.count}"
puts "Total de usuários: #{User.count}"
