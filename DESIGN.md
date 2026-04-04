# DESIGN.md — Taborniški S.O.S Priročnik

Generated from Stitch AI screen designs. This is the single source of truth
for all UI decisions. Claude Code must follow this file for every widget,
screen, and component built in Flutter.

---

## 1. Visual Theme & Atmosphere

**Mood**: Tactical outdoor reference tool. Dark, nature-grounded, purposeful.
Not playful, not corporate. Feels like a field manual — serious but accessible
to younger users.

**Design philosophy**:
- Dark-first. All screens default to dark mode. Light mode is secondary.
- High contrast. Text must be readable in outdoor conditions.
- Generous touch targets. Primary targets minimum 48×48dp.
- Content density is low — each screen has one clear purpose.
- Nature metaphors: forest greens, earthy olives, deep darks.
- Typography is bold and assertive for headings, clean and readable for body.

**Visual personality**: Military-adjacent without being aggressive. Scout
handbook meets modern mobile app.

---

## 2. Color Palette & Roles

### Brand Colors (strict — never deviate)

| Token | Hex | Role |
|---|---|---|
| `--color-primary` | `#5E8C61` | Primary green — tiles, active states, CTAs, section headers |
| `--color-primary-light` | `#8DB88F` | Light green — text on dark surfaces, icons, labels |
| `--color-primary-dark` | `#3A5C3C` | Dark green — pressed states, deep surfaces |
| `--color-accent` | `#622599` | Purple — active nav item, accent chips, wrong-answer state |
| `--color-accent-light` | `#9B6CC7` | Light purple — accent text, secondary badges |
| `--color-olive` | `#656839` | Olive — secondary surfaces, muted backgrounds, section dividers |
| `--color-surface` | `#1A2A1A` | Dark surface — card backgrounds, list items |
| `--color-background` | `#0F1A0F` | Page background — deepest dark |
| `--color-background-alt` | `#192219` | Alternate background — slightly lighter than base |
| `--color-text-primary` | `#FFFFFF` | Primary text on dark surfaces |
| `--color-text-secondary` | `#8DB88F` | Secondary/muted text — subtitles, labels, captions |
| `--color-text-tertiary` | `#5A7A5C` | Tertiary — disabled, hints, timestamps |
| `--color-danger` | `#C0392B` | Destructive actions only — delete button |
| `--color-danger-surface` | `#3D1010` | Danger card background |
| `--color-correct` | `#5E8C61` | Correct answer feedback (same as primary) |
| `--color-wrong` | `#622599` | Wrong answer feedback (same as accent) |

### Semantic Usage Rules

- **Never use white backgrounds** on any screen except the onboarding CTA button
- **Never use pure black** (`#050505`) as a background — use `--color-background`
- **Danger zone** (delete, critical actions) always uses `--color-danger-surface`
  background with `--color-danger` text/icon
- **Active nav item** always `--color-accent` fill, circular shape
- **Correct/wrong feedback** green vs purple — never red for wrong answers

---

## 3. Typography Rules

### Font Family
Primary: System sans-serif (Inter or Roboto on Android, SF Pro on iOS)
Monospace: System mono — used for Morse code dot-dash sequences only

### Type Scale

| Role | Size | Weight | Color | Usage |
|---|---|---|---|---|
| Screen title | 28–32sp | 700 Bold | `--color-text-primary` | Main screen heading |
| Section label | 11sp | 600 | `--color-text-secondary` | Uppercase overline (e.g. "MODUL ZA URJENJE") |
| Card title | 18–22sp | 700 | `--color-text-primary` | Tile/card primary label |
| Card subtitle | 13–14sp | 400 | `--color-text-secondary` | Tile description |
| Body text | 15–16sp | 400 | `--color-text-primary` | Paragraphs, descriptions |
| Caption | 11–12sp | 400 | `--color-text-tertiary` | Timestamps, metadata, fine print |
| Button label | 14–16sp | 600 | `--color-text-primary` | All button text, uppercase permitted |
| Nav label | — | — | — | No labels on bottom nav |
| Filter chip | 13sp | 500 | Context | Active: dark text, inactive: secondary |
| Morse sequence | 14–16sp | 400 | `--color-accent-light` | Monospace, dots and dashes |
| Overline | 11sp | 600 | `--color-text-secondary` | Uppercase, letter-spacing 1.2px |

