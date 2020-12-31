# Potres-app

## How to contribute

If you want to contribute, please check out our issues tab, see if anything is
approved and comment on that issue so we know someone is working on it. If you
have a recommendation - please raise a new issue, tag it accordingly
with enhancment and bug labels.

## Things to keep in mind

We need the UI to be responsive since this app is heavily used on mobile phones.

## Environment setup

### Docker Compose

```bash
# Generate Docker bundle
docker-compose build

# Start Docker containers
docker-compose up

# In another console run
docker-compose run web rake db:create
docker-compose run web rake db:migrate
docker-compose run web rake webpacker:install

```

### Install Ruby

```bash
# Install gnupg
brew install gnupg

# Add rvm gpg key
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

# Pull latest rvm
\curl -sSL https://get.rvm.io | bash -s stable --ruby

# Install ruby 2.7.1
rvm install ruby-2.7.1

# Activate environment
source /Users/bvunder/.rvm/scripts/rvm
```

### Install dependencies

```bash
# On OSX install postgres and run server
brew install postgresql
brew services start postgresql

# Install dependencies
bundle install

# Initialize and migrate database
rails db:create
rails db:migrate

# Install webpack
rails webpacker:install
```

### Optionally add dummy data

```bash
rails db:seed
```

### Run server locally

```bash
rails s
```
