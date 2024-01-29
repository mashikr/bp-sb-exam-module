<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Result extends Model
{
    use HasFactory;

    public function exam()
    {
        return $this->belongsTo(Exam::class, 'exam_id', 'exam_id');
    }


    public function examConfiguration()
    {
        return $this->belongsTo(ExamConfiguration::class, 'exam_config_id', 'id');
    }


    public function member()
    {
        return $this->belongsTo(Member::class, 'bpid', 'bpid');
    }
}
