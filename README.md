# bit-ink.com

Personal site at [bit-ink.com](https://bit-ink.com), built with [Astro](https://astro.build) and served by a Cloudflare Worker (`bit-ink`).

## Develop

```sh
npm install
npm run dev        # local dev server
npm run build      # build to ./dist
npm run preview:cf # build and run locally in the Workers runtime
```

## Deploy

Pushes to `master` deploy automatically. To deploy by hand, run `npm run deploy`.
