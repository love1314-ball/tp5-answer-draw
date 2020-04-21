<?php

namespace app\index\controller;

use app\common\controller\IndexBase;
//首页
class Index extends IndexBase
{
    public function index()
    {
        $username = session('user_name');
        return $this->fetch('index'); 
    }
}
