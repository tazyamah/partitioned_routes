class ActionController::Base
  cattr_accessor :routes_definitions
  def self.routes(subset=nil, &block)
    case subset
    when :resources
      resources_routes
    when :auto
      auto_routes
    else
      self.routes_definitions ||= {}
      self.routes_definitions[name] = block
    end
  end

  private

  def self.resources_routes
    fullname = name.underscore.match(/(.*)_controller/)[1]
    namespace = File.dirname fullname
    resource_name = File.basename fullname
    routes do |r|
      r.resources resource_name, :namespace => namespace
    end
  end

  def self.auto_routes
    fullname = name.underscore.match(/(.*)_controller/)[1]
    routes do |r|
      r.match "#{fullname}/:action", :controller => fullname
    end
  end
end

module PartitionedRoutes
  def self.define(route)
    require_all_controllers
    return unless ActionController::Base.routes_definitions
    route.instance_eval do
      ActionController::Base.routes_definitions.each do |controller_name, routes_definition|
        routes_definition.call(self)
      end
    end
  end

  private

  def self.require_all_controllers
    Dir.glob(File.join(Rails.root, 'app/controllers/')+'**/*_controller.rb').each do |path|
      require path
    end
  end
end

