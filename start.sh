# install gems
bundle check || bundle install

# install js packages
yarn install

# runs server
bundle exec puma -C config/puma.rb