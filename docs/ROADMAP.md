# ROADMAP.md — Taborniški S.O.S Priročnik
**Role:** Planner — sequencing only. No design decisions, no code.
**Generated:** 2026-04-04

---

## Migration Checklist

---

### GROUP 0 — Verification

- [ ] VERIFICATION | MORSE | #1 ⚑ Verify LearningKeyboard is complete; add `MorseCodeValidation.partial` to domain validation enum; confirm index state lives in AsyncNotifier (not StatefulWidget); confirm `morse_pattern_display.dart` supports inline use inside a bottom sheet
    Depends on: nothing
    Acceptance: `MorseCodeValidation` enum has three values (`correct`, `incorrect`, `partial`); no local StatefulWidget state holds current index; `morse_pattern_display.dart` can be embedded in a bottom sheet without layout errors

---

### GROUP 1 — Core Database

- [ ] CORE | DATABASE | Define `AppDatabase` Drift class registering all 6 tables (`posts`, `morse_exercises`, `semaphore_exercises`, `orientation_signs`, `user_preferences`, `exercise_history`) and create `database_provider.dart` (`appDatabaseProvider`)
    Depends on: nothing (table class files may be stubs at this point)
    Acceptance: `AppDatabase` compiles with all 6 tables listed; `appDatabaseProvider` returns the singleton; `flutter pub run build_runner build` passes

- [ ] CORE | DATABASE | Create `ISeeder` abstract interface (`Future<void> seed(AppDatabase db)`) and `AppSeeder` orchestrator that runs sub-seeders in fixed order: `UserPreferencesSeeder` → `OrientationSeeder` → `MorseCorpusSeeder` → `SemaphoreCorpusSeeder`
    Depends on: #2 (AppDatabase)
    Acceptance: `AppSeeder.run(db)` calls all four seeders in declared order; seeding is skipped if `user_preferences` row count is non-zero

---

### GROUP 2 — Core Constants & Theme

- [ ] CORE | CONSTANTS | Create `app_colors.dart`, `app_typography.dart`, `app_spacing.dart` from DESIGN.md tokens
    Depends on: nothing
    Acceptance: All files export named `const` values only; no hardcoded colors anywhere else in new code

- [ ] CORE | THEME | Create `app_theme.dart` — `ThemeData` factory for light and dark modes consuming `AppColors` and `AppTypography`
    Depends on: #4 (constants)
    Acceptance: `AppTheme.light()` and `AppTheme.dark()` return valid `ThemeData`; no hardcoded colors inside the factory

---

### GROUP 3 — Shared Domain Value Objects (needed by seeders)

- [ ] DOMAIN | MORSE | Create value object enums: `TranslationDirection` (textToMorse / morseToText), `ExerciseContentType` (letters / words / sentences), `InteractionType` (cards / keyboard / tokens)
    Depends on: nothing (pure Dart)
    Acceptance: Enums are in `features/morse/domain/value_objects/`; zero Flutter imports; used by Drift `textEnum<>()` columns

- [ ] DOMAIN | ORIENTATION | Create `TopoGroupType` enum with 8 canonical values matching Flutter asset folder names (`geodetskeTocke`, `mejeInOgraje`, `morjeInMorskaObala`, `naseljaInObjekti`, `prometKomunikacije`, `rastjeInVrsteTal`, `relief`, `vodovje`)
    Depends on: nothing (pure Dart)
    Acceptance: Enum lives in `features/orientation/domain/value_objects/topo_group_type.dart`; corrupt PostgreSQL values (`meje_in_morska_obala`, `promet`) are absent

---

### GROUP 4 — Drift Table Definitions

- [ ] DATA | SETTINGS | Create `user_preferences_table.dart` Drift table: `id` (PK always 1), `theme_mode` (textEnum AppThemeMode, default dark), `username` (nullable text), `avatar_id` (nullable text), `onboarding_seen` (boolean, default false)
    Depends on: #2 (AppDatabase), `AppThemeMode` enum (defined with UserPreferences entity or standalone)
    Acceptance: Table is registered in `AppDatabase`; `flutter pub run build_runner build` succeeds

