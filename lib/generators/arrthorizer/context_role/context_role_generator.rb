class Arrthorizer::ContextRoleGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_role
    template "role.rb", "app/roles/#{name}.rb"
  end
end
