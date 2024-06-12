<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BasicComputerTestQuestion extends Model
{
    use HasFactory;
    protected $table="basic_computer_test_questions";
    protected $fillable=[
        'question_content',
        'question_type',
        'option1',
        'option2',
        'option3',
        'option4',
        'correct_answer',


    ];
}