- [ ] DATA | MORSE | Create `morse_exercises_table.dart` Drift table: `id`, `exercise_content_type` (textEnum), `translate_type` (textEnum), `values` (text JSON array), `translated_values` (text JSON array), `count` (integer), `interaction_type` (textEnum)
    Depends on: #2, #6 (value object enums)
    Acceptance: Table registered in `AppDatabase`; build_runner succeeds

- [ ] DATA | SEMAPHORE | Create `semaphore_exercises_table.dart` — mirrors `morse_exercises` schema exactly; register in `AppDatabase`
    Depends on: #2, #6
    Acceptance: Table registered; build_runner succeeds

- [ ] DATA | ORIENTATION | Create `orientation_signs_table.dart` Drift table: `id`, `name` (text), `image_loc` (text), `topo_group_type` (textEnum TopoGroupType); register in `AppDatabase`
    Depends on: #2, #7 (TopoGroupType)
    Acceptance: Table registered; build_runner succeeds

- [ ] DATA | HOME | Create `posts_table.dart` Drift table: `id`, `title`, `content`, `link`, `created_at` (integer Unix ms); register in `AppDatabase`
    Depends on: #2
    Acceptance: Table registered; build_runner succeeds

- [ ] DATA | EXERCISE_HISTORY | Create `exercise_history_table.dart` Drift table: `id`, `feature_type` (textEnum FeatureType), `exercise_content_type` (text), `interaction_type` (text), `total_questions`, `correct_count`, `session_date` (integer Unix ms), `duration_seconds`; add `FeatureType` enum (morse / semaphore / orientation)
    Depends on: #2
    Acceptance: Table registered; `FeatureType` enum in `features/exercise_history/domain/`; build_runner succeeds

---

### GROUP 5 — Seeders

- [ ] CORE | SEEDER | Implement `UserPreferencesSeeder` — inserts exactly one row: `{ id: 1, themeMode: dark, username: null, avatarId: null, onboardingSeen: false }`
    Depends on: #3 (ISeeder), #8 (user_preferences_table)
    Acceptance: Seeder inserts exactly one row; running a second time is a no-op (AppSeeder skips if row count > 0)

- [ ] CORE | SEEDER | Implement `MorseCorpusSeeder` — reads `assets/data/morse_corpus.json`, maps each entry to `MorseExercisesCompanion`, batch inserts all rows in a single Drift transaction
    Depends on: #3, #9 (morse_exercises_table), #6 (value object enums)
    Acceptance: After seeder runs, `morse_exercises` contains words and sentences rows; letter rows are absent (generated at runtime)

- [ ] CORE | SEEDER | Implement `SemaphoreCorpusSeeder` — identical algorithm to MorseCorpusSeeder; reads `assets/data/semaphore_corpus.json`; inserts into `semaphore_exercises`
    Depends on: #3, #10 (semaphore_exercises_table), #6
    Acceptance: `semaphore_exercises` is populated after seeder runs

- [ ] CORE | SEEDER | Implement `OrientationSeeder` — loads `AssetManifest.json` via `rootBundle`; filters keys matching `assets/images/topografija/**`; maps folder segment to `TopoGroupType` via hardcoded folder-to-enum table; looks up Slovenian display names from bundled `Map<String, String>`; batch inserts into `orientation_signs` in one transaction
    Depends on: #3, #11 (orientation_signs_table), #7 (TopoGroupType)
    Acceptance: After seeder runs, `orientation_signs` has ~230 rows; all `topo_group_type` values are valid enum members; corrupt PostgreSQL values are absent

---

### GROUP 6 — Settings Domain

