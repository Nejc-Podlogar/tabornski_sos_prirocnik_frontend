# DESIGNS.md — Taborniški S.O.S Priročnik

---

## 1. SCREEN INVENTORY

### S1 — Onboarding Slide 1: Welcome ("Dobrodošel")
**Source:** Group_223.png (leftmost panel)
- Full green background (#5E8C61 range)
- App name top: "Taborniški S.O.S Priročnik" (small caps, white)
- Large white bold title: "DOBRODOŠEL" (monospaced/condensed font)
- Decorative bottom strip: white line-art pattern of mountains, trees, fence
- Body text: paragraph describing the app (Slovenian)
- Bottom-left: circular arrow button (icon only, white on green)
- No header bar, no bottom nav

### S2 — Onboarding Slide 2: Features ("Kaj ponuja aplikacija")
**Source:** Group_223.png (center panel)
- Same full green background and decorative strip
- Title: "KAJ PONUJA APLIKACIJA"
- Bullet list of features (Slovenian):
  - Prevajanje besedila v Morsejevo abecedo in semafor
  - Svetlobno oddajanje Morsejeve kode (mobilne naprave)
  - Interaktivno učenje z avtomatskimi testi
  - Gradivo za učenje orientacije in topografskih znakov
  - Prenos gradiva in rezultatov
- Bottom: circular arrow button

### S3 — Onboarding Slide 3: CTA ("Začni z učenjem!")
**Source:** Group_223.png (rightmost panel)
- Same full green background and decorative strip
- Title: "ZAČNI Z UČENJEM!"
- Body: "Praktično, pregledno in vedno pri roki – pripravljeni si, da začneš!"
- Bottom: pill-shaped CTA button "ZAČNI Z UPORABO →" (white text, outlined style, larger than arrow button)

---

### S4 — Morse Code Section Home ("Morsejeva abeceda")
**Source:** Morsejeva_abeceda_HOME_Test.png
- Header bar: back/home icon (left), title "Morsejeva abeceda", info ⓘ icon (right)
- Body: Lorem ipsum placeholder text block (center-aligned)
- 2×2 grid of large green rounded-square action tiles (3 visible, third centered on row 2):
  - Tile 1: Translate icon (A↔字 style) — ⚠️ label not visible
  - Tile 2: Brain icon — ⚠️ label not visible
  - Tile 3: Open book icon — ⚠️ label not visible
- "Gradiva:" section heading below tiles
- Horizontal row of 4 purple-outlined document icon tiles (labeled "Gradivo" under first)
- Bottom nav bar (4 items)
- Active nav item: Morse (dash-dot icon, leftmost)

---

### S5 — Semaphore Section Home ("Semafor")
**Source:** Semafor_HOME.png
- Identical layout to S4 (Morse Home)
- Header: "Semafor", home icon left, ⓘ right
- Same 3 green action tiles (Translate, Brain, Book icons)
- "Gradiva:" section with 4 purple document tiles (no labels visible)
- Bottom nav bar: active item is Semaphore (crossed-flags icon, second from left, purple)
- No bottom nav visible below Gradiva tiles (screen truncated at bottom in this image)

---

### S6 — Orientacija Section Home ("Orientacija")
**Source:** Group_224.png
- Header: home icon (left), "Orientacija", ⓘ (right)
- Body: Lorem ipsum placeholder text
- One wide full-width green tile: "Topografija" (with shield+leaf icon left, brain icon right, separated by vertical divider line)
- 2×3 grid below (smaller tiles, equal size):
  - Row 1: "Naloge na karti" (map-pin icon), "Naloge na terenu" (mountain icon)
  - Row 2: "Naloge na tekmovanjih" (clipboard-check icon), "Okolje" (shield+leaf icon), placeholder tile ("…", muted/disabled appearance, greyed-out)
- "Gradiva:" heading
- 4 purple-outlined document icon tiles (horizontal row)
- Bottom nav: active item is Orientacija (globe icon, third from left)

---

### S7 — Morse Code Translator ("Prevedi")
**Source:** Morsejeva_abeceda_prevajalnik.png
- Header: back arrow (left), "Morsejeva abeceda / Prevedi" (two-line or subtitle), ⓘ (right)
- Two text areas stacked vertically occupying most of the screen (white background, separated by thin grey line)
  - Top area: input text field (empty), backspace icon (top-right corner of area)
  - Bottom area: output/result area, flag/send icon (bottom-right corner)
- Bottom action row (above keyboard): trash icon (left), copy icon (right)
- Drag handle bar (horizontal pill) in center above the bottom panel
- Bottom pill/panel (green background):
  - Left purple pill button: "Besedilo" (text mode)
  - Center: arrow "→" (direction indicator)
  - Right purple pill button: "•—" (Morse mode)
- Bottom nav bar (4 items)

---

### S8 — Morse Characters Reference ("Znaki morsejeve abecede")
**Source:** Morsejeva_abeceda_znaki.png
- Header: back arrow (left), "Znaki morsejeve abecede", ⓘ (right)
- Filter chips row: "Vsi" (active, purple fill, white text), "Črke" (outlined), "Številke" (outlined)
- Scrollable list of full-width green rounded-rectangle tiles, each containing:
  - Left: letter label (A, B, C…) + vertical separator bar
  - Right: Morse pattern rendered as visual dots and dashes (white circles and rectangles)
- ⚠️ unclear: letter labels appear to repeat (A, B, C, C visible multiple times) — may be placeholder/test data
- Bottom nav bar (4 items)

---

### S9 — Morse Learning Setup ("Morse code learning")
**Source:** Morse_code_learning.png
- Header: back arrow (left), "Morse code learning" (English), ⓘ (right)
- "Zgodovina učenja" pill button (outlined, full-width, near top)
- Divider line
- Section: "Tip učenja:" — segmented control:
  - "Oddajanje" (active, green fill), "Sprejemanje" (inactive, outlined)
- Section: "Količina besedila:" — segmented control:
  - "Črke" (active, green fill), "Besede" (inactive), "Stavki" (inactive, full row)
- Section: "Uporabniški vmesnik:" — 3 icon tiles in a row (equal width):
  - "Card swipe" (card-stack icon, active/selected with shadow/elevation)
  - "Keyboard" (keyboard icon, inactive)
  - "Token selector" (toggle/token icon, inactive)
- Section: "Število ponovitev:" — 4 outlined pill chips: 1, 5, 10 (active, green fill), 20
- CTA button: "Začni z učenjem" (full-width, green fill, white text, large rounded pill)
- Bottom nav bar (4 items)

---

### S10 — Card Swipe Exercise
**Source:** Card_swipe_exercise.png
- Header: back arrow (left), no title visible, ⓘ (right)
- Timer display: "00:12:00" in outlined pill (center top)
- Large flashcard widget (white card, rounded corners, drop shadow):
  - Upper portion: green rounded rectangle area showing the letter "A"
  - Lower portion: white area with Morse pattern (•  —) rendered as dot + dash
- Progress label + dot-row indicator below card:
  - Colored dots: purple×(wrong), green×(correct), mixed, then empty circles
  - ⚠️ unclear: exact ordering/meaning of mixed dot states
- 3 action buttons (circle icons, bottom):
  - Left: ✕ (wrong, outlined circle, dark)
  - Center: ? (help/skip, outlined circle, grey/muted)
  - Right: ✓ (correct, filled green circle)

---

### S11 — Keyboard Exercise (Base state)
**Source:** Keyboard_exercise.png
- Header: back arrow (left), no title, ⓘ (right)
- Title text: "Prevedi sledeči stavek" (bold, large)
- Hint row: ⓘ icon + instruction text (Slovenian, small)
- Source sentence: purple icon badge + underlined sentence "Taborništvo je zakon"
- Large input text area (rounded rectangle, muted green/grey background):
  - Placeholder: "Type the translation..." (English, grey italic)
- Progress row: colored dot indicators (same pattern as S10)
- Primary button: "Preveri" (full-width, green fill, white text)

### S11a — Keyboard Exercise (Correct answer state)
**Source:** Keyboard_exercise1.png
- Same as S11 base
- Bottom sheet overlaid (white, rounded top corners):
  - Green circle ✓ icon + "Pravilen odgovor" (green text, bold)
  - "Nadaljuj" button (full-width, green fill)

### S11b — Keyboard Exercise (Wrong answer state)
**Source:** Keyboard_exercise2.png
- Same as S11 base
- Bottom sheet overlaid (white, rounded top corners):
  - Purple circle ✕ icon + "Napačen odgovor" (purple text, bold)
  - "Pravilen odgovor:" label + correct Morse string displayed
  - "Nadaljuj" button (full-width, purple fill, white text)

---

### S12 — Settings Home (Light mode)
**Source:** Settings_HOME.png
- Header: home icon (left), "Settings", ⓘ (right)
- Top hero section (green background, rounded bottom corners):
  - Circular avatar (white circle, person silhouette icon)
  - Username "Marko" with edit pencil icon
- "PREFERENCES" section header (muted/brown-grey background bar, uppercase label)
- List items (each row: icon + label + trailing control):
  - 🌙 Dark mode → toggle switch (OFF)
  - 🔔 Allow notifications → toggle switch (ON, green)
  - 👥 Permissions → "MANAGE" chip button (small, outlined)
  - 🗄️ Delete data → trash icon button
- Bottom nav bar (4 items), active: Settings (gear icon, purple)

### S12b — Settings Home (Dark mode)
**Source:** Settings_HOME_Dark.png
- Same structure as S12
- Background changes: white → very dark green (#1A2A1A approximate)
- "PREFERENCES" bar: darker olive-green
- List text: muted light green instead of dark grey
- Toggle switches: same colors
- Settings gear icon in nav: outlined (not filled) in dark mode ⚠️ unclear: intentional or asset variant
- Avatar section: same medium green, unchanged

### S12c — Settings with Delete Confirmation (Dark mode)
**Source:** Settings_HOME_Dark_Local_Storage.png
- Settings_HOME_Dark layout + floating confirmation card at bottom:
  - Purple filled rounded card
  - Trash icon (outlined, white, circular border)
  - Text: "All of the local data has been deleted" (white, centered)

### S12d — Settings Delete Confirmed (Light mode)
**Source:** Settings_Deleted_local_storage.png
- Same as S12 light + same purple card (identical card, light mode context)

---

## 2. DESIGN SYSTEM

### Colors

#### Brand Palette (from Taborniski_s_o_1.png — official Coolors export)
| Token | Hex | Role |
|---|---|---|
| Purple | `#622599` | Accent, active states, buttons, wrong-answer feedback |
| Black | `#050505` | Text primary (light mode) |
| White | `#FFFFFF` | Text on colored backgrounds, card backgrounds |
| Green (primary) | `#5E8C61` | Section tiles, header backgrounds, CTAs, list items |
| Olive/Dark green | `#656839` | ⚠️ unclear: not visibly used in UI screens; may be reserved |

#### Derived / Observed UI colors
| Usage | Approximate value |
|---|---|
| Light mode background | `#FFFFFF` |
| Dark mode background | `#192219` (very dark green) |
| Muted green (input fields, inactive) | `#C5C8B8` approx |
| Muted beige/taupe (section headers) | `#B8B49A` approx |
| Disabled tile background | `#B8B49A` approx |
| Green toggle ON | `#5E8C61` |
| Morse list tile background | `#5E8C61` |
| Progress dot — correct | `#5E8C61` (green) |
| Progress dot — wrong | `#622599` (purple) |
| Progress dot — empty | `#CCCCCC` (light grey outline) |

---

### Typography

All text appears to use a **monospaced or condensed sans-serif** typeface throughout (consistent with the scout/technical aesthetic). ⚠️ unclear: exact font family not confirmed from images alone.

| Role | Weight | Size (approx) | Case |
|---|---|---|---|
| Onboarding title | Bold | ~32–36px | ALL CAPS |
| Screen header/title | Medium | ~18px | Title Case |
| Section heading | Regular | ~16px | Title Case |
| Body / description | Regular | ~13–14px | Sentence |
| List label | Regular | ~14px | Sentence |
| Filter chip | Regular | ~12px | Sentence |
| Button label | Medium/Bold | ~14–16px | Title Case |
| Progress label | Regular | ~12px | Title Case |
| Small hint text | Regular | ~11–12px | Sentence |
| Morse pattern text | Regular/Monospace | ~13px | — |

---

### Corner Radius
| Component | Radius |
|---|---|
| Large action tiles (Morse/Semafor home) | ~20px |
| Orientacija sub-tiles | ~16px |
| Full-width list tiles (znaki) | ~12px |
| Flashcard | ~20px |
| Flashcard inner green area | ~16px |
| Input text area | ~12px |
| CTA button (pill) | ~50px (fully rounded) |
| Filter chip | ~50px (fully rounded) |
| Segmented control segments | ~8px |
| UI selector tiles (card/keyboard/token) | ~12px |
| Timer pill | ~50px |
| Avatar circle | ~50% |
| Delete confirmation card | ~16px |
| Settings hero section | ~0px top, ~24px bottom |
| Onboarding CTA button | ~50px |

---

### Spacing Patterns
- Screen horizontal padding: ~16–20px
- Between major sections: ~24–32px
- Between list items: ~8px (tight list)
- Between action tiles (grid): ~12px gap
- Between filter chips: ~8px gap
- Between segmented control options: ~0px (connected)
- Between repetition count chips: ~8px gap
- Bottom nav height: ~56px
- Header bar height: ~56px

---

### Icon Style
- **All icons are outlined / line-art style** (no filled icons except for active states)
- Stroke weight: medium (~2px)
- Icon size in tiles: ~32–40px
- Icon size in nav bar: ~24px
- Icon size in list rows: ~20px
- Custom icons: mountains/trees decorative strip (onboarding), Morse dot/dash patterns
- App logo (image_1.png): diamond grid with 4 quadrants — fleur-de-lis (top), semaphore flags (right), Morse circles (left), compass (bottom) — white line art on purple/white alternating quadrants, black border

---

## 3. COMPONENT PATTERNS

### C1 — App Header Bar
Present on all non-onboarding screens.
- Height: ~56px
- Left slot: back arrow (`←`) OR home icon (`⌂`)
- Center: screen title (medium weight, ~18px)
- Right slot: info icon `ⓘ` (outlined circle)
- Background: white (light mode) / dark green (dark mode)
- No elevation/shadow visible

### C2 — Bottom Navigation Bar
4 items, persistent across section screens.
- Height: ~56px
- Items (left to right):
  1. Morse (dash-dot icon) — label: none visible
  2. Semaphore (crossed flags icon)
  3. Orientacija (globe icon)
  4. Settings (gear icon)
- Active item: icon turns purple, no label visible
- Inactive items: dark grey/black icon
- Background: white (light) / dark (dark mode)
- Top border: thin grey separator

### C3 — Large Section Action Tile
Used on Morse Home, Semafor Home.
- Size: ~140×140px square
- Background: `#5E8C61` green
- Corner radius: ~20px
- Icon: white outlined, ~40px, centered
- ⚠️ unclear: label text below or inside tile not confirmed (no text visible in design)
- Layout: 2 per row (row 1), 1 centered (row 2)

### C4 — Gradiva Document Tile
Used on Morse Home, Semafor Home, Orientacija Home.
- Size: ~64×64px
- Border: purple outlined (~2px)
- Background: white
- Icon: purple document/file icon, centered
- Optional label below (only "Gradivo" seen once)
- Corner radius: ~12px
- Layout: 4 in a horizontal row

### C5 — Orientacija Feature Tile (Wide)
Used on Orientacija Home — "Topografija" tile.
- Full width (~320px)
- Height: ~64px
- Green background
- Left: outlined icon + label text (left-aligned)
- Right: brain icon (right-aligned)
- Vertical divider line in center
- Corner radius: ~12px

### C6 — Orientacija Feature Tile (Square, small)
Used on Orientacija Home — sub-feature tiles.
- Size: ~144×80px (2-per-row)
- Green background (active) / muted grey-green (disabled)
- Icon centered above label
- Label: ~12px, white, centered
- Corner radius: ~16px
- Disabled state: `#B8B49A` background, same layout

### C7 — Morse Character List Item
Used on Znaki screen.
- Full width, ~48px height
- Background: `#5E8C61` green
- Corner radius: ~10px
- Left: letter (white, bold, ~16px) + vertical white bar separator
- Right: Morse pattern (white dots = circles, dashes = rounded rectangles), left-aligned in right half
- 8px vertical gap between items

### C8 — Filter Chip
Used on Znaki screen.
- Pill shape, ~50px radius
- Active: purple fill `#622599`, white text
- Inactive: white background, grey/dark outline
- Text: ~12px, medium weight
- 8px gap between chips

### C9 — Segmented Control
Used on Morse Learning Setup (Tip učenja, Količina besedila).
- Horizontally grouped, connected (no gap)
- Active segment: green fill, white text
- Inactive segment: white/light background, grey border, dark text
- Height: ~36px
- Corner radius: ~8px on outer edges only (pill ends)

### C10 — UI Selector Tile (Learning mode picker)
Used on Morse Learning Setup.
- 3 equal tiles in a row
- Size: ~96×80px
- Background: white
- Border: light grey outline
- Active state: elevated shadow (selected)
- Icon: outlined, ~32px, centered
- Label: ~11px below icon
- Corner radius: ~12px

### C11 — Repetition Count Chip
Used on Morse Learning Setup.
- Small outlined pill, ~36px wide
- Active: green fill, white text
- Inactive: white, grey border, dark text
- Values: 1, 5, 10, 20

### C12 — Primary CTA Button
Used on Morse Learning Setup, exercise feedback sheets.
- Full width (~320px)
- Height: ~52px
- Fully rounded pill
- Active/default: green fill `#5E8C61`, white text, bold
- Wrong-answer state: purple fill `#622599`, white text
- Text: ~16px, bold

### C13 — Flashcard
Used on Card Swipe Exercise.
- White card, ~290×350px
- Border: very light grey
- Corner radius: ~20px
- Drop shadow (elevated)
- Upper portion: green rounded rectangle (~290×180px), displays letter (white, large bold ~64px)
- Lower portion: white, displays Morse pattern (dot circle + dash rectangle), centered

### C14 — Progress Dot Row
Used on Card Swipe and Keyboard exercises.
- Label: "Progress" (small, above row)
- Row of ~14 circular dots, small (~14px each), spaced ~4px
- States: green fill (correct), purple fill (wrong), light grey outline (upcoming/empty)
- ⚠️ unclear: mixed dot state (half-filled?) seen in Card Swipe — may indicate current item

### C15 — Exercise Action Buttons (Card Swipe)
3 circular icon buttons at bottom.
- Size: ~56px diameter
- Left: ✕ wrong — outlined dark circle
- Center: ? help/skip — outlined grey circle
- Right: ✓ correct — solid green circle
- Icons: white, outlined, ~24px

### C16 — Exercise Feedback Bottom Sheet
Used on Keyboard exercises.
- Slides up from bottom (partial overlay)
- Background: white
- Corner radius: ~16px top corners
- Correct state:
  - Green ✓ circle icon (filled)
  - "Pravilen odgovor" text (green, bold)
  - Green CTA button
- Wrong state:
  - Purple ✕ circle icon
  - "Napačen odgovor" text (purple, bold)
  - "Pravilen odgovor:" label + correct answer text
  - Purple CTA button

### C17 — Keyboard Exercise Input Area
- Rounded rectangle, ~290×240px
- Background: muted sage/grey-green (~`#C5C8B8`)
- No border visible
- Placeholder text: "Type the translation..." (grey italic)
- Corner radius: ~12px

### C18 — Source Sentence Row (Keyboard exercise)
- Row: purple filled circle icon badge (left) + underlined sentence text (right)
- Badge: ~32px circle, purple fill, white icon (translation/swap icon)
- Text: body size, underline decoration on sentence

### C19 — Timer Pill (Card Swipe)
- Centered at top
- Outlined pill (no fill), ~120px wide
- Text: "00:12:00" monospaced, ~14px
- Corner radius: ~50px

### C20 — Settings Hero Section
- Full-width, green background `#5E8C61`
- Rounded bottom corners (~24px)
- Avatar: white circle (~80px), person silhouette icon (grey)
- Username text: white, ~16px, centered
- Edit icon: small pencil, inline with username

### C21 — Settings Row Item
- Full-width list row, ~52px height
- Left: outlined icon (~20px) + label text
- Right: toggle switch OR chip button OR icon button
- Thin bottom separator line
- Toggle ON: green thumb/track
- Toggle OFF: grey
- "MANAGE" chip: small outlined, dark text, ~8px padding

### C22 — Settings Section Header
- Full-width, muted beige/taupe background bar
- Text: "PREFERENCES" uppercase, ~12px, bold/medium
- Height: ~36px
- Padding: ~16px left

### C23 — Delete Confirmation Card
- Full-width rounded card, purple fill `#622599`
- Centered: trash icon in outlined white circle (~48px) + text below
- Text: "All of the local data has been deleted", white, centered, ~14px
- Corner radius: ~16px
- Appears as overlay/toast at bottom of Settings screen

### C24 — Translator Direction Toggle (Bottom Panel)
Used on Morse Translator.
- Green background panel (bottom ~180px of screen)
- Left pill button: "Besedilo" (purple fill, white text)
- Center: "→" arrow (white)
- Right pill button: "•—" Morse symbol (purple fill, white text)
- Drag handle above panel: horizontal pill (black, centered)

### C25 — Translator Text Areas
- Two areas separated by thin grey horizontal line
- White background
- Backspace icon (top-right of first area)
- Flag/send icon (bottom-right of second area)
- Action row: trash icon (far left) + copy icon (far right), above green panel

### C26 — History Button
Used on Morse Learning Setup.
- Full-width, outlined pill
- White background, dark border
- Text: "Zgodovina učenja" (center)
- Height: ~40px

### C27 — Onboarding Navigation Button
- Circular button, ~48px
- Arrow icon (→), white
- Outlined circle (no fill visible, or very subtle outline on green bg)
- Final slide: pill-shaped "ZAČNI Z UPORABO →" button (outlined, wider)

---

## 4. LAYOUT PATTERNS

### Section Home Screens (Morse, Semafor)
1. Header bar
2. Body text block (center-aligned, ~8 lines, placeholder)
3. 3-tile action grid (2+1 layout, equal-size squares)
4. "Gradiva:" label
5. 4-tile horizontal document row
6. Bottom nav

### Orientacija Home
1. Header bar
2. Body text block
3. 1 full-width wide tile (Topografija)
4. 2×3 grid of smaller tiles (with 1 disabled placeholder)
5. "Gradiva:" label
6. 4-tile horizontal document row
7. Bottom nav

### Exercise Screens (Card Swipe, Keyboard)
1. Header bar (back + info only, no title)
2. Exercise-specific content area (takes most of screen)
3. Progress row
4. Action controls at bottom
5. No bottom nav (full-screen exercise mode)

### Settings
1. Header bar
2. Hero section (avatar, name)
3. Section header ("PREFERENCES")
4. List of settings rows
5. Optional: confirmation card at bottom
6. Bottom nav

### Translator
1. Header bar
2. Two text areas (top half / bottom half split)
3. Action icon row
4. Drag handle
5. Direction toggle panel (bottom)
6. Bottom nav

### Znaki (Character List)
1. Header bar
2. "Filtri:" label + chip row
3. Full-width scrollable list
4. Bottom nav

### Learning Setup
1. Header bar
2. History button
3. Divider
4. Multiple labeled option sections (segmented controls, tile pickers, chips)
5. Full-width CTA at bottom
6. Bottom nav

---

## 5. DARK vs LIGHT MODE

### What changes
| Element | Light | Dark |
|---|---|---|
| Screen background | `#FFFFFF` white | `#192219` very dark green |
| Settings list area | white | dark green |
| "PREFERENCES" header bar | muted beige `#B8B49A` | dark olive `#3A4A30` approx |
| Settings row text | dark / black | muted light green |
| Bottom nav background | white | dark green |
| Settings gear nav icon | purple filled | purple outlined ⚠️ |

### What stays the same
- Header bar green hero section (Settings) — unchanged
- All toggle colors (ON = green, OFF = grey)
- Purple accent color `#622599`
- Green tile colors `#5E8C61`
- Avatar section
- Icon stroke styles

---

## 6. NAVIGATION PATTERNS

### Bottom Nav Items (left → right)
1. **Morse** — dash-dot icon (`— •`) — navigates to Morse section home
2. **Semaphore** — crossed flags icon — navigates to Semaphore section home
3. **Orientacija** — globe icon — navigates to Orientacija section home
4. **Settings** — gear icon — navigates to Settings home

Active item highlighted in purple. No labels visible on nav items.

### Back Navigation
- Back arrow (`←`) in header returns to previous screen
- Home icon (`⌂`) in header returns to app root/home ⚠️ unclear: whether there is a separate top-level home screen distinct from section homes

### Screen Connections (observed)
- Morse Home → Translator (via translate tile)
- Morse Home → Znaki/Characters (via book tile)
- Morse Home → Learning Setup (via brain tile)
- Learning Setup → Card Swipe Exercise (via "Začni z učenjem")
- Learning Setup → Keyboard Exercise (via "Začni z učenjem" with keyboard UI selected)
- Keyboard Exercise → feedback sheet (inline state, not a separate screen)
- Settings → delete confirmation (inline state overlay)
- Onboarding Slide 1 → Slide 2 → Slide 3 → App (→ button / "Začni z uporabo")

---

## 7. MISSING SCREENS

Cross-referenced against feature list:

| Feature | Design visible? | Notes |
|---|---|---|
| Home screen (news post) | ❌ MISSING | No screen with news feed / post list visible |
| Onboarding slides | ✅ Present | Group_223.png shows all 3 slides |
| Semaphore translator | ❌ MISSING | Semafor Home tile implies it exists; no design shown |
| Semaphore learning exercises | ❌ MISSING | Semafor Home brain tile implies it; no design shown |
| Audio Morse transmission | ❌ MISSING | Listed in onboarding features; no screen shown |
| Morse flashlight transmitter | ❌ MISSING | Listed in onboarding features; no screen shown |
| Settings detail screens | ❌ MISSING | "Permissions → MANAGE" implies a sub-screen; not shown |
| Orientacija: Topografija | ❌ MISSING | Tile visible, no content screen |
| Orientacija: Naloge na karti | ❌ MISSING | Tile visible, no content screen |
| Orientacija: Naloge na terenu | ❌ MISSING | Tile visible, no content screen |
| Orientacija: Naloge na tekmovanjih | ❌ MISSING | Tile visible, no content screen |
| Orientacija: Okolje | ❌ MISSING | Tile visible, no content screen |
| Token Selector exercise UI | ❌ MISSING | Third UI mode shown in setup; no exercise screen |
| Learning history screen | ❌ MISSING | "Zgodovina učenja" button visible, no screen shown |
| User profile / edit name | ❌ MISSING | Edit icon on Settings implies a screen; not shown |

---

## 8. ADDITIONAL ASSETS

### App Logo (image_1.png)
- Diamond (rotated square) grid, 2×2 quadrants
- Top quadrant: white background, fleur-de-lis icon (outlined, dark)
- Left quadrant: purple background, Morse circles pattern icon (white)
- Right quadrant: purple background, semaphore flags icon (white)
- Bottom quadrant: white background, compass icon (outlined, dark)
- Black border around all quadrants

### Color Palette Reference (Taborniski_s_o_1.png)
- Official palette exported from Coolors.co
- Label: "Taborniski s.o.s prirocnik color palet"
- 5 swatches: `#622599`, `#050505`, `#FFFFFF`, `#5E8C61`, `#656839`

### Single_separator_forest.png
- ⚠️ unclear: image appears blank/white — likely a decorative divider asset (forest/mountain line-art strip used in onboarding) that rendered as white-on-white

---

*End of DESIGNS.md*
