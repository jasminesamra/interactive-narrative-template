import { describe, test, expect } from 'vitest';
import '@testing-library/jest-dom/vitest';
import { render, screen } from '@testing-library/svelte';
import Welcome from './Welcome.svelte';

describe('Welcome', () => {
	test('should render h1', () => {
		render(Welcome);
		expect(screen.getByRole('heading', { level: 1 })).toBeInTheDocument();
	});
});
