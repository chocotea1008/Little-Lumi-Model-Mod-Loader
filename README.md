# Little LUMI Model Mod Loader releases

This repository is the signed-update distribution endpoint for Lumi ModLoader.

The in-game loader fetches [`release.json`](release.json) at startup. A manifest is accepted only when all three values are present:

- semantic `version` newer than the installed loader;
- HTTPS `url` for `LumiModLoader.jar`;
- lowercase or uppercase SHA-256 matching that artifact.

The loader downloads only to its next-launch staging area. A failed network request, invalid manifest, invalid SHA-256, or failed download keeps the installed loader running.

## Publishing a release

1. Build the production JAR from the Workshop package.
2. Calculate its SHA-256.
3. Create a GitHub release tagged `vX.Y.Z` and upload the artifact as `LumiModLoader.jar`.
4. Update `release.json` to that exact tag URL, version, and SHA-256, then commit and push it to `main`.

Do not publish temporary runtime folders, test builds, recovery files, logs, Steam Workshop packages, or user settings in this repository.
