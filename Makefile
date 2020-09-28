.PHONY: all


clean:
	vagrant destroy -f

destroy: clean

build: clean
	vagrant up

pause:
	vagrant suspend

resume:
	vagrant resume
	sleep 5
	scripts/reDeployUserInfra.sh

deploy:
	scripts/reDeployUserInfra.sh

