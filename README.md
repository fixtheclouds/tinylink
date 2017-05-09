# URL Shortener

## Instructions
This task should be implemented in either Ruby + AngularJS. You can use frameworks, ORMs, template’s engines, but not ready solutions. Code should be provided as a public GitHub repo. README file with detailed information is required.

## Task
1. Application should have form with field where user can put valid url (validation should be done by direct call of the provided url and check HTTP response code).
2. Application should generate short url. Example: http://domaincom/cedwdsfl
3. It should be possible to enter desired short url (another field).
4. Application should validate if requested short url is not in use yet.
5. Application should store original and short url pair in DB. User than can share short url with other users and once they try to access short url they should be redirected to
original url.

## Extra Credit
1. Application should have configuration file. logging system.
2. Application should remove origin-short url pair from DB on the 15th day after its creation.
3. Application should count amount of short url usage. Application should have API for short url creations.
4. GitHub repo should contain a descriptive commits history

## Developer notes
### Tools used for this app:

* Ruby 2.3.1 + Rails 5.1.0
* PostgreSQL 9.4
* AngularJS 1.6.4
* UIkit 2.24

### Public API

URL: `/link`

Method: `POST`

Parameters: 
* `url` - original URL
* `short_url` - (optional) short URL

Response:
```
{ "url" : <generated_url> }
``` 

