# THESIS.md — Explorer Report
**Source:** UN_Podlogar_Nejc_2025.pdf (62 pages)  
**Author:** Nejc Podlogar  
**Title:** Razvoj platformno neodvisne aplikacije Taborniški S.O.S priročnik  
**Institution:** University of Maribor, Computer Science and Information Technologies  
**Mentor:** izr. prof. dr. Tomaž Kosar  
**Co-mentor:** Matej Moravec  
**Date:** August 2025  

---

## 1. PROBLEM STATEMENT

Scouting (taborništvo) is one of the largest volunteer youth organisations in Slovenia and worldwide. Slovenia has thousands of scouts of all ages, from primary school children to retirees.

Most scout reference material is available **only in physical form or scattered across multiple digital document locations**. There is no centralised digital tool for learning or practising core scout skills.

Specific problems named:
- Lack of accessible digital material for navigation/orientation
- Passive and difficult learning methods for Morse code and flag semaphore
- Scout knowledge is fragmented across locations, not centralised

The thesis set out to build a cross-platform mobile and web application that digitalises scout material and provides interactive learning tools for scout knowledge.

---

## 2. TARGET USERS

- **Scouts of all generations** (primary target, stated explicitly)
- **Younger users** (primary design target — simple UI, large elements, thumb-friendly layout)
- Users preparing for **scout competitions**
- Leaders and educators using it as **didactic material**
- Both mobile (Android/iOS) and web users

Language: **Slovenian** (primary app language)

---

## 3. FEATURE LIST

### 3.1 Morse Code (Morsejeva abeceda)

#### Translator
- Text → Morse code translation
- Morse code → text translation
- Real-time translation as user types
- Copy translated result
- Reverse translation (swap input/output)
- Clear/delete input
- Export translated result as document (web app only)
- **Transmit Morse code via phone camera flashlight** (mobile only)
  - Loop mode (continuous until stopped)
  - Single-shot mode

#### Learning (exercises)
- Choose learning direction: **receiving** (Morse → text) or **transmitting** (text → Morse)
- Choose content scope: **letters**, **words**, or **sentences**
- Choose learning mode: **flashcards** or **keyboard**
- Set number of repetitions before starting
- Flashcard mode: swipe/tap left or right to mark correct/incorrect
- Keyboard mode: manually type the answer; shows correct answer on wrong input
- Live score tracker: correct vs. incorrect answers
- Timer showing time taken to complete the exercise

#### Reference material
- Theory about Morse code
- Downloadable documents (PDF) on-device

### 3.2 Flag Semaphore (Semafor / Signalizacija)

#### Translator
- Text → semaphore flag positions (displayed as images)
- Semaphore → text: user selects flag position images to compose text
- Zoom/magnifier to enlarge translated semaphore view to full screen
- Export translated result as file (web app only)

#### Reference material
- Theory about flag semaphore
- Downloadable documents on-device

#### Learning
- ⚠️ unclear: thesis lists semaphore learning as a future upgrade ("implementacija učenja semaforja"), but the semaphore section describes a home screen, translator, and documents — no learning exercises described as built

### 3.3 Orientation & Topography (Orientacija)

#### Reference material
- Theory: topography and orientation knowledge
- Material split into sub-groups: **maps (karte)**, **signs (znaki)**, **tools/aids (pripomočki)**, etc.
- Each sub-group shows separate documents
- Downloadable documents on-device

#### Learning (exercises)
- Learn topographic signs
- User selects which category groups to include in the exercise
- Same exercise mechanism as Morse code (flashcards / keyboard)
- ⚠️ unclear: thesis does not explicitly state whether keyboard mode was implemented for topographic signs or only flashcards

### 3.4 Home Screen

- Short description of the app
- Latest scout news/post fetched from backend (`post` table)
- "Read more" link opens the original news article in an in-app browser

### 3.5 Settings (Nastavitve)

- Change profile picture (locally stored)
- Set/change username (locally stored)
- Toggle dark / light theme
- Manage camera and notification permissions
- Delete all locally stored data
- View all libraries used in the app (open source attribution)
- View basic author information

### 3.6 Onboarding

- Intro/presentation screens shown only on **first launch**
- Controlled via local storage flag

### 3.7 General UI features

- Consistent in-app notifications/alerts
- Info button on each screen linking to contextual help
- Bottom navigation bar with 4 items: Morse, Semaphore, Orientation, Settings
- Dark mode and light mode

---

### Features listed as **"Coming Soon" / Planned but Unbuilt**

The thesis explicitly lists the following as future upgrade proposals (section 4.1):

