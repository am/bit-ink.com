import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";
import tailwindcss from "@tailwindcss/vite";

// https://astro.build/config
export default defineConfig({
	site: "https://bit-ink.com",
	// Keep HTML-aware whitespace handling (Astro 7 defaults to 'jsx')
	compressHTML: true,
	// Fetch a page when its link is hovered, so moving between posts feels instant.
	prefetch: { prefetchAll: true, defaultStrategy: "hover" },
	integrations: [mdx(), sitemap()],
	vite: {
		plugins: [tailwindcss()],
	},
});
