RandRuby::Application.routes.draw do
  match "graphing/hist"=>"graphing#hist"
  match "graphing/volcano"=>"graphing#volcano"
  match "cluster/individual"=>"cluster#individual"
  match "cluster/group"=>"cluster#group"
end
