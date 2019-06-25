# pass extras variables
args=

install:
	shards install

docker.run:
	docker-compose up $(args)

docker.down:
	docker-compose down $(args)

init.dev: rebuild-sentry

rebuild-sentry:
	curl -fsSLo- https://raw.githubusercontent.com/samueleaton/sentry/master/install.cr | crystal eval