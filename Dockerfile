FROM ruby:2.7.1

# Add yarn sources
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y \
        nodejs \
        postgresql-client \
        yarn

WORKDIR /potres-app

# Copy Gemfiles
COPY Gemfile /potres-app/Gemfile
COPY Gemfile.lock /potres-app/Gemfile.lock

# Install ruby dependecies
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
