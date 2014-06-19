require "redcarpet"
require "pygmentize"

module Docthis
  class Engine < ::Rails::Engine
    isolate_namespace Docthis
  end
end
