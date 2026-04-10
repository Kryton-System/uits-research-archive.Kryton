<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('submissions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('title', 500);
            $table->string('archive_type');
            $table->string('author_role');
            $table->string('department');
            $table->string('batch', 100)->nullable();
            $table->string('academic_session', 100)->nullable();
            $table->text('research_domains')->nullable();
            $table->text('authors');
            $table->text('external_links')->nullable();
            $table->text('pdf_url')->nullable();
            $table->text('drive_links')->nullable();
            $table->text('abstract')->nullable();
            $table->text('author_comments')->nullable();
            $table->string('status')->default('Pending');
            $table->text('admin_remarks')->nullable();
            $table->timestamp('reviewed_at')->nullable();
            $table->string('reviewed_by')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('submissions');
    }
};
