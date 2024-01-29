<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMembersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('members', function (Blueprint $table) {
            $table->id();
            $table->string('bpid', 20)->unique();
            $table->string('name', 100);
            $table->string('password', 256);
            $table->string('name_bn', 100)->nullable();
            $table->string('designation', 100)->nullable();
            $table->string('designation_bn', 200)->nullable();
            $table->string('post', 20)->nullable();
            $table->string('posting_area', 255)->nullable();
            $table->string('mobile', 15);
            $table->date('dob')->nullable();
            $table->date('joining_date')->nullable();
            $table->timestamps();
        });


    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('members');
    }
}
