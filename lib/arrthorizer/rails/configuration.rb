require 'yaml'

module Arrthorizer
  module Rails
    class Configuration
      FileNotFound = Class.new(Arrthorizer::ArrthorizerException)

      mattr_accessor :config_file
      self.config_file = "config/arrthorizer.yml"

      def self.load
        Parser.new.process(config)
      end

    private
      def self.config
        @config ||= YAML.load(config_file_contents) || {}
      end

      def self.config_file_contents
        File.read(config_file_location)
      rescue Errno::ENOENT
        message = "Arrthorizer requires a config file at #{config_file}"
        if ::Rails.env.development?
          puts "WARNING: #{message}"
          return ""
        else
          raise FileNotFound, message
        end
      end

      def self.config_file_location
        ::Rails.root.join config_file
      end

      class Parser
        def process(config)
          config.each_pair do |privilege_name, configuration|
            parse_privilege_node(privilege_name, OpenStruct.new(configuration))
          end
        end

      private
        def parse_privilege_node(name, description)
          privilege = Arrthorizer::Privilege.new(name: name, roles: roles_from(description))

          description.actions.each do |node|
            controller_name = controller_from(node)

            actions_from(node, controller_name).each do |action|
              action.privilege = privilege
            end
          end
        end

        # node looks like this: { "actions" => { "controller_name" => ["namespaced/action_name"] }, roles: [ "Namespaced::Role" ] }
        def roles_from(node)
          (node.roles || []).map(&:constantize)
        end

        # node looks like this: { "controller_name" => ["namespaced/action_name", "another_action_name"] }
        def controller_from(node)
          node.keys.first
        end

        # node looks like this: { "controller_name" => ["namespaced/action_name", "another_action_name"] }
        def actions_from(node, controller_name)
          node[controller_name].map do |action_name|
            Arrthorizer::Rails::ControllerAction.new(controller: controller_name, action: action_name)
          end
        end
      end
    end
  end
end
