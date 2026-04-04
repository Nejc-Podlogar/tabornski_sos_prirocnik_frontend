# ARCHITECTURE.md — Taborniški S.O.S Priročnik

**Role:** Architect — structure only. No implementation code.
**Sources read:** CLAUDE.mdx, DESIGN.md, docs/ANALYSIS.md, docs/FRONTEND.md, docs/DESIGNS.md

---

## 1. FOLDER STRUCTURE

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart            ← DESIGN.md color tokens (all Color constants)
│   │   ├── app_typography.dart        ← DESIGN.md type scale constants
│   │   └── app_spacing.dart           ← DESIGN.md spacing scale constants
│   ├── database/
│   │   ├── app_database.dart          ← Drift database class — all tables registered
│   │   ├── database_provider.dart     ← appDatabaseProvider (root singleton)
│   │   └── seeder/
│   │       ├── i_seeder.dart          ← abstract interface: Future<void> seed(db)
│   │       ├── app_seeder.dart        ← orchestrates all seeders on first launch
│   │       ├── orientation_seeder.dart
│   │       ├── morse_corpus_seeder.dart
│   │       ├── semaphore_corpus_seeder.dart
│   │       └── user_preferences_seeder.dart
│   ├── platform/
│   │   ├── i_platform_features.dart   ← abstract interface: feature availability flags
│   │   ├── mobile_platform_features.dart
│   │   ├── web_platform_features.dart
│   │   ├── platform_features_provider.dart
│   │   ├── torch/
│   │   │   ├── i_torch_service.dart
│   │   │   ├── torch_service_mobile.dart
│   │   │   └── torch_service_stub.dart
│   │   ├── pdf/
│   │   │   ├── i_pdf_viewer.dart
│   │   │   ├── pdf_viewer_mobile.dart
│   │   │   └── pdf_viewer_web.dart
│   │   ├── export/
│   │   │   ├── i_file_export_service.dart
│   │   │   ├── file_export_mobile.dart
│   │   │   └── file_export_web.dart
│   │   └── permissions/
│   │       ├── i_permission_service.dart
│   │       ├── permission_service_mobile.dart
│   │       └── permission_service_stub.dart
│   ├── theme/
│   │   └── app_theme.dart             ← ThemeData factory (light + dark) consuming app_colors
│   ├── routing/
│   │   ├── app_router.dart            ← GoRouter instance (all routes)
│   │   ├── route_names.dart           ← all route name constants
│   │   └── guards/
│   │       └── onboarding_guard.dart  ← redirect logic reading onboardingSeenProvider
│   └── widgets/
│       ├── app_header_bar.dart        ← DESIGN.md 4.2
│       ├── bottom_nav_bar.dart        ← DESIGN.md 4.1
│       ├── primary_cta_button.dart    ← DESIGN.md 4.9
│       ├── primary_action_card.dart   ← DESIGN.md 4.3
│       ├── hero_banner_card.dart      ← DESIGN.md 4.4
│       ├── filter_chip_row.dart       ← DESIGN.md 4.10
│       ├── content_selector.dart      ← DESIGN.md 4.7
│       ├── repetition_chip_selector.dart ← DESIGN.md 4.8
│       ├── progress_dots_row.dart     ← DESIGN.md 4.14
│       ├── exercise_action_buttons.dart  ← DESIGN.md 4.15
│       ├── feedback_bottom_sheet.dart    ← DESIGN.md 4.16
│       └── segmented_control.dart     ← DESIGN.md 4.6
├── features/
│   ├── home/
│   │   ├── data/
│   │   │   ├── tables/
│   │   │   │   └── posts_table.dart
│   │   │   ├── repositories/
│   │   │   │   └── post_repository.dart       ← implements IPostRepository
│   │   │   └── mappers/
│   │   │       └── post_mapper.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── post.dart                  ← freezed, no Flutter imports
│   │   │   ├── repositories/
│   │   │   │   └── i_post_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_latest_post_usecase.dart
│   │   │       └── fetch_and_cache_post_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── post_provider.dart
│   │       │   └── post_repository_provider.dart
│   │       ├── screens/
│   │       │   └── home_screen.dart
│   │       └── widgets/
│   │           └── news_card.dart             ← DESIGN.md 4.25
│   │
│   ├── morse/
│   │   ├── data/
│   │   │   ├── tables/
│   │   │   │   └── morse_exercises_table.dart
│   │   │   ├── sources/
│   │   │   │   ├── morse_dictionary.dart      ← static A-Z + Š/Č/Ž + 0-9 map
│   │   │   │   └── morse_corpus_loader.dart   ← reads assets/data/morse_corpus.json
│   │   │   ├── repositories/
│   │   │   │   ├── morse_translation_repository.dart
│   │   │   │   └── morse_exercise_repository.dart
│   │   │   └── mappers/
│   │   │       └── morse_exercise_mapper.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── morse_entry.dart           ← { character, morseSequence }
│   │   │   │   └── morse_exercise.dart        ← { values, translatedValues, areCorrect }
│   │   │   ├── repositories/
│   │   │   │   ├── i_morse_translation_repository.dart
│   │   │   │   └── i_morse_exercise_repository.dart
│   │   │   ├── usecases/
│   │   │   │   ├── translate_morse_usecase.dart
│   │   │   │   ├── generate_letter_exercise_usecase.dart ← local random A-Z
│   │   │   │   ├── get_corpus_exercise_usecase.dart      ← words/sentences from Drift
│   │   │   │   └── validate_morse_answer_usecase.dart
│   │   │   └── value_objects/
│   │   │       ├── translation_direction.dart ← enum: textToMorse / morseToText
│   │   │       ├── exercise_content_type.dart ← enum: letters / words / sentences
│   │   │       └── interaction_type.dart      ← enum: cards / keyboard / tokens
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── morse_translation_provider.dart
│   │       │   ├── morse_exercise_provider.dart
│   │       │   ├── morse_translation_repository_provider.dart
│   │       │   └── morse_exercise_repository_provider.dart
│   │       ├── screens/
│   │       │   ├── morse_screen.dart
│   │       │   ├── morse_translator_screen.dart
│   │       │   ├── morse_materials_screen.dart
│   │       │   ├── morse_exercise_selector_screen.dart
│   │       │   └── morse_exercise_screen.dart ← renders cards or keyboard sub-widget
│   │       └── widgets/
│   │           ├── morse_pattern_display.dart ← DESIGN.md 4.12
│   │           ├── morse_list_item.dart        ← DESIGN.md 4.11
│   │           ├── learning_cards_widget.dart  ← DESIGN.md 4.13
│   │           ├── learning_keyboard_widget.dart
│   │           ├── transmitter_controls.dart   ← DESIGN.md 4.17 bottom action row
│   │           └── flashlight_transmitter_screen.dart ← DESIGN.md 4.24
│   │
│   ├── semaphore/
│   │   ├── data/
│   │   │   ├── tables/
│   │   │   │   └── semaphore_exercises_table.dart
│   │   │   ├── sources/
│   │   │   │   ├── semaphore_dictionary.dart  ← static flag-image lookup map
│   │   │   │   └── semaphore_corpus_loader.dart
│   │   │   ├── repositories/
│   │   │   │   ├── semaphore_translation_repository.dart
│   │   │   │   └── semaphore_exercise_repository.dart
│   │   │   └── mappers/
│   │   │       └── semaphore_exercise_mapper.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── semaphore_entry.dart       ← { character, flagImagePath }
│   │   │   │   └── semaphore_exercise.dart
│   │   │   ├── repositories/
│   │   │   │   ├── i_semaphore_translation_repository.dart
│   │   │   │   └── i_semaphore_exercise_repository.dart
│   │   │   └── usecases/
│   │   │       ├── translate_semaphore_usecase.dart
│   │   │       ├── get_semaphore_exercise_usecase.dart
│   │   │       └── validate_semaphore_answer_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── semaphore_translation_provider.dart
│   │       │   ├── semaphore_exercise_provider.dart
│   │       │   ├── semaphore_translation_repository_provider.dart
│   │       │   └── semaphore_exercise_repository_provider.dart
│   │       ├── screens/
│   │       │   ├── semaphore_screen.dart
│   │       │   ├── semaphore_translator_screen.dart
│   │       │   ├── semaphore_materials_screen.dart
│   │       │   ├── semaphore_exercise_selector_screen.dart
│   │       │   └── semaphore_exercise_screen.dart
│   │       └── widgets/
│   │           ├── semaphore_flag_display.dart
│   │           └── semaphore_list_item.dart
│   │
│   ├── orientation/
│   │   ├── data/
│   │   │   ├── tables/
│   │   │   │   └── orientation_signs_table.dart
│   │   │   ├── repositories/
│   │   │   │   └── orientation_repository.dart
│   │   │   └── mappers/
│   │   │       └── orientation_sign_mapper.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── orientation_sign.dart      ← { id, name, imageLoc, topoGroupType }
│   │   │   ├── repositories/
│   │   │   │   └── i_orientation_repository.dart
│   │   │   ├── usecases/
│   │   │   │   ├── get_orientation_exercise_usecase.dart ← shuffle + 50% name swap
│   │   │   │   └── validate_orientation_answer_usecase.dart
│   │   │   └── value_objects/
│   │   │       └── topo_group_type.dart       ← enum: 8 values (canonical folder names)
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── orientation_exercise_provider.dart
│   │       │   ├── orientation_category_filter_provider.dart
│   │       │   └── orientation_repository_provider.dart
│   │       ├── screens/
│   │       │   ├── orientation_screen.dart
│   │       │   ├── orientation_exercise_selector_screen.dart
│   │       │   ├── orientation_exercise_screen.dart
│   │       │   ├── orientation_reference_screen.dart  ← Naloge na karti/terenu/etc.
│   │       │   └── pdf_viewer_screen.dart
│   │       └── widgets/
│   │           ├── topo_sign_card.dart        ← DESIGN.md 4.22
│   │           └── category_checkbox_row.dart
│   │
│   ├── settings/
│   │   ├── data/
│   │   │   ├── tables/
│   │   │   │   └── user_preferences_table.dart
│   │   │   └── repositories/
│   │   │       └── user_preferences_repository.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_preferences.dart      ← { themeMode, username, avatarId, onboardingSeen }
│   │   │   ├── repositories/
│   │   │   │   └── i_user_preferences_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_user_preferences_usecase.dart
│   │   │       └── save_user_preferences_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── user_preferences_provider.dart
│   │       │   └── user_preferences_repository_provider.dart
│   │       ├── screens/
│   │       │   └── settings_screen.dart
│   │       └── widgets/
│   │           ├── profile_hero.dart          ← DESIGN.md 4.18
│   │           ├── settings_row.dart          ← DESIGN.md 4.19
│   │           └── danger_zone_card.dart      ← DESIGN.md 4.21
│   │
│   ├── onboarding/
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── mark_onboarding_seen_usecase.dart ← writes via IUserPreferencesRepository
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── onboarding_seen_provider.dart
│   │       ├── screens/
│   │       │   └── onboarding_screen.dart
│   │       └── widgets/
│   │           └── onboarding_slide.dart      ← DESIGN.md 4.27
│   │
│   └── exercise_history/
│       ├── data/
│       │   ├── tables/
│       │   │   └── exercise_history_table.dart
│       │   └── repositories/
│       │       └── exercise_history_repository.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── exercise_session.dart
│       │   ├── repositories/
│       │   │   └── i_exercise_history_repository.dart
│       │   └── usecases/
│       │       ├── save_exercise_session_usecase.dart
│       │       └── get_exercise_history_usecase.dart
│       └── presentation/
│           ├── providers/
│           │   ├── exercise_history_provider.dart
│           │   └── exercise_history_repository_provider.dart
│           └── widgets/
│               └── history_session_card.dart  ← DESIGN.md 4.23
│
└── main.dart                                  ← ProviderScope root, seeder trigger
```

---

## 2. DRIFT SCHEMA

### Table: `posts`

| Column | Drift Type | Dart Type | Constraints |
|---|---|---|---|
| `id` | `integer().autoIncrement()` | `int` | PK |
| `title` | `text()` | `String` | NOT NULL |
| `content` | `text()` | `String` | NOT NULL |
| `link` | `text()` | `String` | NOT NULL |
| `created_at` | `integer()` | `int` | NOT NULL — Unix ms |

**Relationships:** None. Single-row cache. Previous row replaced on each successful fetch.

**Seeding:** Not seeded. Populated on first successful online fetch only. Home screen shows empty state if this table has no rows.

---

### Table: `morse_exercises`

| Column | Drift Type | Dart Type | Constraints |
|---|---|---|---|
| `id` | `integer().autoIncrement()` | `int` | PK |
| `exercise_content_type` | `textEnum<ExerciseContentType>()` | `ExerciseContentType` | NOT NULL — letters / words / sentences |
| `translate_type` | `textEnum<TranslationDirection>()` | `TranslationDirection` | NOT NULL — textToMorse / morseToText |
| `values` | `text()` | `String` | NOT NULL — JSON array of strings |
| `translated_values` | `text()` | `String` | NOT NULL — JSON array of strings |
| `count` | `integer()` | `int` | NOT NULL |
| `interaction_type` | `textEnum<InteractionType>()` | `InteractionType` | NOT NULL — cards / keyboard / tokens |

**Relationships:** None. Referenced by exercise_history via string enum values only.

**Seeding:** Words and sentences rows are seeded from `assets/data/morse_corpus.json` on first launch. Letters are generated at runtime via `GenerateLetterExerciseUseCase` and are not persisted in this table.

---

### Table: `semaphore_exercises`

Mirrors `morse_exercises` exactly. Same columns, same types, same constraints.

| Column | Drift Type | Dart Type | Constraints |
|---|---|---|---|
| `id` | `integer().autoIncrement()` | `int` | PK |
| `exercise_content_type` | `textEnum<ExerciseContentType>()` | `ExerciseContentType` | NOT NULL |
| `translate_type` | `textEnum<TranslationDirection>()` | `TranslationDirection` | NOT NULL |
| `values` | `text()` | `String` | NOT NULL — JSON array |
| `translated_values` | `text()` | `String` | NOT NULL — JSON array |
| `count` | `integer()` | `int` | NOT NULL |
| `interaction_type` | `textEnum<InteractionType>()` | `InteractionType` | NOT NULL — cards / keyboard |

**Seeding:** Seeded from `assets/data/semaphore_corpus.json` on first launch.

---

### Table: `orientation_signs`

| Column | Drift Type | Dart Type | Constraints |
|---|---|---|---|
| `id` | `integer().autoIncrement()` | `int` | PK |
| `name` | `text()` | `String` | NOT NULL — human-readable Slovenian sign name |
| `image_loc` | `text()` | `String` | NOT NULL — full asset path, e.g. `assets/images/topografija/relief/r_1.jpeg` |
| `topo_group_type` | `textEnum<TopoGroupType>()` | `TopoGroupType` | NOT NULL |

**`TopoGroupType` enum values (canonical = Flutter asset folder names):**
```
geodetskeTocke         ← folder: geodetske_tocke/
mejeInOgraje           ← folder: meje_in_ograje/
morjeInMorskaObala     ← folder: morje_in_morska_obala/
naseljaInObjekti       ← folder: naselja_in_objekti/
prometKomunikacije     ← folder: promet_komunikacije/
rastjeInVrsteTal       ← folder: rastje_in_vrste_tal/
relief                 ← folder: relief/
vodovje                ← folder: vodovje/
```

Note: original PostgreSQL enum values `meje_in_morska_obala` and `promet` are corrupted historical artifacts. They must never appear in this schema.

**Relationships:** None.

**Seeding:** Algorithmically generated from Flutter asset manifest on first launch. See Section 6.

---

### Table: `user_preferences`

Single-row configuration table. Always exactly one row with `id = 1`.

| Column | Drift Type | Dart Type | Constraints |
|---|---|---|---|
| `id` | `integer()` | `int` | PK — always 1 |
| `theme_mode` | `textEnum<AppThemeMode>()` | `AppThemeMode` | NOT NULL, default: dark |
| `username` | `text().nullable()` | `String?` | — |
| `avatar_id` | `text().nullable()` | `String?` | — |
| `onboarding_seen` | `boolean()` | `bool` | NOT NULL, default: false |

**Relationships:** Read by both `settings` and `onboarding` features via shared `IUserPreferencesRepository`.

**Seeding:** One row inserted with defaults on first launch, before any provider reads it.

---

### Table: `exercise_history`

| Column | Drift Type | Dart Type | Constraints |
|---|---|---|---|
| `id` | `integer().autoIncrement()` | `int` | PK |
| `feature_type` | `textEnum<FeatureType>()` | `FeatureType` | NOT NULL — morse / semaphore / orientation |
| `exercise_content_type` | `text()` | `String` | NOT NULL — letters / words / sentences / signs |
| `interaction_type` | `text()` | `String` | NOT NULL — cards / keyboard / tokens |
| `total_questions` | `integer()` | `int` | NOT NULL |
| `correct_count` | `integer()` | `int` | NOT NULL |
| `session_date` | `integer()` | `int` | NOT NULL — Unix ms |
| `duration_seconds` | `integer()` | `int` | NOT NULL |

**Relationships:** No FK. `feature_type` maps to feature domain by enum string value.

**Seeding:** Not seeded. Populated at the end of each completed exercise session.

---

### Relationship Summary

```
user_preferences  (1 row — config singleton)
    ↑ read by: settings feature, onboarding feature

