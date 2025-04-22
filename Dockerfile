# Usa una imagen base oficial de Ruby
FROM ruby:3.2.2

# Instala dependencias del sistema
RUN apt-get update -qq && apt-get install -y postgresql-client iputils-ping net-tools

# Instala la versión correcta de Bundler
RUN gem install bundler -v 2.5.6

# Copia el script de espera
COPY entrypoint.sh /usr/local/bin/

# Haz que el script sea ejecutable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Configura el directorio de trabajo
WORKDIR /app

# Copia el Gemfile y Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instala las gemas necesarias
RUN bundle _2.5.6_ install

# Copia el resto de la aplicación
COPY . .

# Copia las credenciales y la clave maestra
COPY config/credentials /app/config/credentials
COPY config/master.key /app/config/master.key

# Ejecuta las migraciones de la base de datos y luego inicia el servidor
# CMD ["wait-for-it.sh", "db:5432", "--", "sh", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0>

# Expone el puerto
EXPOSE 3000

# Ejecuta las migraciones de la base de datos y luego inicia el servidor
ENTRYPOINT ["entrypoint.sh"]