### Typography Rules
- Screen titles may be ALL CAPS when used as hero text (onboarding, section headers)
- Overlines always uppercase, always `--color-text-secondary`
- Body text line-height: 1.5
- Never use font size below 11sp
- Bold (700) for titles only — never for body text

---

## 4. Component Stylings

### 4.1 Bottom Navigation Bar

```
Structure: 4 icons, no labels
Background: --color-surface (slightly lighter than page bg)
Height: 60dp + bottom safe area
Active item: circular pill, --color-accent fill, icon white
Inactive item: icon --color-text-tertiary
Icon size: 22dp
Active pill size: 48dp diameter
Border: none (blends into surface)

Items (left → right):
  1. Home — house icon
  2. Morse/Signal — wifi/signal waves icon
  3. Semaphore — flag icon
  4. Orientacija — compass icon
```

### 4.2 App Header Bar

```
Height: 56dp
Background: --color-background (transparent over content)
Left: avatar (32dp circle) + app name "Taborniški S.O.S Priročnik"
  — avatar uses scout-character illustration
  — app name: 14sp, 600 weight, --color-primary-light
Right: gear icon (settings shortcut) — 24dp, --color-text-secondary
No back arrow on top-level screens
Back arrow on sub-screens: left chevron, 24dp
```

### 4.3 Primary Action Card (Section Tile)

Used on section home screens (Morse, Semaphore, Orientacija).

```
Shape: rounded rectangle, radius 16dp
Background: --color-surface
Size: full-width or 2-column grid
Padding: 20dp
Content:
  - Icon circle (40dp, --color-primary with 20% opacity bg, icon --color-primary)
  - Title: 18sp bold, --color-text-primary
  - Subtitle: 13sp, --color-text-secondary
  - Trailing arrow → : 16dp, --color-text-tertiary
Hover/pressed: --color-primary-dark background, slight scale(0.98)
```

### 4.4 Hero Banner Card

Used at top of section home screens.

```
Shape: rounded rectangle, radius 16dp
Background: --color-surface with subtle background image (low opacity, dark overlay)
  OR solid --color-surface with gradient dark overlay
Height: 140–180dp
Content:
  - Overline: 11sp uppercase, --color-text-secondary
  - Title: 28sp bold, --color-text-primary
  - Subtitle: 14sp, --color-text-secondary, max 2 lines
```

### 4.5 Bottom Navigation Active State

```
Active tab: circular button, 48dp, --color-accent fill
Icon inside: white, 22dp
Inactive: icon only, no background, --color-text-tertiary
Transition: fade + scale, 150ms
```

### 4.6 Segmented Control (2 options)

Used for Oddajanje/Sprejemanje, Swipe/Tipkovnica.

```
Container: rounded rectangle, radius 12dp, --color-surface
Selected segment: rounded rectangle, radius 10dp, --color-primary
  Text: 14sp, 600, --color-text-primary
Unselected: transparent
  Text: 14sp, 400, --color-text-secondary
Height: 44dp
Padding: 4dp around segments
Transition: 200ms
```

### 4.7 Content Selector (3+ options, vertical list)

Used for Črke/Besede/Stavki content selection.

```
Container: rounded rectangle, radius 12dp, --color-surface
Each option: full-width row, 64dp height
  - Icon: 20dp, --color-primary
  - Title: 16sp, 600, --color-text-primary
  - Subtitle: 12sp, --color-text-tertiary (difficulty label)
Selected: --color-primary with 15% opacity overlay + left border 3dp --color-primary
Unselected: transparent
Divider: 0.5dp, --color-surface (slightly lighter)
```

### 4.8 Repetition Chip Selector

Used for 1 / 5 / 10 / 20 repetitions.

```
Layout: horizontal row of equal chips
Chip shape: circle, 44dp diameter
Selected: --color-primary fill, white text, 14sp 600
Unselected: --color-surface fill, --color-text-secondary text
Gap between chips: 12dp
Estimated time label: 12sp, --color-text-tertiary, right-aligned
```

### 4.9 Primary CTA Button

```
Shape: pill (radius = height/2), full-width
Height: 52dp
Background: --color-primary (active) / --color-surface (disabled)
Text: 16sp, 600, uppercase permitted, --color-text-primary
Icon: optional trailing icon (e.g. ► or ⚡)
Pressed: --color-primary-dark
Disabled: opacity 0.4
Margin: 24dp horizontal
```

### 4.10 Filter Chips (horizontal row)

Used for Vsi/Črke/Številke, Vsi znaki/Relief/Voda etc.

