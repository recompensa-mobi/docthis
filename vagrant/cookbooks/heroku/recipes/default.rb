# Cookbook Name: heroku
# Recipe: default

execute "install heroku toolbelt" do
  command "wget -qO- https://toolbelt.heroku.com/install.sh | sh"
  action :run
  not_if { ::File.exists?("/usr/local/heroku/bin/heroku") }
end

file "/etc/profile.d/heroku.sh" do
  content 'PATH="/usr/local/heroku/bin:$PATH"'
  action :create_if_missing
end

