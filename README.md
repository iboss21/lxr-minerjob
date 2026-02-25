# 🐺 LXR Miner Job — The Land of Wolves

```
██╗     ██╗  ██╗██████╗       ███╗   ███╗██╗███╗   ██╗███████╗██████╗
██║     ╚██╗██╔╝██╔══██╗      ████╗ ████║██║████╗  ██║██╔════╝██╔══██╗
██║      ╚███╔╝ ██████╔╝█████╗██╔████╔██║██║██╔██╗ ██║█████╗  ██████╔╝
██║      ██╔██╗ ██╔══██╗╚════╝██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██╔══██╗
███████╗██╔╝ ██╗██║  ██║      ██║ ╚═╝ ██║██║██║ ╚████║███████╗██║  ██║
╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
```

**wolves.land — The Land of Wolves** | Georgian RP 🇬🇪 | Serious Hardcore Roleplay

> ისტორია ცოცხლდება აქ! *(History Lives Here!)*

---

## Overview

`lxr-minerjob` is a multi-stage mining job resource for **RedM**, fully rebranded and refactored for the **Land of Wolves / LXR** codebase style.

Players with the miner job report to a work site, mine four ore spots with pickaxe animations, load a spawned cart, and deliver the ore within a countdown timer to earn money rewards.

---

## Framework Support

| Framework | Status |
|---|---|
| **LXR Core** | ✅ Primary |
| **RSG Core** | ✅ Primary |
| **VORP Core** | ✅ Supported |
| **RedEM:RP** | ✅ Legacy / Fallback |
| **Standalone** | ✅ Fallback (no job check) |

Framework is **auto-detected** by default. Override via `Config.Framework` in `config.lua`.

---

## Requirements

- [ProgressBar](https://github.com/PokeSerGG/RedM-ProgressBar) — `progressBars` resource for mining/loading animations
- One of the supported frameworks listed above
- **ox_lib** (optional, recommended for LXR/RSG notifications)

---

## Installation

1. Copy the `lxr-minerjob` folder to your server's resources directory.
2. **The folder must be named exactly `lxr-minerjob`** — a runtime guard will error if it is renamed.
3. Add `ensure lxr-minerjob` to your `server.cfg`.
4. Set `Config.JobName` in `config.lua` to match your job name in the database.
5. Configure `Config.Lang` (`en`, `es`, `fr`, `ge`).
6. Restart or start your server.

---

## Configuration

All settings live in `config.lua`:

| Setting | Default | Description |
|---|---|---|
| `Config.Framework` | `'auto'` | Framework auto-detection or manual override |
| `Config.Lang` | `'en'` | Locale (`en`, `es`, `fr`, `ge`) |
| `Config.JobName` | `'minero'` | Job name in your framework DB |
| `Config.Vehiculo` | `'CART06'` | Vehicle model spawned for delivery |
| `Config.Money.min/max` | `250 / 500` | Cash reward range |
| `Config.XP.min/max` | `15 / 35` | XP reward range (RedEM:RP only) |
| `Config.Timers.deliveryTimer` | `150` | Seconds to complete delivery |
| `Config.Debug` | `false` | Enable debug logging |

---

## Credits

- **Script Author:** iBoss21 / The Lux Empire for The Land of Wolves
- **Original Author:** PokeSerGG (`poke_minerjob`)
- **Refactored by:** iBoss21 — wolves.land LXR style

---

## Links

| | |
|---|---|
| 🌐 Website | https://www.wolves.land |
| 💬 Discord | https://discord.gg/CrKcWdfd3A |
| 🐙 GitHub | https://github.com/iBoss21 |
| 🛒 Store | https://theluxempire.tebex.io |

---

*© 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved*
