FROM crystallang/crystal:0.29.0

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && apt-get install -y --no-install-recommends libpq-dev libreadline-dev curl

WORKDIR /usr/src/app/out/

COPY . .

RUN crystal build --warnings all --stats --progress --release -o bin/out app/out.cr
RUN crystal build --warnings all --stats --progress --release -o bin/jobs app/jobs.cr