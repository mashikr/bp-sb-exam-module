<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuestionSet extends Model
{
    use HasFactory;
    protected $table="question_sets";
    protected $fillable=[
        'question_set_name',
    ];

    public function questions(){
        return $this->hasMany(ComputerTestQuestion::class,'question_set_id','question_set_id');
    }

    public function examConfigurations()
    {
        return $this->hasMany(ExamConfiguration::class, 'question_set_id', 'question_set_id');
    }
}
