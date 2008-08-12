task :cadillac_edge_deploy do
  require "#{RAILS_ROOT}/config/rails_revision"
  require "#{RAILS_ROOT}/vendor/plugins/cadillac_edge_deploy/lib/cadillac_edge_deploy"
  CadillacEdgeDeploy.new.deploy(RAILS_REVISION, RAILS_ROOT)
end