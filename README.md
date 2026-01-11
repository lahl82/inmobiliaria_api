# Inmobiliaria API (Rails)

## Descripción
Backend API desarrollado en Ruby on Rails (7.1.x).
Es consumido por el frontend Angular mediante proxy en desarrollo
y reverse proxy en Docker / Nginx.

---

## Ejecución en desarrollo (sin Docker)

### Levantar servidor local

    rails s

Salida típica:
- Listening on http://127.0.0.1:3001
- Listening on http://[::1]:3001

Rails escucha solo en localhost, lo cual es correcto mientras el frontend
consuma la API mediante el proxy del dev-server de Angular.

---

## Exponer la API a la red (opcional)

Solo si necesitas acceder a la API desde otro dispositivo
(ej. Postman en el celular):

    bin/rails s -b 0.0.0.0 -p 3001

Acceso desde LAN:
- http://192.168.2.103:3001

---

## Ejecución con Docker

### Dockerfile
- Imagen base: ruby:3.2.2
- Instala postgresql-client y utilidades de red
- Bundler versión 2.5.6
- Puerto expuesto: 3000
- Usa entrypoint.sh

### entrypoint.sh
Flujo de ejecución:
1. Elimina tmp/pids/server.pid
2. Espera PostgreSQL (db-host:5432)
3. Ejecuta rails db:create
4. Ejecuta rails db:migrate
5. Arranca Rails con rails server -b 0.0.0.0

Nota:
- El host de la base de datos está hardcodeado como db-host
  (alias definido en docker-compose.yml).

---

## Puertos

Desarrollo:
- Rails: 127.0.0.1:3001

Docker:
- Rails: backend-host:3000

---

## Nota sobre producción

El stack completo en Docker fue probado en AWS y resultó muy lento.
Se decidió ejecutar Rails, Nginx y PostgreSQL directamente en el host,
obteniendo mejor rendimiento.
