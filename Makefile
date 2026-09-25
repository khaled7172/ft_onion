.PHONY: all build run stop clean hostname

NAME = ft_onion

all: build run

build:
	docker-compose build

run:
	docker-compose up -d
	@echo "Waiting for Tor to generate the hostname (usually takes a few seconds)..."
	@sleep 5
	@make hostname

hostname:
	@echo "=========================================================="
	@echo "Your Tor Hidden Service Address is:"
	@docker exec ft_onion_service cat /var/lib/tor/hidden_service/hostname || echo "Hostname not generated yet. Try again in a few seconds."
	@echo "=========================================================="

stop:
	docker-compose down

clean: stop
	docker system prune -f
	rm -rf hidden_service

re: clean all