```
Shape: pill, radius 20dp
Height: 36dp
Padding: 0 16dp
Selected: --color-primary fill, 14sp 600, --color-text-primary
Unselected: --color-surface fill, --color-text-secondary, border 1dp --color-text-tertiary
Row: horizontally scrollable, gap 8dp
```

### 4.11 List Item Row (Morse characters, settings rows)

```
Height: 52–60dp
Background: --color-surface, radius 12dp
Padding: 16dp horizontal
Left: letter/icon in colored circle (32dp) OR category icon
Middle: title 15sp, subtitle 13sp --color-text-secondary
Right: morse pattern (dots/dashes) OR chevron OR toggle OR chip
Divider: none (cards have spacing between them instead)
Gap between rows: 8dp
```

### 4.12 Morse Dot-Dash Pattern

```
Dots: circles, 8dp diameter, --color-accent-light fill
Dashes: rectangles, 24dp × 8dp, radius 4dp, --color-accent-light fill
Gap between symbols: 6dp
Font (text representation): monospace, 14sp, --color-accent-light
```

### 4.13 Flashcard (Card Swipe Exercise)

```
Shape: rounded rectangle, radius 20dp
Background: --color-surface
Shadow: 0 8dp 24dp rgba(0,0,0,0.4)
Size: full-width minus 32dp margin, height ~50% of screen
Content:
  - Top half: --color-background, centered content (letter or image)
    Letter: 64sp, 700, --color-primary
    Level badge: pill top-left, --color-accent-light bg, 11sp uppercase
  - Bottom half: white/light surface, morse pattern OR translation text
    centered, 18sp
Swipe left: wrong (--color-wrong tint)
Swipe right: correct (--color-correct tint)
```

### 4.14 Progress Dots Row

```
Layout: horizontal row of circles
Size: 10dp diameter each
Gap: 6dp
States:
  Correct: --color-primary fill
  Wrong: --color-accent fill
  Current: --color-text-secondary fill, slightly larger (12dp)
  Upcoming: transparent, --color-text-tertiary border 1dp
Trailing: timer pill — "00:42", 13sp monospace, --color-surface bg
```

### 4.15 Exercise Action Buttons (Card Swipe)

```
Layout: 3 buttons centered horizontally, equal spacing
Button size: 56dp circle
Wrong (left): --color-surface bg, red X icon, --color-danger color
Help (center): --color-accent bg (larger, 64dp), white ? icon
  Label below: "POMOČ", 11sp, --color-accent
Correct (right): --color-surface bg, green ✓ icon, --color-primary color
```

### 4.16 Bottom Sheet (Keyboard Exercise Feedback)

```
Position: slides up from bottom, covers bottom 35% of screen
Background: --color-surface, radius 20dp top corners
Handle: 4dp × 32dp pill, --color-text-tertiary, centered top
Content (correct):
  - Icon: 48dp circle, --color-primary, shield+check
  - Title: "Pravilen odgovor!" 20sp, 700, --color-primary
  - Body: explanation text, 14sp, --color-text-secondary
  - Buttons: "Pregledaj" (outlined) + "Naslednja vaja" (filled --color-primary)
Content (wrong):
  - Same structure but --color-accent for icon and title color
  - Shows correct answer below body text
```

### 4.17 Translator Layout (Morse + Semaphore)

```
Header: section label overline + large title + subtitle
Input area: rounded rectangle, radius 12dp, --color-surface
  Label: "VHOD: BESEDILO" — 11sp uppercase, --color-text-secondary
  Content: 18sp, --color-text-primary
  Trailing: trash icon — 20dp, --color-text-tertiary
Center action: pill button, --color-accent, swap/direction icon
  Text: "ZAMENJAJ SMER", 13sp, 600, white
Output area: same structure as input
  Label: "IZHOD: MORSE" — 11sp uppercase, --color-primary
  Trailing: copy icon + "KOPIRAJ", 13sp, --color-primary
Bottom action row (Morse only): two pills
  "BLISKANJE" + flashlight icon
  "PREDVAJAJ" + speaker icon
  Both: --color-surface bg, --color-text-secondary
Tip card (optional): left-border accent strip --color-accent-light,
  info icon, body text 13sp
```

### 4.18 Settings Profile Hero

```
Background: --color-surface, radius 0 (full width), padding 24dp
Avatar: 72dp circle, --color-surface border 3dp --color-primary
Role badge: pill below avatar, --color-accent bg, 11sp uppercase
Name: 22sp, 700, --color-primary
Subtitle: 13sp, --color-text-secondary (group + city)
Skill tags: outlined pills, --color-text-tertiary border
```

