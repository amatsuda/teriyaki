ActiveSupport.on_load(:after_initialize) do
  RSpec.configuration.include Rails.application.routes.url_helpers, :type => :acceptance
end
