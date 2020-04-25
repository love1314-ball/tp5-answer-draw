<?php

namespace app\admin\controller;

use app\common\controller\AdminBase;
use think\Log;
use think\Db;
use think\Request;

class Activity extends AdminBase {
    protected function _initialize() {
        parent::_initialize();
    }

    public function index() {

        $param = $this->request->param();
        ///接收input框中的值
        $where = [];
        if ( isset( $param['activity_name'] ) ) {
            $where['activity_name'] = ['like', '%' . $param['activity_name'] . '%'];
        }
        if ( isset( $param['begin_time'] ) ) {
            $begin_time = strtotime( $param['begin_time'] );
            $where['begin_time'] =  ['like', '%' . $begin_time . '%'];
        }
        if ( isset( $param['finish_time'] ) ) {
            $finish_time = strtotime( $param['finish_time'] );
            $where['finish_time'] =  ['like', '%' . $finish_time . '%'];
        }
        return $this->fetch( 'index', ['list' => model( 'activity' )->order( 'id desc' )->where( $where )->paginate( config( 'page_number' ) )] );
    }

    public function edit() {
        $id = input( 'id' );
        $data = Db::name( 'activity' )->where( 'id', $id )->find();
        $this->assign( 'id', $id );
        $this->assign( 'data', $data );
        return $this->fetch( 'save' );
    }

    public function del() {
        if ( $this->request->isPost() ) {
            if ( $this->delete( 'activity', $this->request->param() ) === true ) {
                $this->success( '删除成功' );
            } else {
                $this->error( $this->errorMsg );
            }
        }
    }

    public function rule_del()
    {
           $reward_hierarchy = input( 'id' );
           $del = Db::name( 'activity_rule' )->where( 'reward_hierarchy', $reward_hierarchy )->select();
           Log::record( $del );
           foreach ( $del as $key => $value ) {
               $del = Db::name( 'activity_rule' )->delete( $value['id'] );
           }
           if ( $del ) {
               $this->success( '删除成功', 'admin/activity/activity_rule' );
           } else {
               $this->error( '删除失败' );
           }
       }
    public function ins() {
        $activity['activity_name'] = input( 'activity_name' );
        $activity['activity_introduce'] = input( 'activity_introduce' );
        $activity['begin_time'] =  strtotime( input( 'begin_time' ) );
        $activity['finish_time'] = strtotime( input( 'finish_time' ) );
        $activity_picture = '';
        if ( $_FILES['activity_picture']['name'] == '' ) {
            $activity_picture = input( 'former' );
        } else {
            $file = request()->file( 'activity_picture' );
            $info = $file->move( ROOT_PATH . '/public/static/activityimg/' );
            if ( $info ) {
                $Nmae = $info->getSaveName();
                $site = str_replace( '\\', '/', $Nmae );
                $activity_picture = '/static/activityimg/' . $site;
            } else {
                echo $file->getError();
            }
        }
        $activity['activity_picture'] = $activity_picture;
        $id = input( 'id' );
        if ( $id ) {
            $up = Db::name( 'activity' )->where( 'id', $id )->update( $activity );
            if ( $up ) {
                $this->success( '更新成功', 'admin/activity/index' );
            } else {
                $this->error( '更新失败' );
            }
        } else {
            $insert = Db::name( 'activity' )->insert( $activity );
            if ( $insert ) {
                $this->success( '插入成功', 'admin/activity/index' );
            } else {
                $this->error( '插入失败' );
            }
        }

    }

    public function status()
 {
        $id = input( 'id' );
        $activity = Db::name( 'activity' )->where( 'id', $id )->value( 'activity_status' );
        if ( $activity == 0 ) {
            $data['activity_status'] = 1;
        } else {
            $data['activity_status'] = 0;
        }
        $up = Db::name( 'activity' )->where( 'id', $id )->update( $data );
        if ( $up ) {
            $this->success( '更新成功', 'admin/activity/index' );
        } else {
            $this->error( '更新失败' );
        }
    }