### 4.19 Settings Row

```
Height: 64dp
Background: --color-surface, radius 12dp
Left: icon in 36dp circle, --color-surface-light bg, --color-primary icon
Middle: title 15sp, subtitle 12sp --color-text-secondary
Right: toggle switch OR chevron › OR chip button
Gap between rows: 8dp
```

### 4.20 Toggle Switch

```
Track: 32dp × 18dp, radius 9dp
ON: --color-primary track, white thumb
OFF: --color-text-tertiary track, white thumb
Thumb: 14dp circle, white
Animation: 200ms
```

### 4.21 Danger Zone Card

```
Background: --color-danger-surface, radius 16dp
Border: 1dp --color-danger, 30% opacity
Icon: 40dp circle, --color-danger bg, white trash icon
Title: 18sp, 700, --color-danger
Subtitle: 13sp, --color-text-secondary
Button: pill, --color-danger bg, white text, full-width
```

### 4.22 Topography Sign Card (Grid Item)

```
Shape: rounded square, radius 12dp
Background: --color-surface
Size: (screen width - 48dp) / 2
Padding: 16dp
Icon area: centered, 48dp, white icon on --color-surface-light bg
  rounded 10dp
Category label: 11sp, uppercase, --color-text-secondary
Name: 15sp, 600, --color-text-primary
Grid gap: 12dp
```

### 4.23 Learning History Card

```
Shape: rounded rectangle, radius 16dp
Background: --color-surface
Padding: 16dp
Left: icon in 40dp square, radius 10dp, --color-surface-light, --color-primary icon
Center: title 16sp 600 + date/time 12sp --color-text-tertiary
Right: difficulty badge — pill, uppercase 11sp
Progress row below: "NAPREDEK SEJE" label left, percentage right (--color-primary)
Progress bar: full width, 4dp height, radius 2dp
  Fill: --color-primary
  Track: --color-surface-light
```

### 4.24 Flashlight/Audio Transmitter

```
Background: --color-background (full dark)
Title section: overline + large title, centered
Large circle: 160dp diameter, --color-surface bg
  Icon: 48dp, --color-accent (purple)
  Outer glow ring: 200dp, --color-accent 10% opacity
Status pill: --color-surface bg, status dot + text
Mode chips: horizontal row, pill shape
  Active: --color-accent fill
  Inactive: --color-surface fill, --color-text-secondary text
Output panel: --color-surface, radius 16dp
  Label: 11sp uppercase, --color-text-secondary
  Morse sequence: dot/dash symbols, --color-accent-light
  Decoded text: large letters, --color-text-primary
```

### 4.25 News Card (Home Screen)

```
Shape: rounded rectangle, radius 16dp
Background: --color-surface with dark overlay image
Height: 180dp
Badge: pill top-left, --color-accent bg, "LATEST NEWS" 11sp
Title: 20sp, 700, white (2 lines max)
Subtitle: 13sp, rgba(white, 0.7), 2 lines
```

### 4.26 Home Screen Section Shortcut Tile

```
Shape: rounded square, radius 16dp
Background: --color-surface
Size: (screen width - 48dp) / 2
Padding: 20dp
Icon: 32dp, --color-primary
Title: 16sp, 600, --color-text-primary
Subtitle: 12sp, uppercase, --color-text-tertiary
2×2 grid layout
```

### 4.27 Onboarding Slide

```
Background: --color-primary (#5E8C61) — full screen
Bottom silhouette: mountain/tree line, black, full-width illustration strip
Overline: 11sp uppercase, rgba(white, 0.6)
Title: 40sp+, 900 Black weight, white, ALL CAPS
Body: 16sp, rgba(white, 0.85), max 3 lines
Progress: 3 horizontal pills bottom-left, active = white, inactive = rgba(white,0.4)
Next button: pill, white bg, --color-primary text, "NASLEDNJI KORAK"
Skip: text link bottom, "PRESKOČI UVOD", rgba(white, 0.5)
```

---

## 5. Layout Principles

### Spacing Scale
```
4dp  — minimum internal gap
8dp  — between list items, tight spacing
12dp — grid gaps, chip gaps
16dp — standard internal card padding
20dp — generous card padding
24dp — screen horizontal margins
32dp — section spacing
48dp — large section breaks
```

### Screen Layout Template
```
56dp  — header bar
auto  — scrollable content area
60dp  — bottom nav (+ safe area)
```

