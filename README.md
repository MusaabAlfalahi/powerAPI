# PowerAPI

## Description

PowerAPI is a RESTful service designed to manage power banks, their assignments to stations and warehouses, and user
interactions. This API supports typical CRUD operations and includes custom endpoints for specific use cases like
assigning power banks to stations, warehouses, or users.

### Technologies and Tools Used

- **Ruby on Rails** as the web backend framework this API's build with.
- **PostgreSQL** as the database for robust data management.
- **JWT (JSON Web Tokens)** for secure authentication and authorization.
- **RSpec** for comprehensive testing to ensure code quality and reliability.

## Installation

To set up the project locally, follow these steps:

1. **Clone the repository:**

    ```sh
    git clone https://github.com/MusaabAlfalahi/powerAPI.git
    cd powerAPI 
    ```

2. **Install dependencies:**

   Ensure you have Ruby and Bundler installed. Then run:

    ```sh
    bundle install
    ```
3. **Set up environment variables:**

   Create a `.env` file in the root directory of the project and add your environment variables, such as secret keys and
   database URLs. For example:

   ```sh
   DB_USERNAME= <your_db_username> 
   DB_PASSWORD= <your_db_password>
   ```

4. **Set up the database:**

   Ensure you have PostgreSQL installed and running. Configure your database settings in `config/database.yml` and then
   run:

   ```sh
   rails db:create
   rails db:migrate
   rails db:seed
   ```    

## Usage

To start the Rails server, run:

   ```sh
   rails server
   ```

The API will be available at http://localhost:3000.

### Endpoints

#### Authentication

- **Login:** `POST /login`
    - Request: `{ "email": "user@example.com", "password": "password" }`
    - Response: `{ "user": { "id": 1, "email": "user@example.com" }, "token": "jwt_token" }`

- **Logout:** `DELETE /logout`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `204 No Content`

#### Users

- **Create User:** `POST /users`<sub>admin only</sub>
    - Request: `{ "email": "user@example.com", "password": "password", "password_confirmation": "password" }`
    - Response: `{ "id": 1, "email": "user@example.com" }`

#### Locations

- **List Locations:** `GET /locations`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `[ { "id": 1, "name": "Location 1", "address": "Address 1" }, ... ]`

- **Show Location:** `GET /locations/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `{ "id": 1, "name": "Location 1", "address": "Address 1" }`

- **Create Location:** `POST /locations`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`,
      Body: `{ "name": "New Location", "address": "New Address" }`
    - Response: `{ "id": 1, "name": "New Location", "address": "New Address" }`

- **Update Location:** `PUT /locations/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`,
      Body: `{ "name": "Updated Location", "address": "Updated Address" }`
    - Response: `{ "id": 1, "name": "Updated Location", "address": "Updated Address" }`

- **Delete Location:** `DELETE /locations/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `204 No Content`

- **Search Locations:** `GET /locations/search`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Params: `{ "query": "search_term" }`
    - Response: `[ { "id": 1, "name": "Location 1", "address": "Address 1" }, ... ]`

#### Stations

- **List Stations:** `GET /stations`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `[ { "id": 1, "name": "Station 1", "status": "active" }, ... ]`

- **Show Station:** `GET /stations/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `{ "id": 1, "name": "Station 1", "status": "active" }`

- **Create Station:** `POST /stations`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Body: `{ "name": "New Station", "status": "active" }`
    - Response: `{ "id": 1, "name": "New Station", "status": "active" }`

- **Update Station:** `PUT /stations/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`,
      Body: `{ "name": "Updated Station", "status": "inactive" }`
    - Response: `{ "id": 1, "name": "Updated Station", "status": "inactive" }`

