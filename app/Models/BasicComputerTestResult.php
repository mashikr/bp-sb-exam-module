<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BasicComputerTestResult extends Model
{
    use HasFactory;

    // Define the table associated with the model
    protected $table = 'basic_computer_test_results';

    // Define the primary key
    protected $primaryKey = 'id';

    // Disable timestamps if you don't use them
    public $timestamps = true;

    // Define the fillable fields
    protected $fillable = [
        'exam_schedule_id',
        'mcq_score',
        'true_false_score',
        'typing_test_score',
        'total_score',
        'result_data',
    ];

    // Cast the result_data field as an array
    protected $casts = [
        'result_data' => 'array',
    ];

    // Define the relationship with ExamSchedule
    public function examSchedule()
    {
        return $this->belongsTo(ExamSchedule::class, 'exam_schedule_id');
    }
}
