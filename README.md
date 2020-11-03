# HTTP Refusing Server
A small app that rejects incoming network connections for a while. The server refuses incoming network connections after responding to a HTTP request.

## Heroku
Deploy to Heroku. Scale web dynos to two or more and run `heroku logs -t` to watch how requests are forwarded.

```
heroku create
git push heroku main
heroku ps:scale web=2:standard-1x
heroku logs -t
```

