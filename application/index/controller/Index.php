<?php
namespace app\index\controller;
use app\common\controller\IndexBase;
use think\Db;
use think\Request;
use think\Session;
use think\Log;
//首页

class Index extends IndexBase {

    public function index() {
        $username = session( 'user_name' );
        if ( !$username ) {
            $this->error( '请登录账号', 'index/Login/index' );
        }
        session( 'topic_all', null );
        $activity = Db::name( 'activity' )->select();
        $this->assign( 'activity', $activity );
        return $this->fetch( 'index' );
    }

    public function answer() {
        $request = Request::instance();
        $id = input( 'answer' );
        $activity = Db::name( 'activity' )->where( 'id', $id )->find();
        $time = date( 'Y-m-d', time() );
        $begin_time = date( 'Y-m-d', $activity['begin_time'] );
        $finish_time = date( 'Y-m-d', $activity['finish_time'] );
        if ( $time < $begin_time ) {
            return 0;
            exit;
        }
        if ( $time > $finish_time ) {
            return 1;
            exit;
        }
        $answer_set = Db::name( 'answer_set' )->where( 'id', 1 )->value( 'answer_number' );
        $where_number['user_id'] = session( 'user_id' );
        $where_number['add_time'] = date( 'Y-m-d', time() );
        $where_number['answer_id'] = $id;
        $user_number = Db::name( 'answer_number' )->where( $where_number )->find();
        if ( $user_number ) {
            if ( $user_number['set_add'] == 0 ) {
                $set_id = $user_number['id'];
                $data['answer_number'] = $answer_set + $user_number['answer_number'];
                $data['set_add'] = 1;
                Db::name( 'answer_number' )->where( 'id', $set_id )->update();
            }
        } else {
            $inse['user_name'] = session( 'user_name' );
            $inse['user_id'] = session( 'user_id' );
            $inse['answer_id'] = input( 'answer' );
            $inse['set_add'] = 1;
            $inse['answer_number'] = $answer_set;
            $inse['add_time'] = date( 'Y-m-d', time() );
            Db::name( 'answer_number' )->insert( $inse );
        }
        $u_number = Db::name( 'answer_number' )->where( $where_number )->value( 'answer_number' );
        if ( $u_number < $answer_set ) {
            return 2;
            exit;
        }
        Db::name( 'answer_number' )->where( $where_number )->setDec( 'answer_number', 1 );
        $all = session( 'topic_all' );
        if ( !$all ) {
            $new_ary = Db::name('topic')->orderRaw('rand()')->limit(10)->select();
            session( 'topic_all', $new_ary );
            $all = session( 'topic_all' );
            unset( $new_ary );
        } else {
            $all = $all;
        }
        $url = $request->domain();
        $control = '/index/index/response/';
        $uniqueness = time();
        foreach ( $all as $key => $value ) {
            $all[$key]['url'] = $url . $control . 'topic_id/' . $value['id'] . '/activity_id/' . $id;
            $all[$key]['answer_id'] = $id;
            $all[$key]['uniqueness'] = $uniqueness;
        }
        return $all;
    }

    public function response() {
        return $this->fetch( 'response' );
    }

    public function particular() {
        $choose_id = input( 'choose_id' );
        $topic_id = input( 'topic_id' );
        $choose_id = explode( ',', $choose_id );
        for ( $i = 0; $i < count( $choose_id );
        $i++ ) {
            $where['id'] = $choose_id[$i];
            $where['topic_id'] = $topic_id;
            $data[] = Db::name( 'choose' )->where( $where )->find();
        }
        return json( $data );
    }

    public function in_answer() {
        $number = input( 'number' );
        if ( $number < 11 ) {
            $data['topic_id'] = input( 'topic_id' );
            $data['choose_id'] = input( 'choose' );
            $data['activity_id'] = input( 'activity_id' );
            $data['user_name'] = session( 'user_name' );
            $data['user_id'] = session( 'user_id' );
            $data['answer_uniqueness'] = input( 'answer_uniqueness' );
            $data['add_time'] = date( 'Y-m-d', time() );
            $data['answer_next'] = '1';
            $topic = Db::name( 'topic' )->where( 'id', $data['topic_id'] )->find();
            if ( $data['choose_id'] == $topic['choose_correct_id'] ) {
                $data['answer_whether'] = 1;
                $data['user_correct'] = 1;
                $whether = 1;
            } else {
                $data['answer_whether'] = 0;
                $data['user_correct'] = 0;
                $whether = 0;
            }
            $ins = Db::name( 'answer' )->insert( $data );
            if ( $number == 10 ) {
                $new_time = date( 'Y-m-d', time() );
                $where['answer_uniqueness'] = $data['answer_uniqueness'];
                $where['user_id'] = $data['user_id'];
                $where['add_time'] = $new_time;
                $lottery = Db::name( 'answer' )->where( $where )->sum( 'user_correct' );
                if ( $lottery > 8 ) {
                    $draw['user_id'] = session( 'user_id' );
                    $draw['user_name'] = session( 'user_name' );
                    $draw['activity_id'] = input( 'activity_id' );
                    $draw['add_time'] = $new_time;
                    $draw['answer_uniqueness'] = input( 'answer_uniqueness' );
                    Db::name( 'activity_draw' )->insert( $draw );
                    $activity_id = input( 'activity_id' );
                    $this->draw_ins( $activity_id );
                    return 6;
                } else {
                    return 7;
                }
            }
            $tures = $topic['topic_correct'];
            if ( $ins ) {
                $arr = [0, $whether, $tures];
                return $arr;
            } else {
                $arr = [1, $whether, $tures];
                return $arr;
            }

        }

    }

