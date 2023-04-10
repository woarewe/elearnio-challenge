## Dependecies

 - PostgreSQL 15.2
 - Ruby 3.1.3

## Setting up project locally

### Configuring database using Docker

```shell
docker pull postgres:15.2
docker volume create elearnio_challenge_db
docker container create --name elearnio_challenge_db --publish 5432:5432 --env POSTGRES_USER=postgres --env POSTGRES_PASSWORD=password --volume elearnio_challenge:/var/lib/postgresql/data postgres:15.2
docker start elearnio_challenge_db
```

### Setting ENV variables

```shell
cp .env.example .env
```

### Preparing databases

```shell
bin/rake db:create db:schema:load
```

### Checking tests, Rubocop and Zeitwerk

```shell
bin/rspec
bin/rubocop
bin/rails zeitwerk:check
```

## Project Structure

### Technical highlights
  - The REST API is built on [Grape](https://github.com/ruby-grape/grape) because:
    - It has a handy serialization layer
    - Routes are assembled based on class definitions
    - Basic Swagger documentation for free
  - The project follows DDD-like approach:
    - The data layer is represented by immutable **entities** and **value objects**. They can not be instantiated or transformed into an invalid state.
    - The persistance layer and its constraints is handled by **repositories** based on ActiveRecord
    - Services are "bridges" between layers
  - Communication between layer are done through specific error classes

###

```text
app
├── entities # Immutable business entities that ensure in-memory business rules
├── gateways
│   └── rest
│       ├── api
│       │   ├── helpers # Helpers for easier dealing with other layers(exception handling, data fetching)
│       ├── serialization # Output data serialization
│       └── validation # HTTP-specific data validation
├── repositories # Retrieving information from the database and storing it back, while enforcing some unique constraints
├── services # More complex business operations
├── types # Value-objects
```

## "Business" decisions

- Courses and learning paths can be either in `draft` or `published` mode
- Only `published` courses and learning paths can be assigned to talents
- Only `published` courses can be used in a learning path
- `published` entities can neiter be `changed` nor `deleted`
- Talent emails are unique
- Courses names are unique
- Learning path names are unique
- Courses can not be assigned to their authors
- Learning paths can not be assigned ot their authors
- All the course authors of a learning path are considered co-authors
- A learning path can not be assigned to its co-authors
- A talent, who has an assigned learning path/course, can not be used as their new author, when deleting their current author

## Exploring the API

You can get all the available endpoints by generation swagger docs

1. Run the server localy
2. Visit `/api/swagger`
3. Grab the response JSON and paste it into `editor.swagger.io`
