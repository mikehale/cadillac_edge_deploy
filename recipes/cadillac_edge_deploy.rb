namespace :deploy do 
  task :cadillac_edge do
    run "cd #{latest_release} && rake cadillac_edge_deploy"
  end
end

after  "deploy:update_code", "deploy:cadillac_edge"
