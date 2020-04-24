<?php

namespace app\admin\controller;

use app\common\controller\AdminBase;
use think\Db;
class Answer extends AdminBase
{
    protected function _initialize()
    {
        parent::_initialize();
    }

    public function index(){
        $ins = Db::name('answer_set')->where('id',1)->find();
        $this->assign('all',$ins);
        return $this->fetch();
    }

    public function ins(){
        $id =1;
        $data['answer_number'] = input('answer_number');
        $ins = Db::name('answer_set')->where('id',$id)->update($data);
        if ($ins){
            $this->success( '操作成功', 'admin/Answer/index' );
        }else{
            $this->error( '操作失败' );
        }
    }


}