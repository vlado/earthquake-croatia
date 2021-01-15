# Earthquake Croatia web application

This application allows citizens to offer and request help in areas affected by
earthquake and possibly other hazardous situations. It is currently hosted at
[potres.herokuapp.com](http://potres.herokuapp.com/)

![Screenshot](doc/img/screenshot.png)

## Json API

### /api/ads

Returns ads with pagination details in headers (`Link`, `Per-Page`, `Total`). This follows the proposed [RFC-8288](https://tools.ietf.org/html/rfc8288) standard for Web linking.

Available params (all params are optional):

| Param name | Allowed values | Default | Example |
| page | Integer gt 0 | 1 | https://www.potres-petrinja.hr/api/ads?page=2 |
| per_page | Integer 20 <= i <= 100 | 20 | https://www.potres-petrinja.hr/api/ads?per_page=50 |
| kind | `supply` or `demand` | - | https://www.potres-petrinja.hr/api/ads?kind=demand |
| category | `accomodation`, `transport`, `repairs`, `medical_assistance`, `other`, `building_material`, `kids`, `diet_and_hygiene`, `furniture_and_household`, `clothes_and_shoes` | - | https://www.potres-petrinja.hr/api/ads?category=accomodation |

## How to contribute

If you want to contribute, please check out our issues tab, see if anything is
approved and comment on that issue so we know someone is working on it. If you
have a recommendation - please raise a new issue, tag it accordingly
with enhancment and bug labels.

## Things to keep in mind

We need the UI to be responsive since this app is heavily used on mobile phones.

## Environment setup

### Make it simple

```bash
# Build the container
make build

# Create, migrate and seed the database
make db-create

# Start the server
make server
```

### Docker Compose

```bash
# Generate Docker bundle
docker-compose build

# Start Docker containers
docker-compose up

# In another console run
docker-compose run web rails db:create
docker-compose run web rails db:migrate
docker-compose run web rails webpacker:install

```

### Local installation

#### Ruby setup

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
source ${HOME}/.rvm/scripts/rvm
```

#### System dependencies

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

#### [optional] Add dummy data

```bash
rails db:seed
```

#### Run server

```bash
bin/rails server
bin/webpack-dev-server
```

or if you use foreman

```bash
foreman start -f Procfile.dev
```

#### Tests

First set up the test database with:
```bash
RAILS_ENV=test bin/rails db:setup
```
Note that this will also seed it with data from `db/seed.rb`.

And then run with
```bash
rspec
```

If you want to see the system tests running in visible chrome run it with:
```bash
HEADLESS=false rspec
```

## Statement

This application is an open-source humanitarian project where everyone can participate and contribute. The sole purpose of this application is to help earthquake victims in the areas of Glina, Sisak, Petrinja, and surrounding villages and settlements.

The app’s function serves as an advertisement platform among those who offer and seek help in areas affected by the earthquake. The use of this application is completely free, and ads can be placed by any citizen of the Republic of Croatia, the European Union, and neighboring countries.

The web application project was made in collaboration with several software engineers and experts, who voluntarily participated in the creation, maintenance, and upgrade of this application.
