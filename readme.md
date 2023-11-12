# Rails assignment

## Architecture
### The overall architecture used is MVC, and most of data accessing is done through the ActiveRecord API eg:
```Ruby
User.find(params[:user_id])
```
### This is done directly in the controllers, because service classes or repositories would be overkill, if no side effects is happening.

## Documentation
### The API endpoints are documented with the use of swagger and can be accessed at 
```
/api-docs/index.html
```

## Tests
### Acceptence criterias has been converted to rspec tests in order to ensure everything is working as intended.
### Swagger could be used to run automated tests, but is not due to me preffering rspec.
