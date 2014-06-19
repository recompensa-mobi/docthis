require "docthis/engine"

# Gem entry point and configuration facilities for the DocThis! gem
module Docthis

  # Configures the DocThis! engine. You should pass a block receiving a
  # configuration object. You can use that configuration object to configure
  # the engine. For example:
  #
  # ```
  # Docthis.configure do |config|
  #   config.theme = :darkly
  # end
  # ```
  #
  # You can set the following options on the configuration object:
  #
  # * use_basic_auth: True if you want to protect the engine using basic auth.
  # Defaults to false.
  #
  # * basic_auth_username: Set to the username to validate against if using
  # basic auth. Defaults to nil.
  #
  # * basic_auth_password: Set to the password to validate against if using
  # basic auth. Defaults to nil.
  #
  # * docs_folder: Set to the relative path where the documentation files
  # reside. Defaults to "docs".
  #
  # * theme: Set to the stylesheet to apply to DocThis! pages. Can be anything
  # of the following bootswatch themes: amelia, cerulean, cosmo, cyborg,
  # darkly, flatly, journal, lumen, readable, simplex, slate, spacelab,
  # superhero, united, yeti. Defaults to simplex.
  def self.configure
    yield self
  end

  mattr_accessor :theme
  def self.theme
    @@theme ||= :simplex
  end

  mattr_accessor :docs_folder
  def self.docs_folder
    @@docs_folder ||= "docs"
  end

  mattr_accessor :use_basic_auth
  def self.use_basic_auth
    @@use_basic_auth.nil? ? false : @@use_basic_auth
  end

  mattr_accessor :basic_auth_username
  mattr_accessor :basic_auth_password
end
