## Pasos para correr el proyecto:

### 1. Clonar el proyecto del repositorio de GitHub
Abre la consola y ejecuta los siguientes comandos:

```
git clone https://github.com/Saadsito/meeteam-test.git
cd meeteam-test
```

---

### 2. Crear la base de datos en PostgreSQL
#### 2.1. Instalar PostgreSQL (si no está instalado)
##### En sistemas basados en Debian/Ubuntu:
```
sudo apt update
sudo apt install postgresql postgresql-contrib
```

##### En macOS:
Con Homebrew instalado, ejecuta:
```
brew install postgresql
brew services start postgresql
```

#### 2.2. Configurar PostgreSQL
Si necesitas configurar un usuario y base de datos para el proyecto, ejecuta:

```
sudo -u postgres psql
```

Dentro de la consola de PostgreSQL, ingresa estos comandos para crear el usuario y la base de datos:

```
CREATE USER meeteam_user WITH PASSWORD 'password123';
CREATE DATABASE meeteam_test OWNER meeteam_user;
GRANT ALL PRIVILEGES ON DATABASE meeteam_test TO meeteam_user;
\q
```

Asegúrate de que el archivo `config/database.yml` esté configurado con estos valores:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: meeteam_user
  password: password123
  host: localhost

development:
  <<: *default
  database: meeteam_test_development

test:
  <<: *default
  database: meeteam_test_test

production:
  <<: *default
  database: meeteam_test_production
```

---

### 3. Instalar las dependencias del proyecto
Asegúrate de tener Bundler instalado:

```
gem install bundler
```

Luego, instala las dependencias del proyecto:

```
bundle install
```

---

### 4. Crear y migrar la base de datos
Ejecuta los siguientes comandos para preparar la base de datos:

```
rails db:create
rails db:migrate
```

---

### 5. Ejecutar el servidor
Inicia el servidor local de Rails con el siguiente comando:

```
rails server
```

El servidor estará disponible en [http://localhost:3000](http://localhost:3000).

---

### 6. Ejecutar las pruebas (opcional)
Si el proyecto incluye pruebas, puedes ejecutarlas con:

```
rails test
```

---

¡Y listo! Ahora tienes el proyecto configurado y corriendo.