### Grid System
- Single column: full width minus 48dp (24dp each side)
- 2-column grid: (width - 48dp - 12dp gap) / 2
- No 3-column grids on mobile

### Scrolling
- Vertical scroll only on content screens
- Horizontal scroll only for filter chips row
- No nested scroll views
- Pull-to-refresh on home screen news only

---

## 6. Depth & Elevation

```
Level 0 — page background: --color-background (#0F1A0F)
Level 1 — cards, list items: --color-surface (#1A2A1A)
Level 2 — elevated cards, bottom sheet: --color-surface + shadow
Level 3 — modals, overlays: --color-surface, rgba(0,0,0,0.6) scrim
```

No drop shadows in dark mode — elevation shown through color lightness only.
In light mode (if ever implemented): subtle shadows permitted.

---

## 7. Do's and Don'ts

### Do
- Use dark backgrounds everywhere
- Keep each screen to one primary action
- Use --color-primary for all positive/active states
- Use --color-accent (purple) for nav active state and wrong-answer feedback
- Keep touch targets minimum 48×48dp
- Use overlines (11sp uppercase) to label sections
- Use pill shapes for all interactive chips and buttons
- Show progress with dots (card swipe) or progress bar (history)
- Use hero banners with subtle background images on section home screens

### Don't
- Don't use white or light backgrounds on any main screen
- Don't use red for wrong answers — use purple (--color-accent)
- Don't put labels on bottom nav items
- Don't use more than 2 colors in a single component
- Don't use gradients except in onboarding background
- Don't use font sizes below 11sp
- Don't use unrounded rectangles — minimum radius 8dp everywhere
- Don't stack more than 2 levels of cards
- Don't use the olive color (#656839) for text — surfaces only
- Don't show more than one CTA button per screen (except feedback sheets)

---

## 8. Responsive Behavior

### Mobile (primary target, 360–430dp width)
- All layouts described above apply
- Minimum touch target: 48×48dp
- Bottom nav always visible
- No floating action buttons

### Web (secondary target)
- Max content width: 480dp centered
- Bottom nav becomes side rail at >768dp
- Same component sizes — do not scale up for desktop
- Same dark theme
- Keyboard navigation support on translator screens

### Platform Differences
- Flashlight transmitter: mobile only (show disabled state on web)
- Audio transmitter: all platforms
- PDF export button: web only
- File download: web only, hidden on mobile

---

## 9. Agent Prompt Guide

### Quick Color Reference
```dart
// Primary colors
const colorPrimary = Color(0xFF5E8C61);
const colorAccent = Color(0xFF622599);
const colorOlive = Color(0xFF656839);

// Backgrounds
const colorBackground = Color(0xFF0F1A0F);
const colorBackgroundAlt = Color(0xFF192219);
const colorSurface = Color(0xFF1A2A1A);

// Text
const colorTextPrimary = Color(0xFFFFFFFF);
const colorTextSecondary = Color(0xFF8DB88F);
const colorTextTertiary = Color(0xFF5A7A5C);

// Semantic
const colorDanger = Color(0xFFC0392B);
const colorDangerSurface = Color(0xFF3D1010);
```

### Ready-to-Use Agent Prompts

**Building a new screen:**
```
Build the [ScreenName] screen following DESIGN.md.
Background: --color-background.
Use --color-surface for all cards.
Header bar with avatar + app name left, gear icon right.
Bottom nav with 4 items, active item [X] in --color-accent.
Follow spacing scale: 24dp horizontal margins, 8dp between list items.
```

**Building a card component:**
```
Build a [ComponentName] card following DESIGN.md section 4.X.
Background: --color-surface, radius 16dp.
Text hierarchy: title 16sp 600 --color-text-primary,
subtitle 13sp --color-text-secondary.
Touch target minimum 48dp height.
```

**Building an exercise screen:**
```
Build the [exercise type] exercise screen following DESIGN.md.
No bottom nav (full-screen exercise mode).
Progress dots row following section 4.14.
Action buttons following section 4.15.
Feedback bottom sheet following section 4.16.
```

**Dark mode check:**
```
Verify dark mode compliance:
- All backgrounds use --color-background or --color-surface
- No hardcoded white backgrounds
- All text uses --color-text-primary or --color-text-secondary
- Touch targets minimum 48×48dp
```

---

*End of DESIGN.md*
*Source: 16 screens generated by Stitch AI, April 2026*
*Do not modify without updating the Stitch source screens*
