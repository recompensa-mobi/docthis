Docthis.configure do |config|
  config.use_basic_auth = true
  config.basic_auth_username = "internal"
  config.basic_auth_password = "password"

  config.docs_folder = "documentation"

  config.theme = :flatly
end
