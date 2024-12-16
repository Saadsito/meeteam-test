## Steps to Run the Project (English):

### 1. Clone the Project from the GitHub Repository
Open your terminal and execute the following commands:

git clone https://github.com/Saadsito/meeteam-test.git
cd meeteam-test

---

### 2. Create the Database in PostgreSQL
#### 2.1. Install PostgreSQL (if not already installed)
##### On Debian/Ubuntu-based systems:
sudo apt update
sudo apt install postgresql postgresql-contrib

##### On macOS:
With Homebrew installed, run:
brew install postgresql
brew services start postgresql

#### 2.2. Configure PostgreSQL
If you need to set up a user and database for the project, run:
sudo -u postgres psql

Inside the PostgreSQL console, enter the following commands to create the user and database:
CREATE USER meeteam_user WITH PASSWORD 'password123';
CREATE DATABASE meeteam_test OWNER meeteam_user;
GRANT ALL PRIVILEGES ON DATABASE meeteam_test TO meeteam_user;
\q

Add a `config/database.yml` file configured with the following values based on your database:
default: &default
  adapter: postgresql
  encoding: unicode
  username: meeteam_user
  password: password123
  host: localhost

development:
  <<: *default
  database: meeteam_test_development

test:
  <<: *default
  database: meeteam_test_test

---

### 3. Install the Project Dependencies
Make sure Bundler is installed:
gem install bundler

Then install the project dependencies:
bundle install

---

### 4. Create and Migrate the Database
Run the following commands to prepare the database:
rails db:create
rails db:migrate

---

### 5. Run the Rails Console
Start the Rails console with the following command:
rails c

You can create new nodes with:
node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)

You can link neighbors:
node1.add_neighbor(node2)
node1.add_neighbor(node3)
node2.add_neighbor(node1)
node2.add_neighbor(node3)
node3.add_neighbor(node1)
node3.add_neighbor(node2)

You can propose states:
node1.propose_state(1)
node2.propose_state(2)
node3.propose_state(3)

You can simulate partitions:
node3.simulate_partition([node1])

You can print the logs of each node:
puts node1.retrieve_log
puts node2.retrieve_log
puts node3.retrieve_log


### 6. Run the Tests
---

bundle exec rspec

---



## Pasos para correr el test (Español):

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

Debes agregar un archivo `config/database.yml` que esté configurado con los valores dependiendo de tu base de datos:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  username: meeteam_user
  password: password123
  host: localhost

development:
  <<: *default
  database: meeteam_test_development

test:
  <<: *default
  database: meeteam_test_test
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

### 5. Ejecutar la consola de rails
Ejecuta la consola de Rails con el siguiente comando:

```
rails c
```

Puedes crear nuevos nodos con:

node1 = Node.new(1)
node2 = Node.new(2)
node3 = Node.new(3)

Puedes relacionar vecinos: 

node1.add_neighbor(node2)
node1.add_neighbor(node3)
node2.add_neighbor(node1)
node2.add_neighbor(node3)
node3.add_neighbor(node1)
node3.add_neighbor(node2)

Puedes proponer estados:

node1.propose_state(1)
node2.propose_state(2)
node3.propose_state(3)

Puedes simular particiones:

node3.simulate_partition([node1])

Puedes imprimir los logs de cada nodo:

puts node1.retrieve_log
puts node2.retrieve_log
puts node3.retrieve_log

---

### 6. Ejecutar las pruebas

```
bundle exec rspec
```

---

