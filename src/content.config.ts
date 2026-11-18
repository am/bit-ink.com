import { defineCollection } from "astro:content";
import { glob } from "astro/loaders";
import { z } from "astro/zod";

const blog = defineCollection({
	loader: glob({ pattern: "**/[^_]*.{md,mdx}", base: "./src/content/blog" }),
	// Type-check frontmatter using a schema
	schema: ({ image }) =>
		z.object({
			title: z.string(),
			description: z.string(),
			// Transform string to Date object
			pubDate: z.coerce.date(),
			updatedDate: z.coerce.date().optional(),
			// Path relative to the post, e.g. "../../assets/photos/name.jpg".
			// Astro resizes it, converts it to WebP and strips camera metadata.
			heroImage: image().optional(),
			// Drafts only appear in local dev and PR previews, never on bit-ink.com
			draft: z.boolean().optional(),
		}),
});

export const collections = { blog };