posts             (0 or 1 row — latest cache)
    ↑ read by: home feature

morse_exercises   (N rows — seeded corpus: words + sentences)
    ↑ read by: morse exercise use case

semaphore_exercises (N rows — seeded corpus)
    ↑ read by: semaphore exercise use case

orientation_signs (230 rows — seeded from asset manifest)
    ↑ read by: orientation exercise use case

exercise_history  (N rows — append-only log)
    ← written by: morse / semaphore / orientation exercise sessions
    ↑ read by: exercise_history feature
```

No cross-table foreign keys. All tables are independent.

---

## 3. RIVERPOD PROVIDER MAP

### core

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `appDatabaseProvider` | `Provider<AppDatabase>` | nothing | Drift database singleton |
| `platformFeaturesProvider` | `Provider<IPlatformFeatures>` | `kIsWeb` flag at resolution time | feature availability flags |
| `torchServiceProvider` | `Provider<ITorchService>` | `platformFeaturesProvider` | torch on/off/check |
| `fileExportServiceProvider` | `Provider<IFileExportService>` | `platformFeaturesProvider` | file delivery method |

---

### feature: home

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `postRepositoryProvider` | `Provider<IPostRepository>` | `appDatabaseProvider` | repository instance |
| `latestPostProvider` | `AsyncNotifier<Post?>` | `postRepositoryProvider`, network | `Post?` (null = no cached post), `refresh()` |

---

### feature: morse

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `morseTranslationRepositoryProvider` | `Provider<IMorseTranslationRepository>` | `MorseDictionary` (static) | repository instance |
| `morseExerciseRepositoryProvider` | `Provider<IMorseExerciseRepository>` | `appDatabaseProvider` | repository instance |
| `morseTranslationProvider` | `Notifier<MorseTranslationState>` | `morseTranslationRepositoryProvider`, `torchServiceProvider` | `{ input, output, direction, isTransmitting, isAutoRepeating, torchError }` |
| `morseExerciseProvider` | `AsyncNotifier<MorseExerciseState>` | `morseExerciseRepositoryProvider`, `morseTranslationRepositoryProvider` | `{ questions[], translatedQuestions[], areCorrect[], currentIndex, userResults[] }`, `start(params)`, `validate(answer)`, `undo()`, `next()` |

Note: `morseTranslationProvider` uses `Notifier` not `AsyncNotifier` — translation is pure local computation. Torch side-effects mutate the same state object. Torch cancellation (replacing `bloc_concurrency` restartable) must be handled via a `CancelToken`-style flag inside the notifier.

---

### feature: semaphore

Mirrors morse providers exactly.

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `semaphoreTranslationRepositoryProvider` | `Provider<ISemaphoreTranslationRepository>` | `SemaphoreDictionary` (static) | repository instance |
| `semaphoreExerciseRepositoryProvider` | `Provider<ISemaphoreExerciseRepository>` | `appDatabaseProvider` | repository instance |
| `semaphoreTranslationProvider` | `Notifier<SemaphoreTranslationState>` | `semaphoreTranslationRepositoryProvider` | `{ input, outputImagePaths[], direction }` |
| `semaphoreExerciseProvider` | `AsyncNotifier<SemaphoreExerciseState>` | `semaphoreExerciseRepositoryProvider`, `semaphoreTranslationRepositoryProvider` | same shape as `morseExerciseProvider` |

---

### feature: orientation

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `orientationRepositoryProvider` | `Provider<IOrientationRepository>` | `appDatabaseProvider` | repository instance |
| `orientationCategoryFilterProvider` | `StateProvider<Set<TopoGroupType>>` | nothing | selected category set — all selected by default |
| `orientationExerciseProvider` | `AsyncNotifier<OrientationExerciseState>` | `orientationRepositoryProvider` | `{ names[], imageLocs[], areCombinationsCorrect[], currentIndex, userResults[] }`, `start(params)`, `validate(answer)`, `undo()`, `next()` |

---

### feature: settings

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `userPreferencesRepositoryProvider` | `Provider<IUserPreferencesRepository>` | `appDatabaseProvider` | repository instance |
| `userPreferencesProvider` | `AsyncNotifier<UserPreferences>` | `userPreferencesRepositoryProvider` | `UserPreferences`, `update(partial)` |

---

### feature: onboarding

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `onboardingSeenProvider` | `FutureProvider<bool>` | `userPreferencesRepositoryProvider` | `bool` — read-only, consumed by router guard |

Note: `onboardingSeenProvider` is a thin read-only view. It does not duplicate state — it reads `UserPreferences.onboardingSeen` directly. The router guard watches this provider.

---

### feature: exercise_history

| Provider | Type | Depends On | Exposes |
|---|---|---|---|
| `exerciseHistoryRepositoryProvider` | `Provider<IExerciseHistoryRepository>` | `appDatabaseProvider` | repository instance |
| `exerciseHistoryProvider` | `AsyncNotifier<List<ExerciseSession>>` | `exerciseHistoryRepositoryProvider` | history list, `save(session)` |

---

## 4. NAVIGATION STRUCTURE

All routes use named routes only. No anonymous routes. Route name constants live in `RouteNames` class in `core/routing/route_names.dart`.

```
/ (redirect only — no screen)
│   Guard: onboardingGuard
│   → /onboarding   if onboardingSeen == false
│   → /home         if onboardingSeen == true
│
├── /onboarding
│       name: RouteNames.onboarding
│       Guard: redirect to /home if onboardingSeen == true
│
├── /home
│       name: RouteNames.home
│
├── /morse
│       name: RouteNames.morse
│   ├── /morse/translator
│   │       name: RouteNames.morseTranslator
│   ├── /morse/materials
│   │       name: RouteNames.morseMaterials
│   └── /morse/exercises
│           name: RouteNames.morseExercises
│       ├── /morse/exercises/selector
│       │       name: RouteNames.morseExerciseSelector
│       └── /morse/exercises/session
│               name: RouteNames.morseExerciseSession
│               extra: ExerciseSessionParams (required)
│               Guard: redirect to /morse/exercises/selector if extra is null
│
├── /semaphore
│       name: RouteNames.semaphore
│   ├── /semaphore/translator
│   │       name: RouteNames.semaphoreTranslator
│   ├── /semaphore/materials
│   │       name: RouteNames.semaphoreMaterials
│   └── /semaphore/exercises
│           name: RouteNames.semaphoreExercises
│       ├── /semaphore/exercises/selector
│       │       name: RouteNames.semaphoreExerciseSelector
│       └── /semaphore/exercises/session
│               name: RouteNames.semaphoreExerciseSession
│               extra: ExerciseSessionParams (required)
│               Guard: redirect to /semaphore/exercises/selector if extra is null
│
├── /orientation
│       name: RouteNames.orientation
│   ├── /orientation/exercises
│   │       name: RouteNames.orientationExercises
│   │   ├── /orientation/exercises/selector
│   │   │       name: RouteNames.orientationExerciseSelector
│   │   └── /orientation/exercises/session
│   │           name: RouteNames.orientationExerciseSession
│   │           extra: OrientationSessionParams (required)
│   │           Guard: redirect to /orientation/exercises/selector if extra is null
│   ├── /orientation/reference/:categoryId
│   │       name: RouteNames.orientationReference
│   │       path param: categoryId — matches OrientationReferenceCategory enum name
│   │       categories: nalogaNaKarti / nalogaNaTerenu / nalogaNaTekmovanjih / okolje
│   └── /orientation/pdf
│           name: RouteNames.orientationPdf
│           extra: PdfParams { assetPath: String, title: String } (required)
│
├── /settings
│       name: RouteNames.settings
│
└── /webview
        name: RouteNames.webview
        extra: WebviewParams { url: String, title: String } (required)
