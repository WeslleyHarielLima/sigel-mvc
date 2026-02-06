json.extract! g_veiculo, :id, :numero_interno, :placa, :chassi, :renavam, :marca, :modelo, :ano, :cor, :motor, :tombamento, :g_status_veiculo_id, :created_at, :updated_at
json.url g_veiculo_url(g_veiculo, format: :json)
