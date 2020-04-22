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
            $begin_time = strtotime($param['begin_time']);
            $where['begin_time'] =  ['like', '%' . $begin_time . '%'];
        }
        if ( isset( $param['finish_time'] ) ) {
            $finish_time = strtotime($param['finish_time']);
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

}
