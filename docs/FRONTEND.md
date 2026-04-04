# Frontend Documentation: Tabornski SOS Prirocnik

## 1. TECH STACK

### Flutter & Dart Environment
- **Dart SDK**: `>=2.18.6 <3.0.0`
- **Flutter**: Standard SDK
- **Code generation**: enabled (`generate: true`)

### Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| flutter_bloc | ^9.1.0 | State management with BLoC pattern |
| shared_preferences | ^2.2.3 | Local persistent storage |
| flutter_svg | ^2.0.10+1 | SVG rendering |
| go_router | ^15.0.0 | Navigation and routing |
| url_launcher | ^6.3.1 | Open URLs |
| permission_handler | ^12.0.0+1 | Request device permissions |
| torch_light | ^1.1.0 | Flash/torch control for Morse transmitting |
| bloc_concurrency | ^0.3.0 | BLoC concurrency utilities |
| meta | ^1.12.0 | Annotations and metadata |
| path_provider | ^2.1.3 | Access app/document directories |
| flutter_cached_pdfview | ^0.4.2 | PDF viewing |
| flutter_speed_dial | ^7.0.0 | Speed dial FAB |
| share_plus | ^10.1.4 | Share content |
| flutter_file_saver | ^0.9.0 | Save files to device |
| package_info_plus | ^8.3.0 | App package info |
| collection | ^1.18.0 | Collection utilities |
| flutter_localizations | sdk: flutter | Localization support |
| intl | any | Internationalization |
| flutter_card_swiper | ^7.0.1 | Card swiping UI |
| http | ^1.2.1 | HTTP requests |
| flutter_dotenv | ^5.1.0 | Environment variables (.env) |
| webview_flutter | ^4.8.0 | WebView embedding |
| flutter_pdfview | ^1.4.0+1 | PDF viewing (alternative) |
| pdf | ^3.11.0 | PDF generation |
| open_filex | ^4.7.0 | Open files with default app |
| file_picker | ^10.1.2 | File picking |
| cupertino_icons | 1.0.8 | iOS-style icons |

### Dev Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| flutter_test | sdk | Testing framework |
| flutter_lints | ^5.0.0 | Code quality linting |
| flutter_launcher_icons | ^0.13.1 | App icon generation |

### Custom Fonts
- **CustomIcons**: `assets/fonts/CustomIcons.ttf`
- **JetBrainsMono-Bold**: `assets/fonts/JetBrainsMono/JetBrainsMono-Bold.ttf`
- **JetBrainsMono-Regular**: `assets/fonts/JetBrainsMono/JetBrainsMono-Regular.ttf`
- 31 additional JetBrainsMono font variant files (Italic, ExtraBold, Light, Medium, SemiBold, Thin, NL variants)

---

## 2. SCREEN INVENTORY

### Root & Welcome

**WelcomeView** (`lib/screens/welcome_screen.dart`)
- Displays a 4-page onboarding carousel (PageView)
- Pages: App intro, Morse Code, Semaphore, Topography
- Interactions: Swipe pages, tap "Start Using The App" button
- Data needs: Localized strings only
- Exit action: Navigate to home route

---

### Home

**HomeView** (`lib/screens/home_screen.dart`)
- Main dashboard: app title, welcome message, InfoCard with latest blog post
- Interactions: None (read-only display)
- Data needs: Latest post from API via PostCubit (loading / success / failure states)

---

### Morse Code Section

**MorseCodeView** (`lib/screens/morse_code/morse_code.dart`)
- Hub screen: 3 navigation buttons (Translator, Exercises, Dictionary/Materials)
- Interactions: Navigate to sub-screens

**MorseCodeTranslatorView** (`lib/screens/morse_code/morse_code_translator.dart`)
- Bidirectional translator: Text ↔ Morse Code
- Input text field (enabled only after translation type selected)
- Output text field (read-only)
- Bottom buttons: 2 language selector buttons, settings icon (torch control)
- Side buttons: Copy, Save (PDF), Clear
- Settings bottom sheet: Auto-repeat toggle, torch transmit start/stop
- Data needs: MorseTranslationBloc
- Events dispatched: TranslateInput, UpdateTranslationType, ToggleAutoRepeat, ToggleTransmitting, ClearInput

