# db/seeds.rb

ActiveRecord::Base.transaction do
  puts "🌎 Criando país, estado e município..."

  pais = GPais.find_or_create_by!(descricao: "Brasil", sigla: "BR")

  estado = GEstado.find_or_create_by!(
    descricao: "Rondônia",
    uf: "RO",
    g_pais: pais
  )

  municipio = GMunicipio.find_or_create_by!(
    descricao: "Porto Velho",
    codigo_ibge: 1100205,
    g_estado: estado
  )

  puts "🏢 Criando status e órgão..."

  status_ativo = AStatus.find_or_create_by!(descricao: "Ativo")

  orgao = AOrgao.find_or_create_by!(descricao: "Prefeitura de Porto Velho")

  unidade = AUnidade.find_or_create_by!(
    nome_fantasia: "Secretaria de Transportes",
    a_orgao: orgao,
    a_status: status_ativo,
    g_municipio: municipio,
    cnpj: "00.000.000/0001-00",
    endereco: "Av. Sete de Setembro, 123",
    telefone: "(69) 99999-9999",
    codigo_interno: "SETRANS-PVH"
  )

  puts "👤 Criando tipos de usuário..."

  tipo_admin        = ATipoUsuario.find_or_create_by!(descricao: "admin")
  tipo_gerenciador  = ATipoUsuario.find_or_create_by!(descricao: "gerenciador")
  tipo_vistoriador  = ATipoUsuario.find_or_create_by!(descricao: "vistoriador")

  puts "🔐 Criando usuário admin..."

  user = User.find_or_initialize_by(email: "admin@gmail.com")
  user.assign_attributes(
    nome: "Administrador SIGEL",
    cpf: "00000000000",
    password: "123456",
    password_confirmation: "123456",
    role: "admin",
    a_unidade: unidade,
    a_tipo_usuario: tipo_admin,
    a_status: status_ativo
  )
  user.save!

  puts "✅ Seeds finalizados com sucesso!"
end
