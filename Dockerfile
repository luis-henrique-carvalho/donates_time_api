# syntax = docker/dockerfile:1

# Versão do Ruby que será usada
FROM ruby:3.2.2

# Instalação de dependências
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    postgresql-client \
    graphviz \
    && rm -rf /var/lib/apt/lists/* # Limpa o cache do apt para reduzir o tamanho da imagem

# Configuração do BUNDLE_FROZEN
RUN bundle config --global frozen 1

# Criação do diretório de trabalho
WORKDIR /donates-time-api

# Cópia do Gemfile e instalação das gems (em duas etapas para otimizar o cache)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Cópia do restante do código
COPY . .

# Rodar o arquivo de entrypoint para deletar o server.pid
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Escutar porta 3001 e rodar o servidor
EXPOSE 3001
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