1. **User accounts** — personalised accounts for progress saving and cloud sync
2. **Semaphore learning exercises** — interactive learning for semaphore (not built)
3. **Audio Morse code transmission** — sound-based transmission (works on all platforms)
4. **Scoring and knowledge levels** — gamification, progress levels
5. **Push notifications**
6. **Dynamic PDF generation** — generate PDFs from selected learning material
7. **Integration with Zveza tabornikov Slovenije** (Slovenian Scout Association)

---

## 4. DOMAIN KNOWLEDGE

### 4.1 Morse Code

Morse code encodes letters, digits, and punctuation as sequences of short signals (dots, `.`) and long signals (dashes, `-`). Transmitted via light, sound, or visual signals.

**In the app:**
- Translation is bidirectional: text ↔ Morse
- Exercises categorised by content: single **letters**, **words**, or **sentences**
- Exercise direction: **transmitting** (knowing the letter, produce the code) or **receiving** (seeing the code, produce the letter)
- Flashcard mode: card shows one side; user judges correctness by swiping
- Keyboard mode: user types the answer; app validates against correct translation
- Exercises for letters: generated by the app's own random letter function (no AI)
- Exercises for words and sentences: generated via ChatGPT (OpenAI API) — see section 4.4
- Fallback: pre-generated exercises stored in `morse_exercises` DB table used when OpenAI connection fails

**What "correct" means:**
- Keyboard mode: typed answer matches the expected translation exactly
- Flashcard mode: user self-reports correct/incorrect (no automated validation)

### 4.2 Flag Semaphore

Flag semaphore is a visual signalling system where each letter is represented by a specific arm/flag position. A sender holds two flags and positions their arms to spell out messages letter by letter.

**In the app:**
- Translation: input text converted to a sequence of flag position images
- Reverse: user taps flag position images to compose text
- ⚠️ unclear: the thesis does not describe what image assets are used for semaphore positions (static assets, SVG, generated images — unknown)
- No learning exercises implemented; listed as a future upgrade

**What "correct" means:** not applicable — only translator built, no exercise validation.

### 4.3 Topographic Signs (Orientacija / Topografija)

Topographic signs are standardised symbols used on maps to represent terrain features, human structures, and natural elements. Scouts must learn to read these signs for navigation and map reading.

**In the app:**
- Signs grouped into categories (karte, znaki, pripomočki, etc.)
- Each sign has: a name, an image, and a topographic group type
- Stored in the `orientation` DB table: `id`, `name`, `imageLoc`, `topoGroupType`
- Learning exercises: user selects category groups → random sign shown → user identifies it
- Exercise uses same flashcard/keyboard mechanism as Morse exercises

**What "correct" means:**
- Keyboard mode: typed answer matches the sign's name
- Flashcard mode: user self-reports

**Generation:** orientation exercises generated by `generateRandomOrientationTopoExercise` server function (no AI — draws from DB)

### 4.4 AI-Generated Exercises (ChatGPT Integration)

- Backend uses **OpenAI Chat Completion API** to generate Morse word and sentence exercises
- System prompt defines model behaviour and constrains its knowledge domain
- Assistant prompt dynamically built based on exercise type (letters/words/sentences, transmitting/receiving)
- Generated exercises are **saved to the `morse_exercises` PostgreSQL table** — grows the local fallback store over time
- Letters generated by a custom function (no AI) to reduce API dependency
- `extractJson` helper function parses AI responses
- Fallback: if OpenAI call fails, app uses previously stored exercises from the DB

---

## 5. CONTENT INVENTORY

### 5.1 Database Tables (PostgreSQL)

**`post`** — Scout news/announcements shown on home screen
- `id`, `title`, `content` (short summary), `link` (URL to original), `createdAt`, `updatedAt`

**`orientation`** — Topographic sign data
- `id`, `name`, `imageLoc` (file path to stored image), `topoGroupType` (enum — category group), `createdAt`, `updatedAt`

**`morse_exercises`** — Cached/generated Morse learning exercises
- `id`, `values` (exercise content), `length`, `translateType` (enum: Morse→text or text→Morse), `translatedValue`, `type` (enum: letter/word/sentence), `learningInterationType` (enum: cards/keyboard/interactive tokens), `areTranslationsCorrect` (boolean — important for flashcard mode), `createdAt`, `updatedAt`

**`migrations`** — TypeORM migration tracking
- `id`, `timestamp`, `name`

### 5.2 Enumerations Defined

- `TranslateType` — direction of translation (text→Morse or Morse→text)
- `type` — exercise content scope (letter / word / sentence)
- `learningInterationType` — learning mode (cards / keyboard / interactive tokens)
- `topoGroupType` — topographic sign category groups

⚠️ unclear: "interactive tokens" (`interaktivni žetoni`) is listed as a third learning mode in the enum and DB schema but is **never described as built or functional** in the thesis body — may be dead code or placeholder

