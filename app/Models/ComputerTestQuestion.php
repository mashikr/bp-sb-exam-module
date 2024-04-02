<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComputerTestQuestion extends Model
{
    use HasFactory;
    protected $table = 'computer_test_questions';

    protected $fillable = [
        'question_content',
        'question_type',
        'option1',
        'option2',
        'option3',
        'option4',
        'correct_answer',
        'marks',
        'question_set_id'
    ];

    public function computerTestHistory(){
        return $this->hasMany(ComputerTestHistory::class,'question_id');
    }
}