```

### Guard Notes

- `onboardingGuard` runs on `/` and `/onboarding`. Reads `onboardingSeenProvider`. While `AsyncValue.loading`, no redirect (guard returns null).
- Session-screen guards (`morseExerciseSession`, `semaphoreExerciseSession`, `orientationExerciseSession`) check for non-null `extra`. If null: redirect to respective selector. Prevents blank-provider state on deep-link or back-stack navigation.
- `/orientation/reference/:categoryId` has no guard — categories with no content yet render an empty-state placeholder screen. Architecture supports adding content per category without route changes.
- No authentication guards in scope.

---

## 5. DEPENDENCY GRAPH

```
┌─────────────────────────────────────────────────────┐
│                     main.dart                       │
│  ProviderScope — overrides all *RepositoryProviders │
│  AppSeeder.run() — executes before first frame      │
└────────────────────┬────────────────────────────────┘
                     │
         ┌───────────▼───────────┐
         │  core/routing/        │
         │  AppRouter            │
         │  onboardingGuard      │
         └───────────┬───────────┘
                     │ reads providers
         ┌───────────▼───────────────────────────────┐
         │  features/*/presentation/                  │
         │  screens, widgets, providers               │
         │  (Flutter + Riverpod)                      │
         └───────────┬───────────────────────────────┘
                     │ calls use cases / reads entities only
                     │ never imports data/ directly
         ┌───────────▼───────────────────────────────┐
         │  features/*/domain/                        │
         │  use cases, entities, repository           │
         │  interfaces, value objects                 │
         │  (pure Dart — ZERO Flutter imports)        │
         └───────────┬───────────────────────────────┘
                     │ interfaces implemented by
         ┌───────────▼───────────────────────────────┐
         │  features/*/data/                          │
         │  Drift table defs, repository impls,       │
         │  mappers, asset loaders                    │
         │  (Drift + dart:convert)                    │
         └───────────┬───────────────────────────────┘
                     │
         ┌───────────▼───────────┐
         │  core/database/       │
         │  AppDatabase          │
         │  (Drift SDK only)     │
         └───────────────────────┘

         ┌───────────────────────────────────────────┐
         │  core/platform/                            │
         │  torch, pdf, export, permissions           │
         │  (platform-conditional, kIsWeb)            │
         └───────────┬───────────────────────────────┘
                     │ injected via Riverpod providers into
                     │ features/*/presentation/providers/