### 5.3 Reference Documents (PDFs)

- PDF documents are bundled or downloadable within the app for each category:
  - Morse code theory + reference sheet
  - Semaphore theory + reference sheet
  - Orientation/topography theory (split by sub-group)
- A **PDF viewer widget** is described as a reusable Flutter widget
- ⚠️ unclear: whether PDFs are embedded assets in the Flutter app, fetched from the backend, or external URLs

### 5.4 Semaphore Images

- Flag position images used in the semaphore translator
- ⚠️ unclear: source format and storage location not described in thesis

### 5.5 Topographic Sign Images

- Stored as files referenced by `imageLoc` column in the `orientation` table
- ⚠️ unclear: whether images are served from the backend or bundled in the Flutter app

### 5.6 Figma Design Assets

- Wireframes: mobile and web versions
- Final mockups: all screens in both dark and light mode
- Colour scheme: 5 colours — primary purple (WOSM official colour), forest green (nature/scouting), plus 3 additional colours
- Stored in Google Drive: DIPLOMSKA NALOGA → Figma

---

## 6. PLANNED vs. BUILT

### Built (confirmed by thesis)

| Feature | Platform |
|---|---|
| Morse translator (text ↔ Morse) | Android, iOS, Web |
| Morse flashlight transmitter | Android, iOS only |
| Morse learning — letters, words, sentences | Android, iOS |
| Morse learning — flashcard mode | Android, iOS |
| Morse learning — keyboard mode | Android, iOS |
| Live score + timer in exercises | Android, iOS |
| Semaphore translator (text → flag images) | Android, iOS, Web |
| Semaphore reverse (flags → text) | Android, iOS, Web |
| Semaphore zoom/magnifier | Android, iOS |
| Topography reference material (grouped sub-categories) | Android, iOS, Web |
| Topography learning exercises | Android, iOS |
| Home screen with latest news post | Android, iOS, Web |
| Settings (profile, theme, permissions, delete data) | Android, iOS |
| Onboarding / intro screens | Android, iOS |
| Dark / light theme | Android, iOS |
| In-app PDF viewer | Android, iOS |
| PDF/file export of translated content | Web only |
| In-app browser for news links | Android, iOS |
| Consistent in-app notification/alert system | Android, iOS |
| Open source library attribution screen | Android, iOS |
| Backend API (Express.js + PostgreSQL) | Server |
| AI exercise generation via OpenAI Chat Completion API | Server |
| Swagger API documentation | Server |
| Backend unit tests (jest + jest-mock-extended) | Server |

### Planned / Unbuilt (confirmed by thesis as future work)

| Feature | Notes |
|---|---|
| Semaphore learning exercises | Explicitly listed as future upgrade |
| User accounts + cloud sync | Explicitly listed as future upgrade |
| Audio Morse transmission | Explicitly listed as future upgrade |
| Scoring / gamification / levels | Explicitly listed as future upgrade |
| Push notifications | Explicitly listed as future upgrade |
| Dynamic PDF generation | Explicitly listed as future upgrade |
| Zveza tabornikov Slovenije integration | Explicitly listed as future upgrade |
| Interactive tokens learning mode | In DB enum but never described as functional — ⚠️ unclear: possibly dead code |

---

## 7. SUCCESS CRITERIA

The thesis defines completion as (sections 1.2 and 4):

1. A **functional mobile and web app** delivering all listed functionalities (Morse, semaphore, orientation)
2. Successful use of **Flutter** for cross-platform development (Android, iOS, Web from one codebase)
3. Analysis of Flutter's suitability for different cross-platform use cases

The conclusion states explicitly: *"Pri implementaciji smo izpolnili vse tehnične zahteve, zastavljene v dispoziciji diplomskega dela."* — All technical requirements from the thesis specification were fulfilled.

Concrete measurable criteria from the thesis:

- App runs on **Android, iOS, and Web** from a single Flutter codebase
- Morse code: translator + flashlight transmission + exercises (letters/words/sentences, two directions, two learning modes)
- Semaphore: translation in both directions
- Orientation: browsable reference material (grouped) + topographic sign learning exercises
- Settings: profile picture, username, theme toggle, permissions, data deletion
- Code quality: modular structure, BloC state management, backend unit tests

### Platform analysis summary (section 4.2)

| Platform | Status | Limitations noted |
|---|---|---|
| Android | All features functional | None |
| iOS | All features functional | Flashlight required separate permission config; physical device testing requires paid Apple Developer account |
| Web | Functional with adaptations | Flashlight not available; file export adapted; local storage and data transfer adapted |

---

*End of THESIS.md*
