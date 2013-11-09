require "localization"

class Localization
  module Rails
    def action_localize
      control_local.send(action_name)
    end
    alias_method :action_local, :action_localize
    alias_method :view_localize, :action_localize

    def control_localize
      localize.send(controller_name)
    end
    alias_method :control_local, :control_localize

    def localize
      Localization.new.send(I18n.locale)
    end
  end

  if defined?(::Rails)
    class Railtie < ::Rails::Railtie
      initializer "localization_railtie.extend_action_controller" do
        ActionController::Base.send :include, Localization::Rails
        ActionController::Base.helper :localize
      end

      initializer "localization_railtie.set_localization_paths" do
        Localization.sources.push(Dir[File.join(Rails.root, "lib", "locale", "*.yml")])
      end
    end
  end
end
