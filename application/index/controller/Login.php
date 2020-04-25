<?php
namespace app\index\controller;
use app\common\controller\IndexBase;
use think\Db;
use think\Log;

class Login extends IndexBase
 {
    public function index() {
        return $this->fetch( 'index' );
    }

    public function register() {
        return $this->fetch( 'register' );
    }

    public function verify() {
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

                session( 'user_id', $sid );
                session( 'user_phone', $phone );
                return 0;
            } else {
                return 1;
            }
        } else {
            return 2;
        }
    }

    public function registration() {
        $data['user_name'] = input( 'username' );
        $data['password'] = input( 'password' );
        $data['phone'] = input( 'phone' );
        $data['gender'] = input( 'gender' );
        $data['add_time'] = time();
        $name = Db::name( 'user' )->where( 'user_name', $data['user_name'] )->find();
        if ( $name ) {
            return 0;
        } else {
            $ins = Db::name( 'user' )->insert( $data );
            if ( $ins ) {
                return 1;
            } else {
                return 2;
            }
        }
    }

}
