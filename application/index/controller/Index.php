<?php

namespace app\index\controller;

use app\common\controller\IndexBase;
use think\Db;
use think\Request;
use think\Session;
//首页

class Index extends IndexBase {

    public function index() {
        $username = session( 'user_name' );
        if ( !$username ) {
            $this->error( '请登录账号', 'index/Login/index' );
        }
        session( 'topic_all', null );
        //清空session
        $activity = Db::name( 'activity' )->select();
        $this->assign( 'activity', $activity );
        return $this->fetch( 'index' );

    }

    //点进活动内然后进行答题

    public function answer() {
        $request = Request::instance();
        $id = input( 'answer' );
        $activity = Db::name( 'activity' )->where( 'id', $id )->find();
        $time = date( 'Y-m-d', time() );
        $begin_time = date( 'Y-m-d', $activity['begin_time'] ) ;
        $finish_time = date( 'Y-m-d', $activity['finish_time'] ) ;
        if ( $time < $begin_time ) {
            return 0;
            echo '<script>alert("活动暂时没开启");window.history.go(-1); </script>';
            exit;
        }
        if ( $time > $finish_time ) {
            return 1;
            echo '<script>alert("活动已过期");window.history.go(-1); </script>';
            exit;
        }
        $all = session( 'topic_all' );
        if ( !$all ) {
            $num = 10;
            //需要随机抽取的数据
            $list = Db::name( 'topic' )->order( 'id desc' )->limit( 100 )->select();
            //获取数据集 总数100条，可以根据自己的实际情况决定是否需要limit
            shuffle( $list );
            //打乱数组
            $new_ary = array_slice( $list, 0, $num );
            //抽取数据
            session( 'topic_all', $new_ary );
            $all = session( 'topic_all' );
            unset( $new_ary );
        } else {
            $all = $all;
        }
        //生成链接
        $url = $request->domain();
        $control = '/index/index/response/';
        foreach ( $all as $key => $value ) {
            $all[$key]['url'] = $url.$control.'topic_id/'.$value['id'].'/activity_id/'.$id;
            $all[$key]['answer_id'] = $id;
        }
        return $all;
    }

    //回答题啊

    public function response() {

        // $input = input();
        // dump( $input );
        // exit;
        return $this->fetch( 'response' );
    }

     // 显示题的内容（不重复）

     public function particular()
     {
         $choose_id = input('choose_id');
         $topic_id = input('topic_id');
         $choose_id = '489,490,491,492,493';
         $al = explode(",", $al);
         for ($i=0; $i < count($al); $i++) { 
             $data[] = Db::name('choose')->where('id',$al[$i])->find();
         }
        return json($data);
     }

}
