require 'vault'
require 'dotenv'

Dotenv.load

def vault_connector
  config = {
    address: 'http://54.227.105.83:8200' #url de vault
  }

  client = Vault::Client.new(config)
  if client
    puts "Conexión exitosa"
  else 
    puts "No se pudo conectar"
  end

  options = {
    # token: ENV['git_token']  //usar este metodo
    token: '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'
  }

  response = client.logical.write('auth/github/login', options)
  client.token = response.auth.client_token

  client
end

# Método que luego de conectarse a vault retorna los secretos generales
def general_secrets_by_environment(environment)
  client = vault_connector()

  path = "#{environment}/data/general"

  secrets = client.logical.read(path)

  return secrets.data.to_json if secrets

  nil #Si no hay secreto nil
end

# obtiene y retorna los secretos para un proyecto en específico.
def secrets_by_project(environment, project)
  client = vault_connector

  path = "#{environment}/data/#{project}"

  secrets = client.logical.read(path)
  return secrets.data if secrets

  nil
end

#  obtiene y retorna el valor de una key
def get_secret_value(secrets, key)
  value = secrets.dig('data', key)
  return value if value

  puts "Error obtaining secret value: #{key}"
  nil
end

# Accede a secretos generales
secrets = general_secrets_by_environment('development')
puts secrets.to_json
