<div align="center">
    <img height="100" src="https://raw.githubusercontent.com/PokeAPI/media/master/logo/pokeapi.svg?sanitize=true" alt="PokeAPI">
    <img height="30" src="https://sendu.cl/wp-content/uploads/2023/05/Logo-Sendu-1-2048x562-1.png" alt="Sendu"><br /><br />
    
</div>

As part of the selection process for the position of software engineer of the SENDU company, it is requested to generate an API, which provides a CRUD, based on the [pokedexAPI](https://pokeapi.co/docs/v2#info).

## Getting Started

### Requirements

- Docker
  https://docs.docker.com/engine/install/

  **Alternative installation on macos**

  ```bash
  brew install orbstack
  ```

### Setup

- Run the setup script to get everything working

  ```bash
  make setup
  ```

## Development

### How to run the app

- Run the server using the following command:

  ```bash
  make serve
  ```

### Troubleshooting

- Access to rails console:

  ```bash
  make console
  ```

- Acess bash interactive shell:

  ```bash
  make shell
  ```

- To clear all the containers and volumes with database data.

  ```bash
  make destroy
  ```

## How use the API

<details>
  <summary>The application provides RESTful API endpoints at the following URL: `http://localhost:3000/api/v1/pokemons`. The API supports the following HTTP methods:</summary>
  
  - **POST**: Create a new Pokemon
  - **PUT**: Update an existing Pokemon
  - **DELETE**: Delete a Pokemon
  - **GET (Index)**: Retrieve a list of all Pokemons
  - **GET (Show)**: Retrieve details of a specific Pokemon  
</details>

#### Insomnia Integration

To interact with the API seamlessly, you can use Insomnia, a powerful API testing and design tool.

<details>
  <summary>Importing the API into Insomnia</summary>
  
  1. Open Insomnia and create a new workspace or open an existing one.
  2. Click on the '+' icon to create a new request.
  3. From the top menu, choose "Import"
  4. In the popup window, select "From File."
  5. Locate and choose the Insomnia_2023-11-09.json file in your repository.
  6. Click "Import" to load the project configuration into Insomnia.
  
</details>

#### Swagger Integration

It can also be tested through swagger...

## Documentation

For API documentation, Swagger is the tool of choice. To generate the HTML using Swagger, run the following command:

```bash
rake rswag:specs:swaggerize
```

Once generated, you can access the documentation through the following link:

[Swagger Documentation](http://localhost:3000/api-docs/index.html)

## How to run tests

You can choose any of the methods mentioned above to run commands to execute the specs

1. To run all the tests

   ```bash
   make test
   ```

2. To run a specific test file

   ```bash
   make shell
   rspec <spec_path>
   ```

3. To run a specific test within a file

   ```bash
   make shell
   rspec <spec_path>:<line>
   ```
