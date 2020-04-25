<?php
namespace app\admin\controller;
use app\common\controller\AdminBase;
use think\Log;
use think\Request;
use think\Db;
//题目管理

class Draw extends AdminBase {
    protected function _initialize() {
        parent::_initialize();
    }

    public function index()
 {
        $param = $this->request->param();
        $where = [];
        if ( isset( $param['user_name'] ) ) {
            $where['a.user_name'] = ['like', '%' . $param['user_name'] . '%'];
        }
        if ( isset( $param['activity_id'] ) ) {
            $where['a.activity_id'] = $param['activity_id'];
        }
        $activity = Db::name( 'activity' )->where( 'activity_status', 0 )->select();
        $this->assign( 'activity', $activity );
        return $this->fetch( 'index', ['list' => model( 'draw' )
        ->alias( 'a' )
        ->join( 'activity w', 'a.activity_id = w.id' )
        ->where( $where )
        ->field( 'a.*, w.*, a.id answer_id , w.id activity_id' )
        ->paginate( config( 'page_number' ) )] );
    }


    public function particular()
 {
        $id = input( 'id' );
        $list = Db::name( 'draw' )->where( 'id', $id )->select();
        $activity = Db::name( 'activity' )->where( 'id', $list[0]['activity_id'] )->find();
        $this->assign( 'list', $list );
        $this->assign( 'activity', $activity );
        return $this->fetch( 'particular' );
    }
}
