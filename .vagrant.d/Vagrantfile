Vagrant::Config.run do |config|
  config.vm.share_folder "v-dotfiles", "/home/vagrant/.dotfiles", File.expand_path("~/.dotfiles")
  config.vm.provision :shell, :path => File.join(File.dirname(__FILE__), "scripts", "provision")
end
