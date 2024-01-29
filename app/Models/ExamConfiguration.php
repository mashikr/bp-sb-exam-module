<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExamConfiguration extends Model
{
    use HasFactory;
    protected $table="exam_configuration";
    protected $primaryKey = 'id';

    public function exam()
    {
        return $this->belongsTo(Exam::class, 'exam_id', 'exam_id');
    }
}
