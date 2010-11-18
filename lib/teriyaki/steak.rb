m = Module.new do
  Rails.application.routes.routes.map {|r| [r.name, r.path.sub(/\(\.:format\)$/, '')]}.uniq.each do |name, path|
    variables = path.scan(/:(.*?)(\/|$)/).map(&:first)
    variables.each do |v|
      path.sub! ":#{v}", '#{' + "#{v}.respond_to?(:to_key) ? #{v}.to_key : #{v}" + '}'
    end
    class_eval <<-ROUTE
    def #{name}_path(#{variables.join(', ')})
      "#{path}"
    end
ROUTE
  end
end

RSpec.configuration.include(m)
