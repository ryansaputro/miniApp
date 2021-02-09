<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Posting extends Model
{
    protected $table = 'posting';
    protected $primaryKey = 'id';
    public $incrementing = true;
    public $timestamps = true;
    protected $fillable = ['id', 'post_content', 'url_post', 'created_by', 'datetime', 'image', 'created_at', 'updated_at'];
}
