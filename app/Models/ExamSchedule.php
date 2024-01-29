<?php

namespace App\Models;

use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExamSchedule extends Model implements Authenticatable
{
    use HasFactory;
protected $table="exam_schedule";
    protected $primaryKey = 'id';
protected $fillable=[

    'status',

];
    public function member()
    {
        return $this->belongsTo(Member::class, 'bpid', 'bpid');
    }

    public function examConfiguration()
    {
        return $this->belongsTo(ExamConfiguration::class, 'exam_config_id', 'id');
    }

    public function getAuthIdentifierName()
    {
        return 'id'; // Assuming 'id' is the primary key name
    }

    public function getAuthIdentifier()
    {
        return $this->getKey();
    }

    public function getAuthPassword()
    {
        return $this->password;
    }

    public function getRememberToken()
    {

    }

    public function setRememberToken($value)
    {

    }

    public function getRememberTokenName()
    {

    }
}
