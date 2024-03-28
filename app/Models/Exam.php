<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Exam extends Model
{

    protected $table="exams";
    protected $primaryKey = 'exam_id';

    public function course()
    {
        return $this->belongsTo(Course::class, 'course_id', 'course_id');
    }


}
