<?php

namespace app\admin\controller;

use app\common\controller\AdminBase;
use think\Log;
use think\Db;

class User extends AdminBase {
    protected function _initialize() {
        parent::_initialize();
    }

    public function index() {

        $param = $this->request->param();
        ///接收input框中的值
        $where = [];
        if ( isset( $param['user_name'] ) ) {
            $where['user_name'] = ['like', '%' . $param['user_name'] . '%'];
        }
        if ( isset( $param['phone'] ) ) {
            $where['phone'] = $param['phone'];
        }
        return $this->fetch( 'index', ['list' => model( 'user' )->order( 'id desc' )->where( $where )->paginate( config( 'page_number' ) )] );
    }

    public function edit() {
        $id = input( 'id' );
        $data = Db::name( 'user' )->where( 'id', $id )->find();
        $this->assign( 'id', $id );
        $this->assign( 'data', $data );
        return $this->fetch( 'save' );
    }

    public function del() {
        if ( $this->request->isPost() ) {
            if ( $this->delete( 'user', $this->request->param() ) === true ) {
                $this->success( '删除成功' );
            } else {
                $this->error( $this->errorMsg );
            }
        }
    }

    public function up() {
        $data['user_name'] = input( 'user_name' );
        $data['phone'] = input( 'phone' );
        $data['password'] = input( 'password' );
        $data['gender'] = input( 'gender' );
        $id = input( 'id' );
        $up = Db::name( 'user' )->where( 'id', $id )->update( $data );
        if ( $up ) {
            $this->success( '更新成功' ,'admin/User/index');
        } else {
            $this->error( '插入失败' );
        }
    }

    public function truncate() {
        if ( $this->request->isPost() ) {
            db()->query( 'TRUNCATE ' . config( 'database.prefix' ) . 'user_log' );
            $this->success( '操作成功' );
        }
    }
}
