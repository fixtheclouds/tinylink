# URL Shortener

Simple URL shortener built with Rails + PostgreSQL  + AngularJS.

## Usage

Enter source link, specify your own alias (optional) and get a shortened link.

Links are stored for 15 days.

## Public JSON API

* `POST /link`

    Parameters: 
    * `url` {String} original URL
    * `short_url` {String} short URL (optional)
    
    Example response:
    ```json
    { 
      "url" : "https://tinylink-test-app.herokuapp.com/bi61wrdk"
    }
    ``` 

