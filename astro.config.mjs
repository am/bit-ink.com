import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import m2dx from "astro-m2dx";
import sitemap from "@astrojs/sitemap";

// https://astro.build/config
import tailwind from "@astrojs/tailwind";

/** @type {import('astro-m2dx').Options} */
const m2dxOptions = {
	scanAbstract: true,
	frontmatter: true,
};

// https://astro.build/config
export default defineConfig({
	site: "https://bit-ink.com",
	integrations: [
		mdx({
			remarkPlugins: [[m2dx, m2dxOptions]],
			extendDefaultPlugins: true,
		}),
		sitemap(),
		tailwind(),
	],
});
