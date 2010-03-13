module SprySoft
  module GridsHelper
    def has_grid(*options)
      options = options.extract_options!.stringify_keys
      params = ActionController::Routing::Route.new.build_query_string(options)
      grids_path(:css) + params
    end
  end
end