require 'fileutils'

class CadillacEdgeDeploy
  include FileUtils
  
  def deploy(rails_revision, release_path) 
    shared_path  = File.join(release_path, '../../shared')
    rails_path ||= File.join(shared_path, 'rails')

    @rails_revision = rails_revision
    @checkout_path = File.join(rails_path, 'trunk')
    @export_path = "#{rails_path}/rev_#{@rails_revision}"

    checkout_trunk
    export_revision
    link_export
  end
  
  
  private
    def checkout_trunk
      unless File.exists?(@checkout_path)
        puts 'setting up rails trunk'    
        system "svn co http://dev.rubyonrails.org/svn/rails/trunk #{@checkout_path} --quiet"
      end
    end
    
    def export_revision
      unless File.exists?(@export_path)
        puts "setting up rails rev #{@rails_revision}"
        system "svn up #{@checkout_path} -r #{@rails_revision} --quiet"
        system "svn export #{@checkout_path} #{@export_path}"
      end
    end

    def link_export
      symlink_path  = 'vendor/rails'
      puts 'linking rails'
      rm_rf   symlink_path

      ln_s File.expand_path(@export_path), symlink_path
      touch "vendor/rails_#{@rails_revision}"
    end
    
end

if ($0 == __FILE__)
  CadillacEdgeDeploy.new.deploy(*ARGV)
end