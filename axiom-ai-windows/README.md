# Axiom AI for Windows

This is the Windows desktop wrapper for **Axiom AI**.

It uses Tauri 2 and loads the live Axiom website:

`https://axiomai.technology`

That means the Windows app uses the same Axiom frontend, accounts, chats, models, Atlas/Void modes, Groups, and backend as the website. Normal website UI updates appear in the desktop app without rebuilding the installer.

## What this app does

- Opens Axiom in a dedicated native Windows window.
- Removes browser tabs/address bars from the experience.
- Uses the live `axiomai.technology` origin, so existing web auth/storage behavior can continue to work normally.
- Keeps Axiom's Cloudflare backend online; no AI keys or backend secrets are bundled into the app.
- Produces a Windows NSIS installer (`.exe`).

## Build it on Windows

### Requirements

Install these once:

1. Node.js LTS
2. Rust via rustup
3. Microsoft C++ Build Tools / Visual Studio Build Tools with **Desktop development with C++**
4. Microsoft Edge WebView2 Runtime (already included on most Windows 10/11 systems)

Then double-click:

`build-windows.bat`

The finished installer is copied to:

`dist/AxiomAI-Setup.exe`

A portable executable is also copied to `dist/AxiomAI-Portable.exe` when available.

## Build without setting up your PC

This repository includes:

`.github/workflows/windows.yml`

Push the project to GitHub and run **Build Axiom AI for Windows** from the Actions tab. GitHub's Windows runner builds the installer and provides it as a downloadable artifact.

You can also create a tag such as:

`desktop-v9.5.0`

which triggers the same build automatically.

## Development

```powershell
npm install
npm run dev
```

The dev app also loads the live Axiom website.

## Production build

```powershell
npm install
npm run build
```

## Important security design

The remote website is intentionally **not granted Tauri native API capabilities**. Axiom currently needs only the web experience inside a desktop shell, so the live site does not receive unnecessary filesystem, shell, process, or operating-system access.

The Cloudflare Worker and secrets remain server-side and must never be copied into this desktop project.

## App icon

The included icon is a temporary Axiom-style desktop icon so the project builds immediately. Replace the files in `src-tauri/icons/` with the official Axiom icon later if desired, keeping the same filenames.