- [ ] DOMAIN | SETTINGS | Create `UserPreferences` entity (freezed, pure Dart): `{ themeMode: AppThemeMode, username: String?, avatarId: String?, onboardingSeen: bool }`; create `AppThemeMode` enum (dark / light / system)
    Depends on: nothing (pure Dart)
    Acceptance: Entity in `features/settings/domain/entities/`; zero Flutter imports; `freezed` generates correctly

- [ ] DOMAIN | SETTINGS | Create `IUserPreferencesRepository` interface; create `GetUserPreferencesUseCase` and `SaveUserPreferencesUseCase`
    Depends on: #18 (UserPreferences entity)
    Acceptance: Both use cases have one public method (`call`); no Flutter imports; interfaces are abstract

---

### GROUP 7 — Onboarding Domain

- [ ] DOMAIN | ONBOARDING | Create `MarkOnboardingSeenUseCase` — delegates to `IUserPreferencesRepository.save(onboardingSeen: true)`
    Depends on: #19 (IUserPreferencesRepository)
    Acceptance: Use case in `features/onboarding/domain/usecases/`; pure Dart; no direct repository implementation import

---

### GROUP 8 — Settings Data

- [ ] DATA | SETTINGS | Implement `UserPreferencesRepository` (implements `IUserPreferencesRepository`) using Drift; create `AppThemeMode` ↔ DB string mapper; `get()` returns `UserPreferences`; `save()` upserts row with `id = 1`
    Depends on: #8 (user_preferences_table), #19 (interface + entity)
    Acceptance: Repository compiles; `save()` upserts correctly; mapper handles all `AppThemeMode` values

---

### GROUP 9 — Routing

- [ ] CORE | ROUTING | Create `route_names.dart` with all route name string constants matching the navigation tree in ARCHITECTURE.md §4
    Depends on: nothing
    Acceptance: Every route in the navigation tree has a constant; no magic strings elsewhere

- [ ] CORE | ROUTING | Create `app_router.dart` (GoRouter) with all routes from ARCHITECTURE.md §4; create `onboarding_guard.dart` that redirects `/` and `/onboarding` based on `onboardingSeenProvider`; wire session-screen guards (redirect to selector if `extra` is null)
    Depends on: #22 (route_names), #26 (onboardingSeenProvider must exist)
    Acceptance: Router compiles; navigating to `/` redirects based on onboarding state; session routes redirect to selector when `extra` is null

---

### GROUP 10 — Settings & Onboarding Presentation Providers

- [ ] PRESENTATION | SETTINGS | Create `userPreferencesRepositoryProvider` (injects `UserPreferencesRepository`) and `userPreferencesProvider` (`AsyncNotifier<UserPreferences>` with `update(partial)`)
    Depends on: #21 (UserPreferencesRepository), #19 (use cases)
    Acceptance: Provider resolves without error on app start; `update()` persists change via use case

- [ ] PRESENTATION | ONBOARDING | Create `onboardingSeenProvider` (`FutureProvider<bool>`) reading `UserPreferences.onboardingSeen` via `userPreferencesRepositoryProvider`
    Depends on: #25 (userPreferencesRepositoryProvider)
    Acceptance: Provider returns correct bool; router guard watches it without crashing during loading state

---

### GROUP 11 — Core Shared Widgets

- [ ] CORE | WIDGETS | Implement `app_header_bar.dart`, `bottom_nav_bar.dart`, `primary_cta_button.dart`, `primary_action_card.dart`, `hero_banner_card.dart` per DESIGN.md §4.2, 4.1, 4.9, 4.3, 4.4
    Depends on: #4 (constants), #5 (theme)
    Acceptance: All widgets render without errors; no hardcoded colors; zero business logic inside widgets

- [ ] CORE | WIDGETS | Implement `segmented_control.dart`, `filter_chip_row.dart`, `content_selector.dart`, `repetition_chip_selector.dart`, `progress_dots_row.dart`, `exercise_action_buttons.dart`, `feedback_bottom_sheet.dart` per DESIGN.md §4.6–4.8, 4.10, 4.14–4.16
    Depends on: #4, #5
    Acceptance: All widgets render without errors; no hardcoded colors; zero business logic inside widgets

