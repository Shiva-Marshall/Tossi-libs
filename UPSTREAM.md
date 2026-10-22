# Upstream sources

Tossi-libs is built from the following Aether SD-Core (omec-project) libraries, imported unmodified and then converted into one Go module.

| Directory | Upstream repo | Tag | Commit |
|---|---|---|---|
| openapi | https://github.com/omec-project/openapi | v2.2.5 | c333439f4143a06d690bb42c949b7a48e1fa5361 |
| nas | https://github.com/omec-project/nas | v2.2.5 | f76f4a811926b3ffb6f99711962d2f07ebc9fe4f |
| ngap | https://github.com/omec-project/ngap | v2.1.7 | bdb82ab6b42d6388e0e6b9151856fb1ce78bd9ed |
| util | https://github.com/omec-project/util | v1.9.2 | c7cf0b10158816ff332485034d84f4fa91b1728f |

All are licensed under Apache-2.0. Each directory keeps its original `LICENSES/` folder and `NOTICE.txt`.

## Why nas v2.2.5 and ngap v2.1.7 (not the newest tags)

nas v2.2.7 and ngap v2.1.10 removed their OpenAPI conversion helpers (omec-project/nas#234, omec-project/ngap#138). The latest *released* AMF (v3.3.2) and SMF (v4.3.3) still call those helpers, and pin nas v2.2.5 and ngap v2.1.7. Only the unreleased `main` branches of AMF and SMF have moved to the newer libraries.

Tossi-libs therefore carries the versions that match the latest released NFs. Move to nas v2.2.7+ and ngap v2.1.10+ together with the first AMF/SMF releases that require them.

## Verified NFs

Built, vetted and unit-tested against this module (2026-10-22): AMF v3.3.2, SMF v4.3.3, NRF v3.1.3, AUSF v3.1.2, UDM v3.1.2, UDR v3.1.2, PCF v3.2.2, NSSF v3.1.2.