**MorseCodeMaterials** (`lib/screens/morse_code/morse_code_materials.dart`)
- Dictionary grid of all Morse code letters/numbers
- Filter chips: All, Letters, Numbers
- Interactions: Tap item to copy Morse code to clipboard
- Data: `MorseCodeLanguage.morseCodeList` (static)

**MorseCodeLearning** / Learning Selector (`lib/screens/morse_code/morse_code_learning_selector.dart`)
- Exercise configuration screen:
  - Learning Type: Transmitting (text→morse) or Receiving (morse→text)
  - Size of Question: Letters, Words, Sentences
  - User Interface: Card Swipe or Keyboard
  - Amount of Repetitions: 1, 5, 10, or 20
- Single "Begin Learning" button → calls API then navigates
- API call: `MorseExerciseApiService.getSpecificExercise()`
- Navigation: Passes `MorseCodeLearningParams` to LearningScreen via `state.extra`

**LearningScreen** (`lib/screens/morse_code/learning_type_widgets/learning_screen.dart`)
- Wrapper: renders LearningCards or LearningKeyboard based on `MorseCodeLearningParams`

**LearningCards** (`lib/screens/morse_code/learning_type_widgets/learning_cards.dart`)
- Card swiper: shows question (morse or text), user swipes right (correct) or left (incorrect)
- Bottom sheet shows exercise completion with progress dots
- Data needs: MorseExerciseBloc
- Events dispatched: MorseExerciseStart, MorseExerciseValidate, UndoPreviousAnswer, MorseExerciseNext

**LearningKeyboard** (`lib/screens/morse_code/learning_type_widgets/learning_keyboard.dart`)
- ⚠️ unclear: Referenced in LearningScreen but full implementation not confirmed

---

### Semaphore Section

**SemaphoreView** (`lib/screens/semaphore/semaphore.dart`)
- Hub screen: Translator and Materials buttons
- Exercises button present but overlaid with "Coming Soon" (non-functional)

**SemaphoreTranslatorView** (`lib/screens/semaphore/semaphore_translator.dart`)
- Bidirectional translator: Text ↔ Semaphore flags
- Displays flag images instead of text codes
- Side buttons: Copy, Save
- Data needs: SemaphoreBloc, `SemaphoreLanguage.semaphoreList`
- Events dispatched: UpdateTranslationTypeSemaphore, TranslateInputSemaphore, ClearInputSemaphore, UpdateSemaphoreImage

**SemaphoreMaterialsView** (`lib/screens/semaphore/semaphore_materials.dart`)
- Grid dictionary of semaphore flag images
- Filter chips: All, Letters, Numbers, Special
- Interactions: Filter by type, view flag images

---

### Orientation/Topography Section

**OrientationView** (`lib/screens/orientation/orientation.dart`)
- Hub screen with: topography learning button + 6 PDF buttons (Map, Stars, Compass, General, Navigation with Azimuths, "More Coming Soon")
- Each PDF button navigates to PDFScreen with a specific PDF asset

**TopoCharactersLearning** / Learning Selector (`lib/screens/orientation/topo_characters_learning_selector.dart`)
- Exercise configuration:
  - Learning Type: Images or Text
  - Topo Categories: checkboxes for 8 categories
  - Number of Repetitions: 5, 10, 20, 30
- API call: `OrientationApiService.getExercise()`
- Navigation: Passes `OrientationExerciseParams` to OrientationScreenCards via `state.extra`

**OrientationScreenCards** (`lib/screens/orientation/orientation_cards.dart`)
- Card swiper for topography matching
- Shows image or text label; user swipes to confirm correct/incorrect pairing
- Data needs: OrientationExerciseBloc
- Events dispatched: OrientationExerciseStart, OrientationExerciseValidate, UndoPreviousAnswer, OrientationExerciseNext

---

### Settings

**SettingsView** (`lib/screens/settings/settings.dart`)
- User profile section: editable username, avatar display
- Preferences: Dark Mode toggle, Notifications toggle, Permissions button (⚠️ see section 7)
- Data management: Clear local storage button
- About section: App info dialog with version, developer, license
- Data needs: ThemeBloc

---

## 3. BLoC INVENTORY

