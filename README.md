# nvim-flutter-hot

Neovim plugin to trigger Flutter **Hot Reload** and **Hot Restart** directly from the editor, without external scripts.

---

## ✨ Features

- Native Lua implementation
- Defines `:FlutterHot reload` and `:FlutterHot restart` commands
- Reads Flutter PID files and sends signals (`USR1` / `USR2`)

---

## ⚠️ Requirements

- **Unix-like OS** (Linux, macOS)
- **Neovim 0.9+** (recommended)
- Flutter launched with:

```bash
flutter run --pid-file /tmp/flutter.pid
```

## 📦 Installation (lazy.nvim example)
```lua
{
  "urazmaxambetovserik/flutter-hot.nvim",
  config = function()
    require("flutter_hot").setup()
  end,
}
```

## 🛠️ Usage

- `:FlutterHot reload` — triggers hot reload
- `:FlutterHot restart` — triggers hot restart

## Optional Keymaps
Define your own:
```lua
vim.keymap.set("n", "<leader>r", ":FlutterHot reload<CR>")
vim.keymap.set("n", "<leader>R", ":FlutterHot restart<CR>")
```