```

### Enforced Layer Rules

| Layer | Permitted imports | Forbidden imports |
|---|---|---|
| `domain/` | `dart:core`, `freezed_annotation`, `meta` | Flutter, Drift, any `data/` |
| `data/` | `domain/` interfaces + entities, Drift, `dart:convert`, `flutter/services.dart` (AssetBundle in seeders only) | Flutter widgets, Riverpod |
| `presentation/` | `domain/` entities + use cases, Riverpod, Flutter | Any `data/` file directly |
| `core/platform/` | Platform SDKs (`torch_light`, `permission_handler`, etc.), `core/platform/` interfaces | Feature `domain/` or `data/` |

Provider files in `presentation/providers/` are the only location where `data/` implementations are referenced. They inject those implementations into `domain/` interfaces via Riverpod overrides.

---

## 6. SEEDING STRATEGY

### Trigger

Seeding runs once, synchronously before the first widget frame. Check: query `user_preferences` row count. If zero → run `AppSeeder`. If non-zero → skip entirely.

`AppSeeder` calls sub-seeders in this fixed order:
1. `UserPreferencesSeeder` — must run first (sets onboarding_seen = false)
2. `OrientationSeeder`
3. `MorseCorpusSeeder`
4. `SemaphoreCorpusSeeder`

All sub-seeders implement `ISeeder`: `Future<void> seed(AppDatabase db)`.

---

### Orientation Seeder

**Input:** Flutter `AssetManifest.json`, loaded via `rootBundle`.

**Algorithm:**
1. Load and parse `AssetManifest.json`.
2. Collect all keys matching `assets/images/topografija/**`.
3. For each matching path:
   - Split path segments. The folder name at index 3 → map to `TopoGroupType` via the folder-to-enum table below.
   - Filename without extension → look up in a bundled hardcoded name table (`Map<String, String>`) to get the Slovenian display name. This lookup table is manually authored — it is the authoritative name source.
   - `image_loc` = full asset path string as-is.
4. Batch insert all rows in a single Drift transaction.

**Folder-to-TopoGroupType mapping:**
```
geodetske_tocke       → TopoGroupType.geodetskeTocke
meje_in_ograje        → TopoGroupType.mejeInOgraje
morje_in_morska_obala → TopoGroupType.morjeInMorskaObala
naselja_in_objekti    → TopoGroupType.naseljaInObjekti
promet_komunikacije   → TopoGroupType.prometKomunikacije
rastje_in_vrste_tal   → TopoGroupType.rastjeInVrsteTal
relief                → TopoGroupType.relief
vodovje               → TopoGroupType.vodovje
```

Corrupt PostgreSQL enum values (`meje_in_morska_obala`, `promet`) are permanently excluded. The live backend database must not be consulted as a seed source.

---

### Morse Corpus Seeder

**Input:** Bundled asset `assets/data/morse_corpus.json`.

**JSON schema:**
```json
{
  "words": [
    {
      "values": ["string"],
      "translatedValues": ["string"],
      "translateType": "textToMorse | morseToText",
      "interactionType": "cards | keyboard"
    }
  ],
  "sentences": [ ... ]
}
```

**Algorithm:** Decode JSON. Map each entry to a `MorseExercisesCompanion`. Batch insert all into `morse_exercises` in a single transaction. Both `textToMorse` and `morseToText` directions should be present per word/sentence.

---

### Semaphore Corpus Seeder

Identical algorithm to Morse Corpus Seeder. Reads `assets/data/semaphore_corpus.json`. Inserts into `semaphore_exercises`.

---

### User Preferences Seeder

Inserts exactly one row:
```
{ id: 1, themeMode: dark, username: null, avatarId: null, onboardingSeen: false }
```

---

## 7. PLATFORM FEATURE FLAGS

### Interface: `IPlatformFeatures`

Location: `core/platform/i_platform_features.dart`

```
abstract interface class IPlatformFeatures {
  bool get isTorchAvailable;
  bool get isFileDownloadAvailable;
  bool get isPdfViewerNative;
  bool get isPermissionHandlerAvailable;
}
```

| Feature flag | Mobile | Web |
|---|---|---|
| `isTorchAvailable` | true | false |
| `isFileDownloadAvailable` | false | true |
| `isPdfViewerNative` | true | false |
| `isPermissionHandlerAvailable` | true | false |

**Resolution:** `platformFeaturesProvider` resolves implementation at startup via `kIsWeb`:
- `kIsWeb == true` → `WebPlatformFeatures`
- `kIsWeb == false` → `MobilePlatformFeatures`

---

### Torch Service

| Class | Platform | Behaviour |
|---|---|---|
| `TorchServiceMobile` | mobile | wraps `torch_light` package |
| `TorchServiceStub` | web | all methods are no-ops; `isAvailable` → false |

UI behaviour: transmitter controls widget checks `IPlatformFeatures.isTorchAvailable`. If false, the torch button is rendered disabled. It never throws. Audio transmitter is available on all platforms.

---

### PDF Viewer

| Class | Platform | Behaviour |
|---|---|---|
| `PdfViewerMobile` | mobile | renders `flutter_pdfview` widget (canonical — `flutter_cached_pdfview` is dropped) |
| `PdfViewerWeb` | web | opens asset via `url_launcher` or browser-native rendering |

`pdf_viewer_screen.dart` receives `IPdfViewer` via provider injection. It does not import either concrete class.

---

### File Export

| Class | Platform | Behaviour |
|---|---|---|
| `FileExportMobile` | mobile | `open_filex` — opens generated PDF with the device's default app |
| `FileExportWeb` | web | `flutter_file_saver` — triggers browser file download |

PDF generation via the `pdf` package runs on both platforms. Only the delivery mechanism is platform-conditional. The export action in translator screens is conditionally shown using `IPlatformFeatures.isFileDownloadAvailable` — on mobile, export is not exposed; on web, download is shown.

---

### Permissions

| Class | Platform | Behaviour |
|---|---|---|
| `PermissionServiceMobile` | mobile | wraps `permission_handler` |
| `PermissionServiceStub` | web | all permission queries return `granted` silently |

The settings screen permissions row is rendered only when `IPlatformFeatures.isPermissionHandlerAvailable` is true. On web, the row is absent entirely. The empty stub handler (`onPressed: () {}`) from the current codebase is not carried forward.

---

*End of ARCHITECTURE.md*
*Generated: 2026-04-04*
*Role: Architect — structure only*
