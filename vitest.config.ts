import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vitest/config';

export default defineConfig({
	plugins: [sveltekit()],
	test: {
		environment: 'jsdom',
		globals: true,
		include: ['tests/**/*.{test,spec}.{ts,js}', 'src/**/*.{test,spec}.{ts,js,svelte}'],
		setupFiles: ['./vitest-setup-client.ts']
	},
	resolve: process.env.VITEST
		? {
				conditions: ['browser']
			}
		: undefined
});
