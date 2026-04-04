# Backend Documentation: Taborniski SOS Prirocnik

## 1. TECH STACK

### Production Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| express | ^4.17.2 | Web framework |
| typeorm | 0.3.20 | ORM for database management |
| pg | ^8.4.0 | PostgreSQL client |
| body-parser | ^1.19.1 | Middleware for parsing request bodies |
| cors | ^2.8.5 | Cross-Origin Resource Sharing middleware |
| dotenv | ^16.4.5 | Environment variable loader |
| reflect-metadata | ^0.1.13 | Enables decorator support in TypeScript |
| class-validator | ^0.14.1 | DTO validation decorators |
| class-transformer | ^0.5.1 | Object transformation utilities |
| class-validator-jsonschema | ^5.0.1 | JSON schema generation from validators |
| swagger-ui-express | ^5.0.1 | Swagger UI middleware |
| swagger-jsdoc | ^6.2.8 | JSDoc to Swagger/OpenAPI converter |
| swagger-autogen | ^2.23.7 | Auto-generate Swagger docs |
| tsconfig-paths | ^4.2.0 | TypeScript path mapping resolver |
| jest-mock-extended | ^4.0.0-beta1 | Extended mocking library |

### Development Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| typescript | 4.5.2 | TypeScript compiler |
| ts-node | ^10.9.1 | TypeScript execution for Node.js |
| nodemon | ^3.1.4 | Auto-restart on file changes |
| jest | ^29.7.0 | Testing framework |
| ts-jest | ^29.2.6 | TypeScript support for Jest |
| supertest | ^7.0.0 | HTTP assertion library |
| @types/express | ^5.0.0 | Express type definitions |
| @types/node | ^16.11.10 | Node.js type definitions |
| @types/cors | ^2.8.17 | CORS type definitions |
| @types/jest | ^29.5.14 | Jest type definitions |
| cross-env | ^7.0.3 | Cross-platform environment variable setter |
| openai | ^4.52.2 | OpenAI API client |

### Runtime Environment
- **Node.js** with TypeScript (compiled to ES5/CommonJS)
- **PostgreSQL** 14.5 — primary database
- **Server port:** 3000

---

## 2. DATABASE SCHEMA

### Table: `post`
| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| id | SERIAL | PRIMARY KEY | Auto-incremented integer |
| title | VARCHAR | NOT NULL | Post title |
| content | VARCHAR | NOT NULL | Post content/body |
| link | VARCHAR | NULLABLE | Optional external link (added in migration 1720254429339) |
| createdAt | TIMESTAMP | NOT NULL, DEFAULT now() | Automatically set on creation |
| updatedAt | TIMESTAMP | NOT NULL, DEFAULT now() | Automatically updated |

**Purpose:** Stores blog posts or news articles for the application.

---

### Table: `morse_exercises`
| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| id | SERIAL | PRIMARY KEY | Auto-incremented integer |
| type | ENUM | NOT NULL | Values: `'letters'`, `'words'`, `'sentences'` |
| translateType | ENUM | NOT NULL | Values: `'textToMorse'`, `'morseToText'` |
| value | VARCHAR | NOT NULL | Source text (plaintext or Morse depending on direction) |
| translatedValue | VARCHAR | NOT NULL | Target text (opposite of value) |
| length | INT | NOT NULL | Number of elements in exercise |
| learningInteractionType | ENUM | NOT NULL | Values: `'cards'`, `'keyboard'`, `'tokens'` |
| areTranslationsCorrect | BOOLEAN[] | NULLABLE | Array marking correct/incorrect answers (CARDS interaction only) |
| createdAt | TIMESTAMP | NOT NULL, DEFAULT now() | Automatically set on creation |
| updatedAt | TIMESTAMP | NOT NULL, DEFAULT now() | Automatically updated |

**Purpose:** Stores generated Morse code translation exercises for learning.
**Relationships:** None (no foreign keys).

---

### Table: `orientation`
| Column | Type | Constraints | Notes |
|--------|------|-------------|-------|
| id | SERIAL | PRIMARY KEY | Auto-incremented integer |
| name | VARCHAR | NOT NULL | Name of topographic feature |
| imageLoc | VARCHAR | NOT NULL | Path/URL to image file |
| topoGroupType | ENUM | NOT NULL | Values: `'geodetske_tocke'`, `'morje_in_morska_obala'`, `'naselja_in_objekti'`, `'promet'`, `'rastje_in_vrste_tal'`, `'relief'`, `'vodovje'`, `'meje_in_ograje'` |
| createdAt | TIMESTAMP | NOT NULL, DEFAULT now() | Automatically set on creation |
| updatedAt | TIMESTAMP | NOT NULL, DEFAULT now() | Automatically updated |