- **Delete Station:** `DELETE /stations/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `204 No Content`

- **Assign Station to Location:** `PUT /stations/:id/location`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Body: `{ "location_id": 1 }`
    - Response: `{ "id": 1, "name": "Station 1", "location_id": 1 }`

- **Assign Station to Warehouse:** `PUT /stations/:id/warehouse`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Body: `{ "warehouse_id": 1 }`
    - Response: `{ "id": 1, "name": "Station 1", "warehouse_id": 1 }`

- **Search Stations:** `GET /stations/search`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Params: `{ "query": "search_term" }`
    - Response: `[ { "id": 1, "name": "Station 1", "status": "active" }, ... ]`

#### Warehouses

- **List Warehouses:** `GET /warehouses`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `[ { "id": 1, "name": "Warehouse 1", "location_id": 1 }, ... ]`

- **Show Warehouse:** `GET /warehouses/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `{ "id": 1, "name": "Warehouse 1", "location_id": 1 }`

- **Create Warehouse:** `POST /warehouses`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Body: `{ "name": "New Warehouse", "location_id": 1 }`
    - Response: `{ "id": 1, "name": "New Warehouse", "location_id": 1 }`

- **Update Warehouse:** `PUT /warehouses/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`,
      Body: `{ "name": "Updated Warehouse", "location_id": 1 }`
    - Response: `{ "id": 1, "name": "Updated Warehouse", "location_id": 1 }`

- **Delete Warehouse:** `DELETE /warehouses/:id`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `204 No Content`

- **Search Warehouses:** `GET /warehouses/search`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Params: `{ "query": "search_term" }`
    - Response: `[ { "id": 1, "name": "Warehouse 1", "location_id": 1 }, ... ]`

#### Power Banks

- **List Power Banks:** `GET /power_banks`<sub>admin only</sub>
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `[ { "id": 1, "name": "Power Bank 1", "status": "available" }, ... ]`

- **List available Power Banks:** `GET /power_banks/available`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `[ { "id": 1, "name": "Power Bank 1", "status": "available" }, ... ]`

- **Show Power Bank:** `GET /power_banks/:id`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `{ "id": 1, "name": "Power Bank 1", "status": "available" }`

- **Create Power Bank:** `POST /power_banks`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`,
      Body: `{ "name": "New Power Bank", "status": "available" }`
    - Response: `{ "id": 1, "name": "New Power Bank", "status": "available" }`

- **Update Power Bank:** `PUT /power_banks/:id`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`,
      Body: `{ "name": "Updated Power Bank", "status": "in_use" }`
    - Response: `{ "id": 1, "name": "Updated Power Bank", "status": "in_use" }`

- **Delete Power Bank:** `DELETE /power_banks/:id`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `204 No Content`

- **Assign Power Bank to Station:** `PUT /power_banks/:id/station`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Body: `{ "station_id": 1 }`
    - Response: `{ "id": 1, "name": "Power Bank 1", "station_id": 1 }`

- **Assign Power Bank to Warehouse:** `PUT /power_banks/:id/warehouse`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Body: `{ "warehouse_id": 1 }`
    - Response: `{ "id": 1, "name": "Power Bank 1", "warehouse_id": 1 }`

- **Assign Power Bank to User:** `PUT /power_banks/:id/user`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Body: `{ "user_id": 1 }`
    - Response: `{ "id": 1, "name": "Power Bank 1", "user_id": 1 }`

- **Search Power Banks:** `GET /power_banks/search`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`, Params: `{ "query": "search_term" }`
    - Response: `[ { "id": 1, "name": "Power Bank 1", "status": "available" }, ... ]`

- **Take Power Bank:** `PUT /power_banks/:id/take`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `{ "id": 1, "name": "Power Bank 1", "status": "in_use" }`

- **Return Power Bank:** `PUT /power_banks/:id/return`
    - Request: Headers: `{ "Authorization": "Bearer jwt_token" }`
    - Response: `{ "id": 1, "name": "Power Bank 1", "status": "available" }`

## Testing

To run the test suite, use the following command:

   ```sh
   bundle exec rspec
   ```

## Bonus

- [ ] Implement validations and error handling.
- [x] Add pagination for Power Banks listing.
- [x] Include search functionality.
- [ ] Deploy the project using your preferred platform.
- [ ] Implement a simple front-end using a framework of your choice.
