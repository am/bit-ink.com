import { getCollection } from 'astro:content';

// Drafts are built everywhere except production (the `master` branch on
// Cloudflare Workers Builds), so they show up in `astro dev` and PR previews.
const branch = process.env.WORKERS_CI_BRANCH;
export const showDrafts = import.meta.env.DEV || (branch !== undefined && branch !== 'master');

export async function getPosts() {
	return getCollection('blog', ({ data }) => showDrafts || !data.draft);
}
