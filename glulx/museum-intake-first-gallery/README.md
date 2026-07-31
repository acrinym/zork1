# Release 1233 — Museum Intake and First Gallery

Release 1233 turns the existing Living Room displays into a usable intake path without creating a second inventory or copying canonical objects.

## Player-facing start

- `EXHIBIT OBJECT` selects the correct existing display.
- Valuable treasure routes through the trophy case so canonical scoring remains in control.
- Maps and paintings route to the deep frame.
- Weapons route to the weapon wall.
- records and documents route to the record shelf.
- tools, ritual materials, and other accepted relics route to the relic stand.
- `CATALOG MUSEUM` and `REVIEW MUSEUM` invoke the existing first-gallery projection.

## Physical custody

The real object is the museum record. Intake delegates to canonical `PUT` or `PUT-ON`, so existing capacity, scoring, active-field warnings, exhibit grouping, theft, retrieval, save, and restore behavior remain authoritative.

There is no collection registry, duplicate exhibit, remote storage, checklist HUD, or museum database.

## Current boundary

This opening museum train deliberately uses `EXHIBIT`, not the existing `DONATE` synonym owned by `GIVE`. Permanent donation semantics, refusal policy, and dedicated intake prose will be qualified only after this physical routing passes hosted gameplay.

The only new response is the bounded outside-gallery refusal: `There is no museum intake here.` It must receive parser-refusal corpus qualification before Release 1233 can merge.
