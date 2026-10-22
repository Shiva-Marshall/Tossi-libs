# Tossi-libs

Shared Go libraries for TOSSI Core, in one Go module:

| Package | What it is |
|---|---|
| `openapi` | 3GPP SBI models and clients (Namf, Nsmf, Nudm, Nudr, Npcf, Nnrf, etc.) |
| `nas` | NAS message encoding/decoding and NAS security |
| `ngap` | NGAP encoding/decoding (APER) |
| `util` | Shared helpers: logger, MongoDB access, HTTP/2, Milenage, UE auth, FSM, ID generator |

Derived from the Aether SD-Core (omec-project) libraries. See [UPSTREAM.md](UPSTREAM.md) for exact versions.

## Use from a network function

```go
import (
	"github.com/Shiva-Marshall/Tossi-libs/openapi/models"
	"github.com/Shiva-Marshall/Tossi-libs/nas/nasMessage"
	"github.com/Shiva-Marshall/Tossi-libs/ngap/ngapType"
	"github.com/Shiva-Marshall/Tossi-libs/util/logger"
)
```

```bash
go get github.com/Shiva-Marshall/Tossi-libs@v1.0.0
```

If the repo is private, set `GOPRIVATE=github.com/Shiva-Marshall/*` and Git credentials first.

### Switch an existing SD-Core NF to Tossi-libs

```bash
scripts/repoint-nf.sh ../crl-amf                      # use the latest Tossi-libs tag
scripts/repoint-nf.sh ../crl-amf v1.0.0               # use a specific tag
scripts/repoint-nf.sh ../crl-amf --local .            # use this local checkout (before tagging)
```

The script rewrites imports, removes the omec-project library requirements, wires Tossi-libs into `go.mod` and runs `go mod tidy` (Go 1.26 or later).

## Build and test

```bash
go build ./... && go vet ./... && go test ./...
```

Verified with: AMF v3.3.2, SMF v4.3.3, NRF v3.1.3, AUSF v3.1.2, UDM v3.1.2, UDR v3.1.2, PCF v3.2.2 and NSSF v3.1.2. All build, vet and pass unit tests against this module.

## License

Apache-2.0. Each library keeps its original `LICENSES/` and `NOTICE.txt`; copyright notices from the original authors (ONF, Intel, Canonical, free5GC and others) are preserved.
