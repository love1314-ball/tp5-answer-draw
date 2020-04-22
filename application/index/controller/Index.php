<?php

namespace app\index\controller;

use app\common\controller\IndexBase;
use think\Db;
//首页
class Index extends IndexBase
{
    public function index()
    {
        $username = session('user_name');
        $activity = Db::name('activity')->select();
        $this->assign('activity',$activity);
        return $this->fetch('index'); 
    }

    //点进活动内然后进行答题
    public function answer()
    {
        $id = input('id');
        dump($id);
    }





}