---

### GROUP 12 — Settings & Onboarding Screens

- [ ] PRESENTATION | SETTINGS | Implement `settings_screen.dart`, `profile_hero.dart` (DESIGN.md 4.18), `settings_row.dart` (4.19), `danger_zone_card.dart` (4.21)
    Depends on: #25 (userPreferencesProvider), #27, #28 (core widgets)
    Acceptance: Settings screen reads and writes `UserPreferences` via provider; permissions row is absent on web; no hardcoded colors

- [ ] PRESENTATION | ONBOARDING | Implement `onboarding_screen.dart` and `onboarding_slide.dart` (DESIGN.md 4.27); wire `MarkOnboardingSeenUseCase` on final slide confirmation
    Depends on: #26 (onboardingSeenProvider), #20 (MarkOnboardingSeenUseCase), #27
    Acceptance: Completing onboarding sets `onboardingSeen = true`; router guard redirects to `/home` on next navigation

---

### GROUP 13 — Home Domain & Data

- [ ] DOMAIN | HOME | Create `Post` entity (freezed); `IPostRepository` interface; `GetLatestPostUseCase`; `FetchAndCachePostUseCase`
    Depends on: nothing (pure Dart)
    Acceptance: Entities and interfaces in `features/home/domain/`; zero Flutter imports

- [ ] DATA | HOME | Implement `PostRepository` (implements `IPostRepository`) using Drift; create `post_mapper.dart`; `cachePost()` deletes previous row and inserts new one in one transaction
    Depends on: #12 (posts_table), #31 (IPostRepository + entity)
    Acceptance: `getLatest()` returns `Post?`; replace-on-cache behaviour works in a single transaction

---

### GROUP 14 — Home Presentation

- [ ] PRESENTATION | HOME | Create `postRepositoryProvider` and `latestPostProvider` (`AsyncNotifier<Post?>` with `refresh()`)
    Depends on: #32 (PostRepository), #31 (use cases)
    Acceptance: Returns `null` when no cached post exists; `refresh()` triggers network fetch and caches result

- [ ] PRESENTATION | HOME | Implement `home_screen.dart` and `news_card.dart` (DESIGN.md 4.25)
    Depends on: #33 (latestPostProvider), #27 (core widgets)
    Acceptance: Shows cached post if available; shows empty state if provider is null; no crash when offline

---

### GROUP 15 — Morse Domain

- [ ] DOMAIN | MORSE | Create `MorseEntry` entity `{ character, morseSequence }` (freezed) and `MorseExercise` entity `{ values[], translatedValues[], areCorrect[] }` (freezed)
    Depends on: #6 (value object enums)
    Acceptance: Entities in `features/morse/domain/entities/`; zero Flutter imports

- [ ] DOMAIN | MORSE | Create `IMorseTranslationRepository` and `IMorseExerciseRepository` interfaces
    Depends on: #35 (entities), #6
    Acceptance: Both interfaces are abstract; in `features/morse/domain/repositories/`

