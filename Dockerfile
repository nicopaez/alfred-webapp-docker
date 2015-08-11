FROM ruby:1.9.3

RUN mkdir -p /var/www
WORKDIR /var/www

ENV PADRINO_ENV production

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc |  apt-key add -
RUN apt-get update && apt-get install -y libpq5 libpq-dev postgresql-server-dev-9.3 git
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/fiuba/alfred.git /var/www/alfred

WORKDIR /var/www/alfred

RUN git checkout docker

RUN bundle install --system --without test development

EXPOSE 3000

CMD ["padrino", "start", "-h=0.0.0.0"]