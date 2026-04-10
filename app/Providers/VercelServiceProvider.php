<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class VercelServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     */
    public function register(): void
    {
        // Use /tmp for compiled views on Vercel
        if (isset($_ENV['VERCEL'])) {
            config(['view.compiled' => '/tmp/views']);
        }
    }

    /**
     * Bootstrap services.
     */
    public function boot(): void
    {
        // Ensure the /tmp/views folder exists
        if (isset($_ENV['VERCEL']) && !is_dir('/tmp/views')) {
            mkdir('/tmp/views', 0777, true);
        }
    }
}
