const defaultTheme = require("tailwindcss/defaultTheme");

/** @type {import('tailwindcss').Config} */
module.exports = {
	content: ["./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}"],
	theme: {
		extend: {
			colors: {
				white: "#eaeae3",
				black: "#282827",
				'ink': "#3b2ee6", 
			},
			backgroundImage: {
				"hero-background": "url('/hero-background.jpg')",
			},
			fontFamily: {
				display: ["Abril Fatface", ...defaultTheme.fontFamily.serif],
				sans: ["Karla", ...defaultTheme.fontFamily.sans],
			},
		},
	},
	plugins: [
		require("tailwindcss-opentype"),
		require("@tailwindcss/typography"),
	],
};
