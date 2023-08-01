require 'vault'
require 'dotenv'

Dotenv.load

def vault_connector(environment, git_token)

  config = {
    address: (environment ? 'http://54.227.105.83:8080' : 'http://vault.api.bsale.com'),
    token: git_token
    # token: ENV['git_token']
  }

  client = Vault::Client.new(config)
  if client
    puts "Conexión exitosa"
  else 
    puts "No se pudo conectar"
  end
  puts "AA;: #{config}"
  response = client.logical.write('auth/github/login', config)
  client.token = response.auth.client_token
  client
end

# Método que luego de conectarse a vault retorna los secretos generales
def general_secrets_by_environment(environment, git_token)
  client = vault_connector(environment, git_token)
  path = "#{environment}/data/general"
  secrets = client.logical.read(path).data.to_json
end

# obtiene y retorna los secretos para un proyecto en específico.
def secrets_by_project(environment, project)
  client = vault_connector(environment)
  path = "#{environment}/data/#{project}"
  secrets = client.logical.read(path).data.to_json
end

#  obtiene y retorna el valor de una key especifica
# def get_secret_value(secrets, key)
#   value = secrets.dig('data', key)
#   return value if value
#   puts "Error obtaining secret value: #{key}"
#   nil
# end

# Accede a secretos generales
# secrets = general_secrets_by_environment('development')
# puts secrets.to_json

# secretsByProject = secrets_by_project('development', 'bquery_api')
# puts secretsByProject