    public function draw_ins( $activity_id ) {
        session( 'activity_id', $activity_id );
        $activity_ids = session( 'activity_id' );
        $data['user_name'] = session( 'user_name' );
        $data['user_id'] = session( 'user_id' );
        $data['add_time'] = date( 'Y-m-d', time() );
        $data['activity_number'] = 1;
        $data['activity_id'] = $activity_ids;
        $where['user_id'] = $data['user_id'];
        $where['activity_id'] = $activity_ids;
        $where['add_time'] = $data['add_time'];
        $draw = Db::name( 'draw' )->where( $where )->find();
        if ( $draw ) {
            $up = Db::name( 'draw' )->where( 'id', $draw['id'] )->setInc( 'activity_number', 1 );
        } else {
            $ins = Db::name( 'draw' )->insert( $data );
        }
    }

    public function draw() {
        $activity_id = session( 'activity_id' );
        $activity = Db::name( 'activity' )->where( 'id', $activity_id )->find();
        $activity_rul = Db::name( 'activity_rule' )->Distinct( true )->field( 'add_time' )->where( 'activity_id', $activity_id )->select();
        foreach ( $activity_rul as $key => $value ) {
            $activity_rule[] = Db::name( 'activity_rule' )->where( 'add_time', $value['add_time'] )->find();
        }
        $this->assign( 'activity', $activity );
        $this->assign( 'activity_rul', $activity_rule );
        return $this->fetch( 'draw' );
    }

    public function share() {
        $data['user_name'] = session( 'user_name' );
        $data['user_id'] = session( 'user_id' );
        $data['answer_id'] = input( 'answer' );
        $data['add_time'] = date( 'Y-m-d', time() );
        $where['user_id'] = $data['user_id'];
        $where['add_time'] = $data['add_time'];
        $where['answer_id'] = $data['answer_id'];
        $all = Db::name( 'answer_number' )->where( $where )->find();
        if ( $all ) {
            if ( $all['share_add'] == 0 ) {
                $shaer_id = $all['id'];
                $shaer['answer_number'] = $all['answer_number'] + 1;
                $shaer['share_add'] = 1;
                $up = Db::name( 'answer_number' )->where( 'id', $shaer_id )->update( $shaer );
            }
        } else {
            $data['answer_number'] = 1;
            $data['share_add'] = 1;
            $ins = Db::name( 'answer_number' )->insert( $data );
            if ( $ins ) {
                return 2;
            } else {
                return 3;
            }
        }
    }

    public function awarded() {
        $activity_id =  input( 'activity_id' );
        $win_draw['user_id'] = session( 'user_id' );
        $win_draw['add_time'] = date( 'Y-m-d', time() );
        $win_draw['activity_id'] = $activity_id;
        $user = Db::name( 'draw' )->where( $win_draw )->find();
        $activity_number = $user['activity_number'];
        $where['activity_id'] = $activity_id;
        $where['activity_number'] = $activity_number;
        $ru = Db::name( 'activity_rule' )->order( 'activity_probability' )->where( $where )->field( ' *,activity_probability as scope' )->select();
        $probability1 = range( 1, $ru[0]['scope'] );
        if ( $ru[1] ) {
            $probability2 = range( $ru[0]['scope']+1, $ru[1]['scope'] );
        }
        if ( $ru[2] ) {
            $probability3 = range( $ru[1]['scope']+1, $ru[2]['scope']+$ru[0]['scope']+$ru[1]['scope'] );
        }
        $always = rand( 1, 100 );
        $specific = '';
        if ( in_array( $always, $probability1 ) ) {
            $specific =  $ru[0]['reward_name'];
        }
        if ( in_array( $always, $probability2 ) ) {
            $specific =  $ru[1]['reward_name'];
        }
        if ( in_array( $always, $probability3 ) ) {
            $specific =  $ru[2]['reward_name'];
        }
        if ( $specific == '' ) {
            $specific = $ru[2]['reward_name'];
        }
        $win_draw['user_name'] = session( 'user_name' );
        $win_draw['draw_name'] = $specific;
        Db::name( 'win_draw' )->insert( $win_draw );
        echo( "<script>window.alert('恭喜你抽中了---'+'$specific')</script>" );
        $request = Request::instance();
        $URL_MI = $request->domain();
        $URL_MI = $URL_MI . '/index/index/index';
        echo( "<script>window.location= '$URL_MI'</script>" );
    }
}