**Purpose:** Stores topographic map symbols used for orientation/map-reading exercises.
**Relationships:** None (no foreign keys).

---

## 3. API ENDPOINTS

No authentication is required on any endpoint.

### Posts — `/posts`

#### `GET /posts`
- **Auth:** No
- **Request Body:** None
- **Response:** Array of Post objects
```json
[
  {
    "id": 1,
    "title": "string",
    "content": "string",
    "link": "string | null",
    "createdAt": "ISO 8601",
    "updatedAt": "ISO 8601"
  }
]
```

#### `GET /posts/latest`
- **Auth:** No
- **Description:** Returns the single most recently created post (ordered by `createdAt DESC`, limit 1)
- **Request Body:** None
- **Response:** Single Post object

#### `POST /posts`
- **Auth:** No
- **Request Body:**
```json
{
  "title": "string (required)",
  "content": "string (required)",
  "link": "string (optional)"
}
```
- **Response:** Created Post object including `id`, `createdAt`, `updatedAt`

#### `DELETE /posts/:id`
- **Auth:** No
- **Path Params:** `id` (integer)
- **Request Body:** None
- **Response:** `"post has been removed"` or `"this post not exist"`

---

### Morse Code Exercises — `/morse-exercise`

#### `GET /morse-exercise`
- **Auth:** No
- **Request Body:** None
- **Response:** Array of MorseExercises objects

#### `POST /morse-exercise`
- **Auth:** No
- **Description:** Persist a pre-built exercise (direct save, no generation)
- **Request Body:**
```json
{
  "type": "letters | words | sentences (required)",
  "translateType": "textToMorse | morseToText (required)",
  "value": "string (required)",
  "translatedValue": "string (required)",
  "length": "integer (required)",
  "learningInteractionType": "cards | keyboard | tokens (required)"
}
```
- **Response:** Created MorseExercises object

#### `POST /morse-exercise/get-exercise`
- **Auth:** No
- **Description:** Generate a random Morse code exercise (calls OpenAI for `words`/`sentences` types)
- **Request Body:**
```json
{
  "type": "letters | words | sentences (required)",
  "translateType": "textToMorse | morseToText (required)",
  "numberOfElements": "integer (required)",
  "learningInteractionType": "cards | keyboard | tokens (required)"
}
```
- **Response:** Generated MorseExercises object; for CARDS interaction type the response includes `areTranslationsCorrect` (shuffled boolean array)

#### `DELETE /morse-exercise/:id`
- **Auth:** No
- **Path Params:** `id` (integer)
- **Request Body:** None
- **Response:** `"morse exercise has been removed"` or `"this morse exercise not exist"`

---

### Orientation Exercises — `/orientation`

#### `GET /orientation`
- **Auth:** No
- **Request Body:** None
- **Response:** Array of Orientation objects

#### `POST /orientation`
- **Auth:** No
- **Request Body:**
```json
{
  "type": "string (required)",
  "value": "string (required)",
  "translatedValue": "string (required)",
  "length": "integer (required)"
}
```
⚠️ **unclear:** Controller `save()` uses properties `type`, `value`, `translatedValue`, `length` but the Orientation entity defines `name`, `imageLoc`, `topoGroupType`. The implementation appears mismatched with the schema.

- **Response:** Created object (⚠️ unclear: result shape is inconsistent with entity definition)

#### `DELETE /orientation/:id`
- **Auth:** No
- **Path Params:** `id` (integer)
- **Request Body:** None
- **Response:** `"orientation element has been removed"` or `"this orientation not exist"`

#### `POST /orientation/get-exercise`
- **Auth:** No
- **Description:** Generate a random orientation exercise with shuffled image-name pairings
- **Request Body:**
```json
{
  "type": ["topoCharactersType", "..."],
  "numberOfElements": "integer (required)"
}
```
- **Response:**
```json
{
  "names": ["string", "..."],
  "imageLoc": ["string", "..."],
  "areCombinationsCorrect": [true, false, "..."]
}
```

---

## 4. BUSINESS LOGIC

### Morse Code Exercise Generation
**File:** `src/Services/excerciseGenerator.ts`
**Function:** `generateRandomExercise(length, type, translateType, learningInteractionType)`

