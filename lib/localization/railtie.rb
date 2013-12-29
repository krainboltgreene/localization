require "localization"

class Localization
  module Rails
    def action_local
      control_local.send(action_name)
    end
    alias_method :view_local, :action_local

    def control_local
      localization.send(controller_name)
    end

    def localization
      Localization.new.send(I18n.locale)
    end
  end

  if defined?(::Rails)
    class Railtie < ::Rails::Railtie
      initializer "localization_railtie.extend_action_controller" do
        ActionController::Base.send :include, Localization::Rails
        ActionController::Base.helper_method :view_local
        ActionController::Base.helper_method :action_local
        ActionController::Base.helper_method :control_local
        ActionController::Base.helper_method :localization
      end

      initializer "localization_railtie.set_localization_paths" do
        Localization.sources.push(*Dir[File.join(::Rails.root, "config", "locale", "*.yml")])
      end
    end
  end
end