    //规则设置

    public function activity_rule()
 {
        $param = $this->request->param();
        ///接收input框中的值
        $where = [];
        if ( isset( $param['activity_name'] ) ) {
            $where['activity_name'] = ['like', '%' . $param['activity_name'] . '%'];
        }
        if ( isset( $param['begin_time'] ) ) {
            $begin_time = strtotime( $param['begin_time'] );
            $where['begin_time'] =  ['like', '%' . $begin_time . '%'];
        }
        if ( isset( $param['finish_time'] ) ) {
            $finish_time = strtotime( $param['finish_time'] );
            $where['finish_time'] =  ['like', '%' . $finish_time . '%'];
        }
        return $this->fetch( 'activity_rule', ['list' => model( 'ActivityRule' )
        ->alias( 'a' )
        ->join( 'activity w', 'a.activity_id = w.id' )
        ->group( 'add_time' )
        ->where( $where )
        ->field( 'a.*, w.* , a.id r_id , w.id a_id' )
        ->order( 'reward_hierarchy' )
        ->paginate( config( 'page_number' ) )] );

    }

    //增加规则

    public function activity_rule_add()
 {
        $id = input( 'id' );
        $data = Db::name( 'activity' )->select();
        $this->assign( 'id', $id );
        $this->assign( 'data', $data );
        return $this->fetch( 'rule_add' );

    }

    //进库

    public function rule_ins()
 {
        $id = input( 'id' );
        $reward_hierarchy = input( 'reward_hierarchy' );

        $activity_rule['activity_id'] = input( 'activity_id' );
        $activity_rule['reward_hierarchy'] = input( 'reward_hierarchy' );
        $activity_rule['reward_name'] = input( 'reward_name' );

        $activity_rule['add_time'] = time();
        $activity_number = input( 'activity_number/a' );
        $activity_probability =  input( 'activity_probability/a' );

        if ( $id ) {
            $where['reward_hierarchy'] = $reward_hierarchy;
            $where['activity_id'] = $id;
            $all = Db::name( 'activity_rule' )->where( $where )->select();
            foreach ( $all as $key => $value ) {
                Db::name( 'activity_rule' )->delete( $value['id'] );
            }
            for ( $i = 0; $i < count( $activity_number ) ;
            $i++ ) {
                $activity_rule['activity_number'] = $activity_number[$i];
                $activity_rule['activity_probability'] = $activity_probability[$i];
                $ins = Db::name( 'activity_rule' )->insert( $activity_rule );
            }
            if ( $ins ) {
                $this->success( '更改成功', 'admin/Activity/activity_rule' );
            } else {
                $this->error( '更改失败' );
            }
        } else {
            for ( $i = 0; $i < count( $activity_number ) ;
            $i++ ) {

                $activity_rule['activity_number'] = $activity_number[$i];
                $activity_rule['activity_probability'] = $activity_probability[$i];
                $ins = Db::name( 'activity_rule' )->insert( $activity_rule );
            }
            if ( $ins ) {
                $this->success( '插入成功', 'admin/Activity/activity_rule' );
            } else {
                $this->error( '插入失败' );
            }
        }

    }

    // 规则编辑

    public function edit_rule()
 {
        $id = input( 'id' );
        $reward_hierarchy = input( 'reward_hierarchy' );
        $data = Db::name( 'activity' )->select();
        $where['reward_hierarchy'] = $reward_hierarchy;
        $where['activity_id'] = $id;
        $tacitly = Db::name( 'activity_rule' )->where( $where )->select();
        $approve = Db::name( 'activity' )->where( 'id', $tacitly[0]['activity_id'] )->find();
        $this->assign( 'id', $id );
        $this->assign( 'tacitly', $tacitly );
        $this->assign( 'approve', $approve );
        $this->assign( 'data', $data );
        return $this->fetch( 'rule_add' );
    }

}