- [ ] DOMAIN | MORSE | Implement `TranslateMorseUseCase` and `ValidateMorseAnswerUseCase` (uses `MorseCodeValidation` enum including `.partial` from #1)
    Depends on: #36 (interfaces), #35 (entities), #1 (MorseCodeValidation.partial)
    Acceptance: Use cases have one public method; `ValidateMorseAnswerUseCase` returns `.partial` for incomplete answers

- [ ] DOMAIN | MORSE | Implement `GenerateLetterExerciseUseCase` (local random A–Z, not persisted) and `GetCorpusExerciseUseCase` (fetches words/sentences via `IMorseExerciseRepository`)
    Depends on: #36, #35, #6
    Acceptance: Letter use case generates without DB access; corpus use case delegates to interface only

---

### GROUP 16 — Morse Data

- [ ] DATA | MORSE | Create `MorseDictionary` — static `Map<String, String>` of A–Z + Š/Č/Ž + 0–9 to morse sequences
    Depends on: nothing
    Acceptance: All standard characters mapped; file in `features/morse/data/sources/`

- [ ] DATA | MORSE | Create `MorseCorpusLoader` (reads `assets/data/morse_corpus.json`); implement `MorseTranslationRepository` (wraps `MorseDictionary`) and `MorseExerciseRepository` (queries Drift); create `morse_exercise_mapper.dart`
    Depends on: #9 (morse_exercises_table), #36 (interfaces), #35 (entities), #39 (MorseDictionary)
    Acceptance: `MorseTranslationRepository.lookup(char)` returns morse sequence; `MorseExerciseRepository.getByType()` returns matching rows; mapper converts Drift row ↔ entity

---

### GROUP 17 — Morse Presentation

- [ ] PRESENTATION | MORSE | Create `morseTranslationRepositoryProvider` and `morseExerciseRepositoryProvider`
    Depends on: #40 (repository implementations), #2 (appDatabaseProvider)
    Acceptance: Both providers resolve without error; implementations are injected — not instantiated inside notifiers

- [ ] PRESENTATION | MORSE | Create `morseTranslationProvider` (`Notifier<MorseTranslationState>` — state: `{ input, output, direction, isTransmitting, isAutoRepeating, torchError }`); torch cancellation uses CancelToken-style flag (no `bloc_concurrency`)
    Depends on: #41 (morseTranslationRepositoryProvider), #37 (TranslateMorseUseCase)
    Acceptance: Translation is synchronous local computation; starting a new transmission cancels the previous one; state is not split across multiple notifiers

- [ ] PRESENTATION | MORSE | Create `morseExerciseProvider` (`AsyncNotifier<MorseExerciseState>` — state: `{ questions[], translatedQuestions[], areCorrect[], currentIndex, userResults[] }`; methods: `start(params)`, `validate(answer)`, `undo()`, `next()`); index state lives in notifier — not in any widget
    Depends on: #41, #37, #38 (use cases)
    Acceptance: `validate()` uses `ValidateMorseAnswerUseCase` and updates `areCorrect[]`; `undo()` steps back one index; state survives hot reload

- [ ] PRESENTATION | MORSE | Implement `morse_pattern_display.dart` (DESIGN.md 4.12) and `morse_list_item.dart` (DESIGN.md 4.11)
    Depends on: #4 (constants), #35 (MorseEntry entity)
    Acceptance: `morse_pattern_display` works inline inside a bottom sheet (verifies #1 acceptance); `morse_list_item` renders dots/dashes correctly

- [ ] PRESENTATION | MORSE | Implement `learning_cards_widget.dart` (DESIGN.md 4.13) and `learning_keyboard_widget.dart` (migrated from existing LearningKeyboard per #1)
    Depends on: #43 (morseExerciseProvider), #44 (morse_pattern_display), #27, #28
    Acceptance: Cards widget swipes to next question; keyboard widget routes input to provider; no local StatefulWidget index state in either widget

- [ ] PRESENTATION | MORSE | Implement `morse_screen.dart`, `morse_translator_screen.dart`, `morse_materials_screen.dart`, `morse_exercise_selector_screen.dart`, `morse_exercise_screen.dart` (selects cards or keyboard sub-widget based on `InteractionType`)
    Depends on: #42, #43, #44, #45, #27, #28
    Acceptance: All screens navigate via named routes; `morse_exercise_screen` selects correct sub-widget at runtime; no data/ imports in any screen

- [ ] PRESENTATION | MORSE | Implement `transmitter_controls.dart` (DESIGN.md 4.17) and `flashlight_transmitter_screen.dart` (DESIGN.md 4.24) — torch button rendered disabled when `IPlatformFeatures.isTorchAvailable` is false
    Depends on: #42 (morseTranslationProvider), #68 (platformFeaturesProvider — GROUP 25)
    Acceptance: Torch button is visible but disabled on web; audio transmitter works on all platforms; no throw/crash on web

---

### GROUP 18 — Semaphore Domain

- [ ] DOMAIN | SEMAPHORE | Create `SemaphoreEntry` entity `{ character, flagImagePath }` (freezed) and `SemaphoreExercise` entity (same shape as `MorseExercise`) (freezed)
    Depends on: #6 (value objects)
    Acceptance: Entities in `features/semaphore/domain/entities/`; zero Flutter imports

- [ ] DOMAIN | SEMAPHORE | Create `ISemaphoreTranslationRepository` and `ISemaphoreExerciseRepository` interfaces
    Depends on: #48 (entities)
    Acceptance: Interfaces are abstract; in `features/semaphore/domain/repositories/`

- [ ] DOMAIN | SEMAPHORE | Implement `TranslateSemaphoreUseCase`, `GetSemaphoreExerciseUseCase`, `ValidateSemaphoreAnswerUseCase`
    Depends on: #49 (interfaces), #48 (entities)
    Acceptance: Use cases mirror Morse shapes; each has one public method; no Flutter imports

---

### GROUP 19 — Semaphore Data

- [ ] DATA | SEMAPHORE | Create `SemaphoreDictionary` (static character → asset image path map) and `SemaphoreCorpusLoader` (reads `assets/data/semaphore_corpus.json`)
    Depends on: nothing
    Acceptance: Dictionary maps all characters to flag image asset paths; loader parses JSON correctly

- [ ] DATA | SEMAPHORE | Implement `SemaphoreTranslationRepository` and `SemaphoreExerciseRepository` (implement interfaces); create `semaphore_exercise_mapper.dart`
    Depends on: #10 (semaphore_exercises_table), #49 (interfaces), #48 (entities), #51 (SemaphoreDictionary)
    Acceptance: Repositories compile; mapper converts Drift row ↔ entity

---

### GROUP 20 — Semaphore Presentation

- [ ] PRESENTATION | SEMAPHORE | Create `semaphoreTranslationRepositoryProvider`, `semaphoreExerciseRepositoryProvider`, `semaphoreTranslationProvider` (`Notifier`), `semaphoreExerciseProvider` (`AsyncNotifier`) — mirror Morse provider shapes exactly
    Depends on: #52 (repository implementations), #50 (use cases)
    Acceptance: All four providers resolve; `semaphoreExerciseProvider` exposes same interface shape as `morseExerciseProvider`

- [ ] PRESENTATION | SEMAPHORE | Implement `semaphore_flag_display.dart`, `semaphore_list_item.dart`, `semaphore_screen.dart`, `semaphore_translator_screen.dart`, `semaphore_materials_screen.dart`, `semaphore_exercise_selector_screen.dart`, `semaphore_exercise_screen.dart`
    Depends on: #53 (providers), #27, #28
    Acceptance: Flag images load from assets; all screens navigate via named routes; exercise screen selects cards or keyboard mode; no data/ imports in screens

---

### GROUP 21 — Orientation Domain

- [ ] DOMAIN | ORIENTATION | Create `OrientationSign` entity `{ id, name, imageLoc, topoGroupType }` (freezed)
    Depends on: #7 (TopoGroupType)
    Acceptance: Entity in `features/orientation/domain/entities/`; zero Flutter imports

- [ ] DOMAIN | ORIENTATION | Create `IOrientationRepository` interface
    Depends on: #55 (OrientationSign entity)
    Acceptance: Interface is abstract; exposes methods for fetching signs by group and for exercise queries

- [ ] DOMAIN | ORIENTATION | Implement `GetOrientationExerciseUseCase` (shuffle + 50% name swap logic) and `ValidateOrientationAnswerUseCase`
    Depends on: #56 (interface), #55 (entity)
    Acceptance: Shuffle and name-swap logic lives inside the use case; no Flutter imports; each use case has one public method

---

### GROUP 22 — Orientation Data

- [ ] DATA | ORIENTATION | Implement `OrientationRepository` (implements `IOrientationRepository`) using Drift; create `orientation_sign_mapper.dart`
    Depends on: #11 (orientation_signs_table), #56 (interface), #55 (entity)
    Acceptance: `getByGroup(type)` returns filtered list; mapper converts Drift row ↔ entity

---

### GROUP 23 — Orientation Presentation

- [ ] PRESENTATION | ORIENTATION | Create `orientationRepositoryProvider`, `orientationCategoryFilterProvider` (`StateProvider<Set<TopoGroupType>>` — all 8 categories selected by default), `orientationExerciseProvider` (`AsyncNotifier<OrientationExerciseState>` — state: `{ names[], imageLocs[], areCombinationsCorrect[], currentIndex, userResults[] }`; methods: `start(params)`, `validate(answer)`, `undo()`, `next()`)
    Depends on: #58 (OrientationRepository), #57, #56 (use cases)
    Acceptance: Filter provider defaults to all 8 categories; exercise provider index state lives in notifier; no local StatefulWidget state

- [ ] PRESENTATION | ORIENTATION | Implement `topo_sign_card.dart` (DESIGN.md 4.22) and `category_checkbox_row.dart`
    Depends on: #59 (orientationCategoryFilterProvider), #4 (constants)
    Acceptance: Topo card renders image from asset path; checkbox row toggles `orientationCategoryFilterProvider`

- [ ] PRESENTATION | ORIENTATION | Implement `orientation_screen.dart`, `orientation_exercise_selector_screen.dart`, `orientation_exercise_screen.dart`
    Depends on: #59, #60, #61, #27, #28
    Acceptance: Exercise screen reads from `orientationExerciseProvider`; no data/ imports; navigates via named routes

- [ ] PRESENTATION | ORIENTATION | Implement `orientation_reference_screen.dart` — renders bundled Markdown/JSON content for Naloge na karti / terenu / tekmovanjih / Okolje; unknown `categoryId` path param shows empty-state placeholder without crashing
    Depends on: #23 (app_router with `/orientation/reference/:categoryId` route)
    Acceptance: All 4 known categories render text content; unknown `categoryId` shows empty state; no exception thrown

- [ ] PRESENTATION | ORIENTATION | Implement `pdf_viewer_screen.dart` — receives `IPdfViewer` via provider injection; does not import `PdfViewerMobile` or `PdfViewerWeb` directly
    Depends on: #70 (IPdfViewer — GROUP 25), #23 (routing)
    Acceptance: Screen compiles without importing either concrete class; navigates back correctly on both platforms

---

### GROUP 24 — Exercise History

- [ ] DOMAIN | EXERCISE_HISTORY | Create `ExerciseSession` entity (freezed); `IExerciseHistoryRepository` interface; `SaveExerciseSessionUseCase`; `GetExerciseHistoryUseCase`
    Depends on: nothing (pure Dart)
    Acceptance: Entity and interfaces in `features/exercise_history/domain/`; zero Flutter imports

- [ ] DATA | EXERCISE_HISTORY | Implement `ExerciseHistoryRepository` (implements `IExerciseHistoryRepository`) using Drift
    Depends on: #13 (exercise_history_table), #64 (interface + entity)
    Acceptance: `save(session)` appends a row; `getAll()` returns list ordered by `session_date` descending

- [ ] PRESENTATION | EXERCISE_HISTORY | Create `exerciseHistoryRepositoryProvider` and `exerciseHistoryProvider` (`AsyncNotifier<List<ExerciseSession>>` with `save(session)`); exercise screen providers call `save()` on session completion
    Depends on: #65 (ExerciseHistoryRepository), #64 (use cases)
    Acceptance: `save()` calls use case and refreshes list; history list updates after each completed session

- [ ] PRESENTATION | EXERCISE_HISTORY | Implement `history_session_card.dart` (DESIGN.md 4.23)
    Depends on: #66 (exerciseHistoryProvider), #4 (constants)
    Acceptance: Card renders `ExerciseSession` fields; no business logic inside the widget

---

### GROUP 25 — Platform Services

- [ ] CORE | PLATFORM | Create `IPlatformFeatures` interface (`isTorchAvailable`, `isFileDownloadAvailable`, `isPdfViewerNative`, `isPermissionHandlerAvailable`); implement `MobilePlatformFeatures` and `WebPlatformFeatures`; create `platformFeaturesProvider` (resolves via `kIsWeb`)
    Depends on: nothing
    Acceptance: `platformFeaturesProvider` returns `WebPlatformFeatures` when `kIsWeb` is true; no platform SDK imports inside the interface file

- [ ] CORE | PLATFORM | Create `ITorchService` interface; implement `TorchServiceMobile` (wraps `torch_light`) and `TorchServiceStub` (all no-ops, `isAvailable` → false); create `torchServiceProvider`
    Depends on: #68 (IPlatformFeatures)
    Acceptance: Web resolves stub; mobile resolves real service; torch button in transmitter controls reads this provider

- [ ] CORE | PLATFORM | Create `IPdfViewer` interface; implement `PdfViewerMobile` (wraps `flutter_pdfview`) and `PdfViewerWeb` (opens via `url_launcher`); wire via provider to `pdf_viewer_screen.dart`
    Depends on: #68 (IPlatformFeatures)
    Acceptance: Mobile renders native PDF; web opens browser; `pdf_viewer_screen.dart` imports only `IPdfViewer`

- [ ] CORE | PLATFORM | Create `IFileExportService` interface; implement `FileExportMobile` (wraps `open_filex`) and `FileExportWeb` (wraps `flutter_file_saver`); create `fileExportServiceProvider`; PDF generation via `pdf` package runs on both platforms
    Depends on: #68 (IPlatformFeatures)
    Acceptance: Web exposes download button; mobile does not; delivery mechanism is platform-conditional; PDF generation is shared

- [ ] CORE | PLATFORM | Create `IPermissionService` interface; implement `PermissionServiceMobile` (wraps `permission_handler`) and `PermissionServiceStub` (all queries return `granted`); settings screen permissions row absent on web
    Depends on: #68 (IPlatformFeatures)
    Acceptance: Web stub never calls `permission_handler`; settings screen checks `isPermissionHandlerAvailable` before rendering the row

---

### GROUP 26 — Entry Point

- [ ] CORE | MAIN | Wire `main.dart`: `ProviderScope` root with all repository provider overrides; call `AppSeeder.run(db)` before first widget frame; attach `AppRouter` to `MaterialApp.router`; apply `AppTheme`
    Depends on: all repository providers (#25, #33, #41, #53, #58, #65–#66, #68–#72), #3 (AppSeeder), #23 (app_router), #5 (app_theme)
    Acceptance: App starts cold; seeder runs once; router redirects correctly based on onboarding state; all providers resolve without override errors

---

## Dependency Summary

```
#1  (LearningKeyboard verification)
 └─ unblocks: #37 (ValidateMorseAnswerUseCase uses .partial), #45 (keyboard widget migration)

#2  (AppDatabase) ← #3, #8–#13
#3  (ISeeder + AppSeeder) ← #14–#17
#6  (value object enums) ← #9, #10, #35–#38
#7  (TopoGroupType) ← #11, #17
#18 (UserPreferences entity) ← #19, #25
#19 (IUserPreferencesRepository) ← #21, #20, #25, #26
#21 (UserPreferencesRepository) ← #25
#25, #26 (Settings/Onboarding providers) ← #23 (router guard)
#35 (Morse entities) ← #36–#38, #40
#36 (Morse interfaces) ← #40–#46
#48 (Semaphore entities) ← #49–#53
#55 (OrientationSign entity) ← #56–#62
#64 (ExerciseSession entity) ← #65–#67
#68 (IPlatformFeatures) ← #69–#72
#73 (main.dart) ← everything
```

---

*End of ROADMAP.md*
*Role: Planner — sequencing only*
