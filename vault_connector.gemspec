Gem::Specification.new do |spec|
    spec.name          = 'vault_connector'
    spec.version       = '0.0.1'
    spec.authors       = ['Infiniteam']
    spec.email         = ['srojo@imaginex.cl']

    spec.summary       = 'Permite a los miembros de Bsale acceder a los secretos de vault mediante el token de su github'
    spec.description   = 'Más detalles sobre tu gema'
    
    spec.files         = Dir['lib/**/*.rb']
    spec.require_paths = ['lib']
    spec.homepage      = 'https://github.com/SrojoA/bsale_vault_ruby'
    # spec.add_dependency 'vault'
end


#Esto asegurará que la versión de RubyGems requerida no tenga restricciones.
spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to?(:required_rubygems_version=)
