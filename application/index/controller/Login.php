<?php

namespace app\index\controller;

use app\common\controller\IndexBase;
use think\Db;
use think\Log;
//注册登录

class Login extends IndexBase
 {
    public function index()
 {
        return $this->fetch( 'index' );
    }
    //注册

    public function register()
 {
        return $this->fetch( 'register' );
    }

    //登录验证

    public function verify()
 {

        $user_name = input( 'username' );
        $password = input( 'password' );
        $name = Db::name( 'user' )->where( 'user_name', $user_name )->find();
        if ( $name ) {
            $pass = Db::name( 'user' )->where( 'user_name', $user_name )->where( 'password', $password )->find();
            $name = $pass['user_name'];
            $sid = $pass['id'];
            $phone = $pass['phone'];
            if ( $pass ) {
                session( 'user_name', $name );
                //session赋值
                session( 'user_id', $sid );
                //session赋值
                session( 'user_phone', $phone );
                //session赋值
                return 0;
            } else {
                return 1;
            }
        } else {
            return 2;
        }
    }

    //注册验证

    public function registration()
 {
        $data['user_name'] = input( 'username' );
        $data['password'] = input( 'password' );
        $data['phone'] = input( 'phone' );
        $data['gender'] = input( 'gender' );
        $data['add_time'] = time();
        //获取当前时间
        $name = Db::name( 'user' )->where( 'user_name', $data['user_name'] )->find();
        if ( $name ) {
            return 0;
        } else {
            $ins = Db::name( 'user' )->insert( $data );
            //插入新人信息
            if ( $ins ) {
                return 1;
            } else {
                return 2;
            }
        }
    }

}
