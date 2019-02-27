FROM ruby:2.6.1-slim

# Instala nossas dependencias
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  build-essential libpq-dev imagemagick curl

# Instala o GNUPG
RUN apt-get install -y gnupg

# Instala NojeJs v8
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -\
  && apt-get install -y nodejs

# Instala o Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

# Seta nosso path
ENV INSTALL_PATH /app

# Cria o diretório
RUN mkdir -p $INSTALL_PATH

# Seta o path como diretório princial
WORKDIR $INSTALL_PATH

# Copia o nosso Gemfile para o container
COPY Gemfile ./

# Seta o path para as GEMS
ENV BUNDLE_PATH /gems

# Copia o nosso código para o container
COPY . .