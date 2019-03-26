module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        return false if @method != method
        # path.match(@path)
        path_match?(path)
      end

      private

      def path_match?(path)

        #такие названия, чтобы отличать запрашиваемый путь и путь в роуте
        get_path_array = path.split('/')
        route_path_array = @path.split('/')
        return false unless get_path_array.size == route_path_array.size
        params = {}

        route_path_array.each.with_index do |route_path_element, index|
          if route_path_element[0] == ':'
            params.merge!(route_path_element[1..-1].to_sym => get_path_array[index])
          else
            return false unless route_path_element == get_path_array[index]
          end
        end
        @params = params
      end
    end
  end
end
