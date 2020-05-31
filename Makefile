.PHONY: all

clear:
	vagrant destroy -f

build: clear
	vagrant up

