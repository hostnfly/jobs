# Lucas Montorio's test

Here you will find some instructions to make the app work and check the results of the computation of missions from the given input.


- Populate teh DB with the following command:
```
rake populate_db_from_backend_file:populate[backend/backend_test.json]
```

- Launch a Rails server from the `jobs-app` directory:
```
rails s
```

- Open a browser to `localhost:3000`. CRUD actions and (really basic) views are available for `/bookings`, `/listings`, `/reservations`. The index views support `json` formatting.

- An index view is available for `/missions` as well. From this view, you can click a `Generate missions` button that will compute some missions from the given data and refresh the page. You can also do it manually with a `POST` on `/missions/generate`

# Code reading
The important pieces of code that I wrote to make this test are located in the following repositories:

- `app/controllers`
- `app/models`
- `app/helpers and app/views` ( only very basic display )
- `app/services`
- `db/migrate`
- `lib/tasks`