### ThemeBloc (`lib/blocs/theme_block/`)
- **States**: `LightThemeState`, `DarkThemeState` — both extend `ThemeState` with `ThemeData`
- **Events**: `ToggleThemeEvent`
- **Initial state**: `LightThemeState` (loaded from SharedPreferences on init)
- **Logic**:
  - `_loadThemePreference()` — reads saved theme on startup
  - `_mapToggleThemeEventToState()` — switches theme and persists to SharedPreferences
- **Dependencies**: SharedPreferences

---

### MorseTranslationBloc (`lib/blocs/morse_translation_bloc/`)
- **States**: `MorseTranslationInitial`, `Loading`, `Success`, `Failure`, `MorseTorchStartedTransmitting`, `MorseTorchStoppedTransmitting`, `MorseTorchTransmittingFailure`
- **Events**: `TranslateInput`, `ClearInput`, `ToggleAutoRepeat`, `UpdateTranslationType`, `ToggleTransmitting`
- **State properties**: `languageSetting: MorseCodeLanguage`, `isAutoRepeating: bool`, `isTransmitting: bool`
- **Logic**:
  - `_mapUpdateTranslationTypeToState()` — sets morse/text direction
  - `_mapTranslateInputToState()` — calls MorseCodeRepository to translate
  - `_mapClearInputToState()` — resets fields
  - `_mapToggleAutoRepeatToState()` — enables/disables continuous transmission
  - `_mapToggleTransmittingToState()` — controls torch/flashlight (uses `restartable()` transformer)
- **Dependencies**: MorseCodeRepository, TorchLight

---

### SemaphoreBloc (`lib/blocs/semaphore_bloc/`)
- **States**: `SemaphoreInitial`, `Loading`, `Success`, `Failure`
- **Events**: `UpdateTranslationTypeSemaphore`, `TranslateInputSemaphore`, `ClearInputSemaphore`, `UpdateSemaphoreImage`
- **State properties**: `languageSetting: SemaphoreLanguage`
- **Logic**:
  - `_mapUpdateTranslationTypeToState()` — sets semaphore/text direction
  - `_mapTranslateInputToState()` — translates via SemaphoreRepository
  - `_mapClearInputToState()` — resets fields
  - `_mapUpdateSemaphoreImageToState()` — appends semaphore flag image to list
- **Dependencies**: SemaphoreRepository

---

### MorseExerciseBloc (`lib/blocs/morse_exercise_bloc/`)
- **States**: `Initial`, `StartState`, `Loading`, `Validating`, `Validated`, `NotValidated`, `UndoCheck`, `NextE`
- **Events**: `MorseExerciseStart`, `MorseExerciseValidate`, `UndoPreviousAnswer`, `MorseExerciseNext`
- **State properties**: `exerciseText`, `expectedAnswers`, `userInput`, `correctAnswers`, `areTranslationsCorrect` (all nullable lists)
- **Logic**:
  - `_startExercise()` — initializes exercise data
  - `_validateExercisePart()` — validates user answer via `MorseCodeRepository.validateTranslation()` (accepts optional `swiperDirection`)
  - `_undoPreviousAnswer()` — removes last entry from correctAnswers
  - `_nextExercise()` — advances to next item
- **Dependencies**: MorseCodeRepository
- ⚠️ unclear: State classes use mutable list properties with positional constructor params lacking type annotations; does not follow standard immutability patterns

---

### OrientationExerciseBloc (`lib/blocs/orientation_exercise_bloc/`)
- **States**: `Initial`, `StartState`, `Loading`, `Validated`, `NotValidated`, `UndoCheck`, `NextE`
- **Events**: `OrientationExerciseStart`, `OrientationExerciseValidate`, `UndoPreviousAnswer`, `OrientationExerciseNext`
- **State properties**: `names`, `images`, `areCombinationsCorrect`, `correctAnswers` (all nullable lists)
- **Logic**:
  - `_startExercise()` — initializes exercise
  - `_validateExercisePart()` — validates card swipe via `OrientationRepository`
  - `_undoPreviousAnswer()` — removes last entry
  - `_nextExercise()` — advances to next item
- **Dependencies**: OrientationRepository
- ⚠️ unclear: Same immutability and typing issues as MorseExerciseBloc

---

