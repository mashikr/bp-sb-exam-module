<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Member extends Model
{
    protected $primaryKey = 'id';

    /**
     * Get the exam schedules associated with the member.
     */
    public function examSchedules()
    {
        return $this->hasMany(ExamSchedule::class, 'bpid', 'bpid');
    }

    public function results()
    {
        return $this->hasMany(Result::class, 'bpid', 'bpid');
    }
}
