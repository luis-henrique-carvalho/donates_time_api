---
modified: 2024-07-10T03:38:07.439Z
title: API Documentation
---

# API Documentation

## Ongs

### List Ongs

**Endpoint:** `GET /ongs`

**Description:** Retrieves a list of all ONGs.

**Response:**

```json
[
  {
    "id": "uuid",
    "name": "string",
    "city": "string",
    "state": "string",
    "description": "text",
    "email": "string",
    "category": "string",
    "created_at": "datetime",
    "updated_at": "datetime",
    "user_id": "uuid"
  },
  ...
]
```

### Create Ong

**Endpoint:** `POST /ongs`

**Description:** Creates a new ONG.

**Request Body:**

```json
[
  {
  "name": "string",
  "city": "string",
  "state": "string",
  "description": "text",
  "email": "string",
  "category": "string",
  "user_id": "uuid"
}
  ...
]
```

**Response:**

```json
{
  "id": "uuid",
  "name": "string",
  "city": "string",
  "state": "string",
  "description": "text",
  "email": "string",
  "category": "string",
  "created_at": "datetime",
  "updated_at": "datetime",
  "user_id": "uuid"
}
```

### Update Ong

**Endpoint:** `PUT /ongs/:id`

**Description:** Updates an existing ONG.

**Request Body:**

```json
[
  {
  "name": "string",
  "city": "string",
  "state": "string",
  "description": "text",
  "email": "string",
  "category": "string",
  "user_id": "uuid"
}
  ...
]
```

**Response:**

```json
{
  "id": "uuid",
  "name": "string",
  "city": "string",
  "state": "string",
  "description": "text",
  "email": "string",
  "category": "string",
  "created_at": "datetime",
  "updated_at": "datetime",
  "user_id": "uuid"
}
```

## Show Ong

**Endpoint:** `GET /ongs/:id`

**Description:** Retrieves information about a specific ONG.

**Response:**

```json
{
  "id": "uuid",
  "name": "string",
  "city": "string",
  "state": "string",
  "description": "text",
  "email": "string",
  "category": "string",
  "created_at": "datetime",
  "updated_at": "datetime",
  "user_id": "uuid"
}
```

## Delete Ong

**Endpoint:** `DELETE /ongs/:id`

**Description:** Deletes an existing ONG.

**Response:**

```json
{
  "message": "Ong deleted successfully"
}
```

## Actions

### List Actions

**Endpoint:** `GET /actions`

**Description:** Retrieves a list of all actions.

**Response:**

```json
[
  {
    "id": "uuid",
    "title": "string",
    "start_date": "datetime",
    "end_date": "datetime",
    "description": "text",
    "max_volunteers": "integer",
    "category": "string",
    "created_at": "datetime",
    "updated_at": "datetime",
    "ong_id": "uuid"
  },
  ...
]

```

### Create Action

**Endpoint:** `POST /actions`

**Description:** Creates a new action.

**Request Body:**

```json
[
  {
  "title": "string",
  "start_date": "datetime",
  "end_date": "datetime",
  "description": "text",
  "max_volunteers": "integer",
  "category": "string",
  "ong_id": "uuid"
}
  ...
]
```

**Response:**

```json
{
  "id": "uuid",
  "title": "string",
  "start_date": "datetime",
  "end_date": "datetime",
  "description": "text",
  "max_volunteers": "integer",
  "category": "string",
  "created_at": "datetime",
  "updated_at": "datetime",
  "ong_id": "uuid"
}
```

### Update Action

**Endpoint:** `PUT /actions/:id`

**Description:** Updates an existing action.

**Request Body:**

```json
[
  {
  "title": "string",
  "start_date": "datetime",
  "end_date": "datetime",
  "description": "text",
  "max_volunteers": "integer",
  "category": "string",
  "ong_id": "uuid"
}
  ...
]
```

**Response:**

```json
{
  "id": "uuid",
  "title": "string",
  "start_date": "datetime",
  "end_date": "datetime",
  "description": "text",
  "max_volunteers": "integer",
  "category": "string",
  "created_at": "datetime",
  "updated_at": "datetime",
  "ong_id": "uuid"
}
```

## Show Action

**Endpoint:** `GET /actions/:id`

**Description:** Retrieves information about a specific action.

**Response:**

```json
{
  "id": "uuid",
  "title": "string",
  "start_date": "datetime",
  "end_date": "datetime",
  "description": "text",
  "max_volunteers": "integer",
  "category": "string",
  "created_at": "datetime",
  "updated_at": "datetime",
  "ong_id": "uuid"
}
```

## Delete Action

**Endpoint:** `DELETE /actions/:id`

**Description:** Deletes an action by ID.

**Response:**

```json
{
  "message": "Action deleted successfully"
}
```

## Enums

### Action Categories

**Description:** Enum representing the categories of actions.

**Categories:**

- education
- health
- environment
- animal_welfare
- arts_and_culture
- human_rights
- community_development
- science_and_technology
- disaster_relief
- sports
- youth
- seniors

**Example:**

```json
{
  "category": "education"
}
```