### PostCubit (`lib/blocs/post_cubit/`)
- **States**: `PostInitial`, `PostLoading`, `PostSuccess`, `PostFailure`
- **Method**: `getLatestPost()` — calls PostApiService, emits appropriate state
- **Dependencies**: PostApiService
- Uses Cubit pattern (no events)

---

## 4. API CALLS

All services read `BASE_URL` from `.env` via `flutter_dotenv`.

### PostApiService (`lib/api/post_api_service.dart`)
- **Endpoint**: `GET {BASE_URL}/posts/latest`
- **Called from**: HomeView.initState() via PostCubit
- **Request**: No body
- **Response**: `{ title: string, content: string, link: string }`
- **Data usage**: Displayed in InfoCard on HomeView
- **Error handling**: Throws generic `Exception` on non-200 response
- ⚠️ unclear: Debug `print(responseJson)` left in production code (line 20)

### MorseExerciseApiService (`lib/api/morse_exercise_api_service.dart`)
- **Endpoint**: `POST {BASE_URL}/morse-exercise/get-exercise`
- **Called from**: MorseCodeLearning selector screen
- **Request body**:
  ```json
  {
    "type": "{learningAmount.name}",
    "translateType": "{learningType.name}",
    "numberOfElements": int,
    "learningInteractionType": "{interactionType.name}"
  }
  ```
- **Response**: `{ value: [string], translatedValue: [string], areTranslationsCorrect: [bool] }`
- **Response model**: `MorseCodeLanguage`
- **Data usage**: Passed as params to MorseExerciseBloc

### OrientationApiService (`lib/api/orientation_api_service.dart`)
- **Endpoint**: `POST {BASE_URL}/orientation/get-exercise`
- **Called from**: TopoCharactersLearning selector screen
- **Request body**:
  ```json
  {
    "numberOfElements": int,
    "type": ["{OrientationTopoCategory.name}", ...]
  }
  ```
- **Response**: `{ names: [string], imageLoc: [string], areCombinationsCorrect: [bool] }`
- **Response model**: `OrientationExercise`
- **Data usage**: Passed as params to OrientationExerciseBloc

---

## 5. NAVIGATION STRUCTURE

Implemented with **GoRouter** (`lib/app_router.dart`).

### Initial Route Logic
- Path: `/` → `WelcomeView`
- Redirect: if first-time user → stay at `/`; if returning user → redirect to `/home`

### Full Route Tree
```
/ (WelcomeView)                              name: "Root"
/home (HomeView)                             name: "Home"
/morse-code (MorseCodeView)                  name: "MorseCode"
  /morse-code/translator (MorseCodeTranslatorView)   name: "MorseCodeTranslator"
  /morse-code/materials (MorseCodeMaterials)          name: "MorseCodeMaterials"
  /morse-code/selector (MorseCodeLearning)            name: "MorseCodeLearningSelector"
    /morse-code/selector/learning (LearningScreen)    name: "MorseCodeLearning"
        extra: { params: MorseCodeLearningParams }
/semaphore (SemaphoreView)                   name: "Semaphore"
  /semaphore/translator (SemaphoreTranslatorView)     name: "SemaphoreTranslator"
  /semaphore/materials (SemaphoreMaterialsView)       name: "SemaphoreMaterials"
/orientation (OrientationView)               name: "Orientation"
  /orientation/selector (TopoCharactersLearning)      name: "OrientationLearningSelector"
  /orientation/learning (OrientationScreenCards)      name: "OrientationLearning"
        extra: { params: OrientationExerciseParams }
/settings (SettingsView)                     name: "Settings"
/webview (WebviewContainer)                  name: "Webview"
        extra: { url: string }
```

### Parameter Passing
- `state.extra` is cast from `Map<String, dynamic>`; exceptions thrown if params are missing
- `MorseCodeLearningParams`: carries learning type, amount, UI type, repetitions, and exercise data
- `OrientationExerciseParams`: carries exercise data (names, imageLoc, areCombinationsCorrect)
- `WebviewContainer`: carries `{ url: string }`

---

## 6. ASSETS

