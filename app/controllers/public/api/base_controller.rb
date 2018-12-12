module Public
  module Api
    class BaseController < ::ApplicationController
      def render_success(message = nil)
        resp = {success: true, message: message}
        render({body: Oj.dump(resp), layout: 'api_layout.json'})
      end

      def render_error(error)
        resp = {success: false, message: error}
        render({body: Oj.dump(resp), layout: 'api_layout.json'})
      end
    end
  end
end