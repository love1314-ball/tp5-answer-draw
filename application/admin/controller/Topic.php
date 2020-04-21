<?php

namespace app\admin\controller;

use app\common\controller\AdminBase;
use think\Log;
use think\Db;
//题目管理

class Topic extends AdminBase {
    protected function _initialize() {
        parent::_initialize();
    }

    public function index() {

        $param = $this->request->param();
        ///接收input框中的值
        $where = [];
        if ( isset( $param['topic_name'] ) ) {
            $where['topic_name'] = ['like', '%' . $param['topic_name'] . '%'];
        }
        if ( isset( $param['phone'] ) ) {
            $where['phone'] = $param['phone'];
        }
        return $this->fetch( 'index', ['list' => model( 'topic' )->order( 'id desc' )->where( $where )->paginate( config( 'page_number' ) )] );
    }

    public function edit() {
        $id = input( 'id' );
        $data = Db::name( 'topic' )->where( 'id', $id )->find();
        $choose_id = explode( ',', $data['choose_id'] );
        for ( $i = 0; $i < count( $choose_id );
        $i++ ) {

            $choose_all[] = Db::name( 'choose' )->where( 'id', $choose_id[$i] )->find();

        }
        $this->assign( 'id', $id );
        $this->assign( 'data', $data );
        $this->assign( 'choose', $choose_all );
        return $this->fetch( 'save' );
    }

    public function del() {
        if ( $this->request->isPost() ) {
            if ( $this->delete( 'topic', $this->request->param() ) === true ) {
                $this->success( '删除成功' );
            } else {
                $this->error( $this->errorMsg );
            }
        }
    }

    public function ins() {
        $topic['topic_name'] = input( 'topic_name' );
        $topic['topic_correct'] = input( 'topic_correct' );
        $choose_name = input( 'choose_name/a' );
        $topic['add_time'] = time();
        $id = input( 'id' );
        if ( $id ) {
            $all = input();
            $topic['topic_name'] = input( 'topic_name' );
            $topic['topic_correct'] = input( 'topic_correct' );

            $choose_id = Db::name( 'topic' )->where( 'id', $id )->value( 'choose_id' );
            $topic_id =  explode( ',', $choose_id );
            //查询出来选项的id
            for ( $i = 0; $i < count( $topic_id );
            $i++ ) {
                Db::name( 'choose' )->delete( $topic_id[$i] );
                //删除数据方便我们下面使用
            }

            for ( $z = 0; $z < count( $choose_name ) ;
            $z++ ) {
                $data['topic_id'] = $id;
                $data['choose_name'] = $choose_name[$z];
                $data['add_time'] = time();
                $choose[] = Db::name( 'choose' )->insertGetId( $data );
                //选项的id
            }

            $new_topic['choose_id'] = implode( ',', $choose );
            //选项表的id
            $where['topic_id'] = $id;
            $where['choose_name'] = $topic['topic_correct'];
            $new_topic['choose_correct_id'] = Db::name( 'choose' )->where( $where )->value( 'id' );
            //选项表中正确的id
            $up = Db::name( 'topic' )->where( 'id', $id )->update( $new_topic );
            if ( $choose ) {
                $this->success( '更新成功', 'admin/Topic/index' );
            } else {
                $this->error( '更新失败' );
            }
        } else {
            $topic_id = Db::name( 'topic' )->insertGetId( $topic );
            //题的id
            for ( $i = 0; $i < count( $choose_name ) ;
            $i++ ) {
                $data['topic_id'] = $topic_id;
                $data['choose_name'] = $choose_name[$i];
                $data['add_time'] = time();
                $choose[] = Db::name( 'choose' )->insertGetId( $data );
                //选项的id
            }
            $new_topic['choose_id'] = implode( ',', $choose );
            //选项表的id
            $where['topic_id'] = $topic_id;
            $where['choose_name'] = $topic['topic_correct'];
            $new_topic['choose_correct_id'] = Db::name( 'choose' )->where( $where )->value( 'id' );
            //选项表中正确的id
            $up = Db::name( 'topic' )->where( 'id', $topic_id )->update( $new_topic );
            if ( $choose ) {
                $this->success( '操作成功', 'admin/Topic/index' );
            } else {
                $this->error( '插入失败' );
            }
        }

    }

    // 导入文件
    public function lead() {
        return $this->fetch();
    }
}