**Flow for `letters` type:**
1. Generate `length` random English letters (A–Z)
2. Convert each letter to Morse code using `convertTextToMorse()` (local dictionary)
3. If CARDS interaction: shuffle Morse values, record which pairings remain correct
4. Save exercise to database and return it

**Flow for `words` / `sentences` type:**
1. Call OpenAI API (`gpt-3.5-turbo`) with a Slovenian-language prompt requesting words or sentences related to: Morse code, camping, scouting, nature, radio
2. Parse response (strips wrapping braces/JSON if present)
3. Strip punctuation from generated text
4. Convert text to Morse via `convertTextToMorse()`
5. If CARDS interaction: shuffle Morse values, track correct/incorrect
6. Save exercise to database and return it

**Error handling:**
- On `RateLimitError` from OpenAI: falls back to fetching an existing exercise from the database matching the same `type` and `length`
- All other errors: logged to console only

---

### Morse Code Conversion
**File:** `src/Services/morseConverter.ts`

- Uses a hardcoded International Morse Code dictionary
- Supported characters: A–Z, 0–9, Slovenian special characters (Š, Č, Ž — each mapped to a Morse code sequence)
- Space character converts to `/`
- All input converted to uppercase before lookup
- Output format: character codes separated by single space; word boundaries represented by `/`

---

### Orientation Exercise Generation
**File:** `src/Services/topoOrientationExerciseGenerator.ts`
**Function:** `generateRandomOrientationTopoExercise(length, type[], orientationRepository)`

1. Fetch orientation records from database filtered by `topoGroupType IN (type[])`
2. Randomly shuffle results and take first `length` elements
3. For each selected element:
   - **50% probability:** Keep original name — mark as correct
   - **50% probability:** Replace name with a random different name from the same topographic group — mark as incorrect
4. Return `{ names, imageLoc, areCombinationsCorrect }`

**Purpose:** Creates a matching game where users pair topographic map symbols (images) with their correct feature names.

---

## 5. EXTERNAL DEPENDENCIES

### OpenAI API
- **Package:** `openai@^4.52.2`
- **Model:** `gpt-3.5-turbo` (overridable via `OPENAI_MODEL` env var)
- **API Key:** `OPENAI_API_KEY` environment variable
- **Used for:** Generating Slovenian words and sentences for Morse code exercises
- **System prompt language:** Slovenian; topics: Morse code, camping, scouting, nature, radio
- **Fallback:** On rate limit error, returns an existing database record instead of generating new content
- ⚠️ **unclear:** The `.env` file contains a literal API key value — if committed to version control the key is exposed

### PostgreSQL
- **Version:** 14.5
- **Host:** `localhost`
- **Port:** `5432`
- **Database name:** `t_sos_p`
- **Credentials:** Hardcoded in `src/data-source.ts` (username: `sos_admin`)
- ⚠️ **unclear:** Credentials are hardcoded in source rather than loaded from environment variables

### Swagger / OpenAPI
- **UI endpoint:** `http://localhost:3000/api-docs`
- **Config file:** `src/swaggerConfig.ts`
- **Scanned paths:** `./src/routes/*.ts`, `./src/controller/*.ts`

---

## 6. TESTING INFRASTRUCTURE

- **Framework:** Jest 29.7.0 + ts-jest
- **HTTP assertions:** supertest
- **Mocking:** jest-mock-extended (repository mocking)
- **Test setup file:** `test/setup.ts` (database init and cleanup)
- **Test files:**
  - `test/PostController.test.ts` — Post CRUD operations
  - `test/OrientationController.test.ts` — Orientation operations
- ⚠️ **unclear:** `OrientationController.test.ts` references fields (`type`, `value`, `translatedValue`, `length`, `sort`) that do not exist on the actual Orientation entity — tests may not accurately reflect production behavior

---

## 7. SCRIPTS

| Script | Command | Purpose |
|--------|---------|---------|
| `start` | ts-node | Start server |
| `start:dev` | nodemon | Start with auto-reload |
| `test` | jest | Run all tests |
| `test:watch` | jest --watch | Run tests in watch mode |
| `migration:run` | typeorm migration:run | Execute pending migrations |
| `migration:revert` | typeorm migration:revert | Revert last migration |
| `migration:generate` | typeorm migration:generate | Auto-generate migration from entity diff |
| `migration:show` | typeorm migration:show | Display migration status |
| `migrate:reset` | revert-all + migration:run | Reset and re-run all migrations |