### Images
```
assets/images/
├── rsk_logo.png
├── single_separator_forest.png
├── taborniski_sos_prirocnik_logo.png    (⚠️ unclear: not confirmed in pubspec assets list)
├── semaphore/flags/
│   ├── A_1.png … Z.png                 (26 letters + Slovenian Č, Š, Ž variants)
│   ├── K_0.png, I_9.png …              (number variants)
│   ├── numerals.png, letters.png
│   ├── space.png, error.png, cancel.png
│   └── ~45 flag images total
└── topografija/
    ├── geodetske_tocke/                 gt_1.jpeg, gt_2.jpeg, gt_3.jpeg
    ├── meje_in_ograje/                  mo_1.jpeg … mo_5.jpeg
    ├── morje_in_morska_obala/           mmo_1.jpeg … mmo_25.jpeg
    ├── naselja_in_objekti/              (directory exists, contents unconfirmed)
    ├── promet_komunikacije/             (directory exists, contents unconfirmed)
    ├── rastje_in_vrste_tal/             (directory exists, contents unconfirmed)
    ├── relief/                          (directory exists, contents unconfirmed)
    └── vodovje/                         (directory exists, contents unconfirmed)
```

### Icons (SVG)
```
assets/icons/
├── morse_code_icon.svg
└── card_swipe_icon.svg
assets/forest_separator_single.svg
```

### PDFs
```
assets/pdfs/
├── GSJ23_razpis.pdf
├── topografski-znaki-za-dtk25.pdf
├── Bodi_pripravljen_2.pdf
├── international_alphabet.pdf
├── semafor_abeceda.pdf
├── Semaphore.pdf
└── orientation/
    ├── orientacija_karta.pdf
    ├── orientacija_zvezde.pdf
    ├── orientacija_kompas.pdf
    ├── orientacija_splosno.pdf
    └── orientacija_navigacija_azimuti.pdf
```

### Fonts
```
assets/fonts/
├── CustomIcons.ttf
└── JetBrainsMono/
    ├── JetBrainsMono-Regular.ttf
    ├── JetBrainsMono-Bold.ttf
    └── 30+ variant files (Italic, ExtraBold, Light, Medium, SemiBold, Thin;
                           both JetBrainsMono-* and JetBrainsMonoNL-* prefixes)
```

### Environment
```
assets/.env       (loaded by flutter_dotenv; contains BASE_URL)
```

---

## 7. INCOMPLETE OR BROKEN

### Features Marked "Coming Soon"
- **Semaphore Exercises** (`semaphore.dart`): Button rendered with "Coming Soon" overlay; `onPressed` is empty
- **Orientation "More" button** (`orientation.dart`, line ~229): Tapping shows "Coming Soon" dialog; no content behind it

### Empty / Stub Handlers
- **CustomAppBar info button** (`settings.dart`, line ~404): `onPressed: () {}` — no action
- **Settings permissions button** (`settings.dart`, line ~537): `ElevatedButton` with `onPressed: () {}` — no action despite `permission_handler` being a declared dependency

### State Management Issues
- **MorseExerciseBloc** and **OrientationExerciseBloc** state classes use mutable `List<?>` properties with positional constructor params that have no type annotations — inconsistent with idiomatic BLoC immutability patterns
- **MorseExerciseStart event** (`morse_exercise_event.dart`, line 11): `areTranslationsCorrect` is a positional parameter placed before named parameters — inconsistent with other event constructors

### Unclear Implementations
- **LearningKeyboard** (`learning_type_widgets/learning_keyboard.dart`): Referenced in LearningScreen but full keyboard input validation logic not confirmed
- **WebviewContainer**: Route `/webview` registered in router but no UI trigger for it was found in any screen
- **PDFScreen widget**: Used in orientation.dart navigation calls, but import/definition location not confirmed
- **`taborniski_sos_prirocnik_logo.png`**: Referenced in about dialog in settings.dart but not confirmed to be listed in pubspec.yaml assets

### Debug Code in Production
- **PostApiService** (`post_api_service.dart`, line 20): `print(responseJson)` left in production path

### Validation Edge Cases
- **MorseExerciseBloc** (`morse_exercise_bloc.dart`, line ~82): `swiperDirection` is nullable but used in validation without a null check in some code paths — ⚠️ unclear what happens when null during card swipe validation

### Commented-Out Code
- **morse_code_learning_selector.dart** (lines ~60–90): Large block of old UI code left commented out

### Two PDF Viewer Packages
- Both `flutter_cached_pdfview` and `flutter_pdfview` are declared as dependencies — ⚠️ unclear which is canonical and whether both are actually used
