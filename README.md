# Blog App

> We create a fully functional website that will show the list of posts and empower readers to interact with them by adding comments and liking posts.

## Built With

- Ruby on Rails

## Live Demo (if available)

[Live Demo Link](https://livedemo.com)

## Getting Started

### Get a local copy

- git clone the project

```bash
git clone https://github.com/jaflih/blog_app.git
```

```
cd blog_app
```

### Install the app

```
bundle install
rails db:migrate
```

### Run the seeder

```
rails db:seed
```

### Run the app

- To run the app

```
rails s
```

```
Visit http://localhost:3000/ in your browser.
```

### Run the tests

- To run the tests

```
rspec spec/models
```

```
rspec spec/views
```

### USING THE API

#### Authentication :

```
  POST localhost:3000/api/authentication/create
  post parameters :
   - email
   - password
```

#### List all posts for a user :

```
GET localhost:3000/api/users/:id_user/posts
```

#### List all comments for a user's post :

```
GET localhost:3000/api/posts/:id_post/comments
```

#### Add a comment to a post :

```
POST localhost:3000/api/posts/:id/comments/create
post parameters:
 - token
 - text
```

## Authors

👤 **Jaflih**

- GitHub: [@githubhandle](https://github.com/jaflih)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/jaflih/)

Edward Yara :student:

- GitHub: [@oluyaratosin123](https://github.com/oluyaratosin123)
- Twitter: [@TOluyara](https://twitter.com/TOluyara)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/edward-oluyara/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](./MIT.md) licensed.
