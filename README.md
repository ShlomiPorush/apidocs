# apidocs

Beautiful, interactive API documentation server powered by [Stoplight Elements](https://github.com/stoplightio/elements).

Based on [skriptfabrik/elements-cli](https://github.com/skriptfabrik/elements-cli) by Daniel Schröder (MIT), extended with:

- **Dark mode** - toggle button with `prefers-color-scheme` detection and persistence
- **Mobile support** - automatically switches to the stacked layout on narrow screens
- **Base path support** - serve the docs under a sub path (e.g. behind a reverse proxy at `/docs`)
- **Custom logo and favicon**
- **Docker support** - ready-to-use `Dockerfile` and `docker-compose.yml`

## Installation

```bash
npm install
```

## Usage

```bash
node elements-cli.mjs --help
```

```text
Elements CLI

Usage:
  elements command [options] [arguments]

Options:
  -h, --help     Display this help message
  -v, --version  Print version number

Commands:
  export   Export rendered API docs
  preview  Preview rendered API docs
```

### Preview

Serve rendered API docs with live reload:

```bash
node elements-cli.mjs preview [options] <openapi_json>
```

| Option | Description | Default |
| --- | --- | --- |
| `--base-path=BASE_PATH` | Serve the docs under the given base path | `/` |
| `--credentials-policy=POLICY` | Credentials policy for "Try It": `omit`, `include`, `same-origin` | `omit` |
| `-c`, `--with-cors-proxy` | Enable CORS proxy capabilities | |
| `-f`, `--filter-internal` | Filter out content marked with `x-internal` | |
| `--hostname=HOSTNAME` | Server hostname | `localhost` |
| `--layout=LAYOUT` | Layout for Elements: `sidebar`, `stacked` (sidebar auto-switches to stacked on mobile) | `sidebar` |
| `--logo=LOGO` | URL of a small square logo shown next to the title | |
| `-n`, `--no-try-it` | Hide the "Try It" panel | |
| `-p`, `--poll` | Use polling instead of file system events | |
| `--port=PORT` | Server port | `8000` |
| `--router=ROUTER` | Navigation mode: `history`, `hash`, `memory`, `static` | `history` |
| `--title=TITLE` | API docs title | `My API Docs` |
| `--variable=VARIABLE` | Variable to be replaced in the OpenAPI document (`name=value`) | |
| `-w`, `--watch` | Watch for changes and reload (local files only) | |
| `--working-dir=PWD` | Use the given directory as working directory | |

Examples:

```bash
# Preview local API docs
node elements-cli.mjs preview openapi.json

# Preview remote docs with a title
node elements-cli.mjs preview --title="Swagger Petstore" https://petstore.swagger.io/v2/swagger.json

# Preview with CORS proxy and watch/reload, served under /docs
node elements-cli.mjs preview -cw --base-path=docs openapi.json
```

Most options can also be provided through environment variables (`ELEMENTS_BASE_PATH`, `ELEMENTS_TITLE`, `ELEMENTS_LOGO`, `ELEMENTS_PORT`, and so on - see `elements-cli.mjs`).

### Export

Export the rendered docs as a static HTML file:

```bash
node elements-cli.mjs export --title="Swagger Petstore" https://petstore.swagger.io/v2/swagger.json > index.html
```

## Docker

Build and run with Docker Compose. Place your OpenAPI file in `./data` and adjust the `command` in `docker-compose.yml`:

```bash
docker compose up --build
```

Then open http://localhost:8000/.

Or with plain Docker:

```bash
docker build -t apidocs .
docker run --rm -p 8000:8000 -v "$PWD/data:/data:ro" apidocs preview -w openapi.json
```

Behind a reverse proxy, pass `--base-path` so assets and routing resolve correctly, e.g. `preview --base-path=docs -w openapi.json` served at `https://example.com/docs`.

## License

[MIT](LICENSE). Original work copyright skriptfabrik GmbH / Daniel Schröder ([elements-cli](https://github.com/skriptfabrik/elements-cli), distributed under the MIT license as declared in its package manifest); modifications copyright Shlomi Porush.
