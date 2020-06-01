# Resource Repository

## Development

### Dependencies:

- Docker (incl. Docker Compose, which already part of Docker for Mac and Docker Toolbox)

### Setup
```
cp .env-example .env
```

Set a default password for postgres by adding `DEV_PASS=changeme` to your `.env` file.

Build the containers:
```
docker-compose build
```

Start the stack:
```
docker-compose up -d
```

View logs (add -f to tail):
```
docker-compose logs
```

Visit http://localhost:3000

If it's your first time running you'll need to create the database first before use. You'll also need to do this if you've removed your database volume.

### Create Database
```
docker-compose run --rm web bin/rails db:create
```

### Run migrations

After adding any new migrations they need to be run inside docker:
```
docker-compose run --rm web bin/rails db:migrate
```

### Seeding the database

Once your database is setup and the migrations have been run, you will want to ensure it is populated with the data you need to run the application. You can do this by running the following command:

```
docker-compose run web bin/rails db:seed
```

### Install new Dependencies

Add the dependency to the Gemfile or package.json and run:
```
docker-compose down
docker-compose build
```

## Testing

Uses [rspec](https://github.com/rspec/rspec)
```
docker-compose run --rm web bin/rspec
```

To use [guard](https://github.com/guard/guard) to watch the tests:
```
docker-compose run --rm web bin/guard
```

## Tooling

### ERB Lint

Used for linting ERB / HTML files

Run with `bundle exec erblint --lint-all`

https://github.com/Shopify/erb-lint

### Reek

Used for detecting 'code smell' in your app.

Run with `bundle exec reek`

### Brakeman

Used for static code analysis to check for potential security flaws.

https://brakemanscanner.org/docs/quickstart/

We are ignoring some of the warnings using the method described in the [Brakeman docs](https://brakemanscanner.org/docs/ignoring_false_positives/) We are using the default location for the ignore file, etc.

Run `brakeman -i config/brakeman.ignore .` in the project root and follow the onscreen prompts, outlined in the above doc, to use the tool and check the output for warnings, etc.
