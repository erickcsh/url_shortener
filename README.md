# URL Shortener

The URL Shortener is an app created for as a technical test for a job interview.

## Ruby Version

2.6.3

# URL shortening algorithim

The shortened URL is determined by the ID in the DB that each entry has. For example if we want to shorten `htts://example.com/this-is-an-example` then this will happen:

1. A new Website object is created in the DB.
2. The object ID is Base62 encoded and returned in the response to the client.

To read the URL a request with the shortened ID is received and:

1. Base62 decode the shortened ID to obtain the original ID.
2. Read from the DB using the ID returned in step 1.
3. Respond with the Website object read from step 2.

# Running the project using Docker

To start the project using Docker, run

1. Build
`docker-compose build`

2. Start
`docker-compose up`

3. Create DB and Seed (Seeds file creates 150 URLs to make it easier to test)
`docker-compose run web rails db:create db:migrate db:seed`

4. Profit! Make requests now.

## Example curl calls

### Top 100:
Description: List the top 100 accessed URLs
Request:
```
curl -X GET \
  http://localhost:3000/api/v1/websites \
  -H 'accept: application/json' \
  -H 'cache-control: no-cache' \
  -H 'postman-token: 013e2020-31b1-b40c-9c0b-be62254a021c'
```

Example response:
```
[
    {
        "url": "https://www.example.com/aunt.html?beef=branch&birds=anger#attack",
        "title": null,
        "access_count": 100,
        "shortened_id": "1e"
    },
    {
        "url": "https://www.example.com/?bit=brass&bridge=boat#airplane",
        "title": null,
        "access_count": 100,
        "shortened_id": "4"
    },
    ...
]
```


### Create new URL:
Add a new URL and responds with the sortened id.
Request:
```
curl -X POST \
  http://localhost:3000/api/v1/websites \
  -H 'accept: application/json' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 433c058d-879c-3f30-0ef0-f3ffa01a960d' \
  -d '{
	"website": { "url": "https://www.facebook.com/ErickCQ1" }
}'
```

Example response:
```
{
    "id": "2v"
}
```

### Read URL:
Reads the information of an URL created by the Create URL endpoint. The id used in the URL is the id returned by the mentioned endpoint.
Request:
```
curl -X GET \
  http://localhost:3000/api/v1/websites/1 \
  -H 'accept: application/json' \
  -H 'cache-control: no-cache' \
  -H 'postman-token: 4cebe8bd-f88d-8df9-7e06-944e00f7f371'
```

Example response:
```
{
    "url": "https://www.facebook.com/ErickCQ",
    "title": null,
    "access_count": 6,
    "shortened_id": "1"
}
```


## Running tests

### Docker

To run tests in Docker:
1. Execute:
`docker-compose run web rspec spec`

To run tests locally:
1. Update database.yml to point to local DB, easiest way is to remove this lines:
```
host: db
username: postgres
password:
```

2. execute:
`rspec spec`

NOTE: Do not forget to update the database.yml to the previous state, else Docker would not run as expected.

## TODOs

Due to time limitations of this being a technical test, there are certain tasks that can be done:
1. Clean unused rails auto generated files and comments
2. Remove active storage routes
3. Add pagination to the top 100 page
4. Create a semaphore or similar to ensure updating the access count for each URL is not affected by simultaneous requests
5. Cache responses to improve performance
