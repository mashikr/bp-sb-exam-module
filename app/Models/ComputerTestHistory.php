<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ComputerTestHistory extends Model
{
    use HasFactory;
    protected $table ="computer_test_history";
    protected $fillable = [
        'exam_schedule_id',
        'question_id',
        'given_answer',
        'marks',
        'created_at',
        'updated_at',
    ];


    public function examSchedule()
    {
        return $this->belongsTo(ExamSchedule::class, 'exam_schedule_id');
    }


    public function computerTestQuestion()
    {
        return $this->belongsTo(ComputerTestQuestion::class, 'question_id');
    }
}
