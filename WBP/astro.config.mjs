import db from "@astrojs/db"
import netlify from "@astrojs/netlify"
import tailwindcss from "@tailwindcss/vite"
import { defineConfig } from "astro/config"

// https://astro.build/config
export default defineConfig({
	vite: {
		plugins: [tailwindcss()],
	},

	integrations: [db()],
	output: "server",
	adapter: netlify(),
})
