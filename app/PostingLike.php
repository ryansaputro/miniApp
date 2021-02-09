<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PostingLike extends Model
{
    protected $table = 'posting_like';
    protected $primaryKey = 'id';
    public $incrementing = true;
    public $timestamps = true;
    protected $fillable = ['id', 'id_post', 'id_user', 'datetime', 'status', 'created_at', 'updated_at'];
}
