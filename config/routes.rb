Docthis::Engine.routes.draw do
  get '/(*id)', to: "documentation#show", as: "documentation"
end
