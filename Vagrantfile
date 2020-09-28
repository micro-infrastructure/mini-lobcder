IMAGE_NAME = "bento/ubuntu-18.04"
N = 0

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"

		master.vm.provision "ansible" do |ansible|
            ansible.playbook = "k8s-setup/check-list-playbook.yml"
        end

        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "k8s-setup/master-playbook.yml"
            ansible.extra_vars = {
                node_ip: "192.168.50.10",
            }
        end
		master.vm.provision "ansible" do |ansible|
            ansible.playbook = "k8s-setup/dtn-playbook.yml"
        end
        
		master.vm.provision "ansible" do |ansible|
            ansible.playbook = "k8s-setup/core-playbook.yml"
        end
    end

	(1..N).each do |i|
		config.vm.define "node-#{i}" do |node|
			node.vm.box = IMAGE_NAME
			node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
			node.vm.hostname = "node-#{i}"
			node.vm.provision "ansible" do |ansible|
				ansible.playbook = "k8s-setup/node-playbook.yml"
				ansible.extra_vars = {
					node_ip: "192.168.50.#{i + 10}",
				}
			end

		end
	end

end
