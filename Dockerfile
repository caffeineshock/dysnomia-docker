FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir -p /var/www/dysnomia
WORKDIR /var/www/dysnomia
ADD ./source/Gemfile /var/www/dysnomia/Gemfile
ADD ./source/Gemfile.lock /var/www/dysnomia/Gemfile.lock
RUN bundle config --global jobs 4
RUN bundle install
ADD ./source /var/www/dysnomia
RUN rake assets:precompile
RUN rake emoji
