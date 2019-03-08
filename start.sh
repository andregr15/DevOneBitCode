# resolving linux problem
echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf && sysctl -p

# install gems
bundle check || bundle install

# install js packages
yarn install

# runs server
bundle exec puma -C config/puma.rb