# syntax = docker/dockerfile:1

# Versão do ruby que será usada
FROM ruby:3.2.0

# Instalação de dependências
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y postgresql-client

# Configuração do BUNDLE_FROZEN
RUN bundle config --global frozen 1

# Criação do diretório de trabalho
WORKDIR /donates-time-api

# Cópia dos arquivos e instalação das gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Rodar o arquivo de entrypoint para deletar o server.pid
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Escutar porta 3000 e rodar o servidor
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
