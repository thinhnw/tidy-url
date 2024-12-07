# TidyURL

TidyURL is a Ruby on Rails application that allows users to shorten URLs. It provides a simple interface for creating and managing shortened links.

Check out the [Demo](https://tidyurl.thinhnw.site) of the app.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Running Tests](#running-tests)
- [Deployment](#deployment)

## Installation

To get started with TidyUrl, clone the repository and install the necessary dependencies:

```bash
git clone https://github.com/thinhnw/tidy-url.git
cd tidy-url
bin/setup
```


This will install all required gems and prepare the database.

## Usage

To start the development server, run:

```bash
bin/dev
```

You can then access the application at `http://localhost:3000`.


## Configuration

Before running the application, ensure you have the following environment variables set in your `.env` file:

```
POSTGRES_USERNAME=your_username
POSTGRES_PASSWORD=your_password
POSTGRES_DATABASE=tidyurl
POSTGRES_HOST=db
```


## Database Setup

To set up the database, run:

```bash
bin/rails db:setup
```

This command will create the database, run migrations, and load the seed data.

## Running Tests

To run the test suite, use the following command:

```bash
bin/rails test
```


## Deployment

For deployment, you can use Docker. Build the Docker image with:

```bash
docker compose up
```
