# Desktop security notes

Axiom AI for Windows intentionally loads only the live Axiom web application and does not expose Tauri native commands to remote content.

Do not add filesystem, shell, process, updater, or other native permissions to the remote `https://axiomai.technology` origin unless the feature truly requires them and the scope has been reviewed carefully.

Do not put Cloudflare Worker secrets, AI provider keys, auth secrets, admin codes, or private backend configuration in this repository.
