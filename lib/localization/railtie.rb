require "localization"

class Localization
  module Rails
    def action_local
      control_local.send(action_name)
    end

    def control_local
      localize.send(controller_name)
    end

    def localize
      Localization.new.send(I18n.locale)
    end
  end

  class Railtie < ::Rails::Railtie
    initializer "localization_railtie.extend_action_controller" do
      ActionController::Base.send :include, Localization::Shortcut
      ActionController::Base.helper :localize
    end

    initializer "localization_railtie.set_localization_paths" do
      Localization.sources.push(Dir[File.join(Rails.root, "lib", "locale", "*.yml"))
    end
  end if defined?(Rails)
end
