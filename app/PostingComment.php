<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PostingComment extends Model
{
    protected $table = 'posting_comment';
    protected $primaryKey = 'id';
    public $incrementing = true;
    public $timestamps = true;
    protected $fillable = ['id', 'id_post', 'id_user', 'comment', 'datetime', 'status', 'created_at', 'updated_at'];
}
