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
        //判断你还有没有机会答题
        /**
        * 查找用户id，活动id，当前时间，这些条件都成立，那么我就不是第一次存在，那么就是直接减一次答题机会
        *    如果不存在先给用户增加默认的答题机会，下面要减去呢。
        *      先判断然后我再进行减值
        *
        */

        $answer_set = Db::name( 'answer_set' )->where( 'id', 1 )->value( 'answer_number' );
        //获取规则
        $where_number['user_id'] = session( 'user_id' );
        $where_number['add_time'] = date( 'Y-m-d', time() );
        $where_number['answer_id'] = $id;
        $user_number = Db::name( 'answer_number' )->where( $where_number )->find();

        if ( $user_number ) {
            if ( $user_number['set_add'] == 0 ) {
                //没有给你增加默认答题机会呢现在给你加上去
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
        //给默认答题次数完结
        //判断一下你是否有资格答题
        $u_number = Db::name( 'answer_number' )->where( $where_number )->value( 'answer_number' );
        if ( $u_number < $answer_set ) {
            return 2;
            exit;
            //没有答题资格了
        }
        Db::name( 'answer_number' )->where( $where_number )->setDec( 'answer_number', 1 );
        //减去一次答题机会

        $all = session( 'topic_all' );
        if ( !$all ) {
            $num = 10;
            //需要随机抽取的数据
            $count = Db::name( 'topic' )->count();
            $rand = mt_rand( 0, $count-1 );
            //产生随机数。
            $limit = $rand.','.$count;
            $list = Db::name( 'topic' )->limit( $limit )->select();
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
        $uniqueness = time();
        foreach ( $all as $key => $value ) {
            $all[$key]['url'] = $url . $control . 'topic_id/' . $value['id'] . '/activity_id/' . $id;
            $all[$key]['answer_id'] = $id;
            $all[$key]['uniqueness'] = $uniqueness;
            //生成唯一标识
        }

        // //当我点击这个活动以后我就代表已经进行答题了（山面查找，如果没有机会那么不会执行到这一步，执行在上面都要进行拦截;
        // $answer_number['user_id'] = session( 'user_id' );
        // $answer_number['user_name'] = session( 'user_name' );
        // $answer_number['answer_number'] = 1;
        //每次加一（前提是有，没有那么就是插入）
        // $answer_number['add_time'] = date( 'Y-m-d', time() );
        // $answer_number['answer_id'] = $id;
        //唯一标识

        // $where['user_id'] = $answer_number['user_id'];
        // $where['add_time'] = $answer_number['add_time'];
        //必须为当天的时间才可
        // $where['answer_id'] = $id;
        // $ins_number = Db::name( 'answer_number' )->where( $where )->setInc( 'answer_number', 1 );
        // if ( $ins_number ) {
        //     //插入成功
        // } else {
        //     Db::name( 'answer_number' )->insert( $answer_number );
        // }

        return $all;
    }

    //回答题啊

    public function response() {
        return $this->fetch( 'response' );
    }

    // 显示题的内容（不重复）

    public function particular() {
        $choose_id = input( 'choose_id' );
        $topic_id = input( 'topic_id' );
        //        $choose_id = '489,490,491,492,493';
        $choose_id = explode( ',', $choose_id );
        for ( $i = 0; $i < count( $choose_id );
        $i++ ) {
            $where['id'] = $choose_id[$i];
            $where['topic_id'] = $topic_id;
            $data[] = Db::name( 'choose' )->where( $where )->find();
        }
        return json( $data );
    }

    // 回答问题表插入（在这里判断答题次数 )

    public function in_answer() {
        $number = input( 'number' );

        if ( $number < 11 ) {
            $data['topic_id'] = input( 'topic_id' );
            //题的id
            $data['choose_id'] = input( 'choose' );
            //用户选项的id
            $data['activity_id'] = input( 'activity_id' );
            //活动的id
            $data['user_name'] = session( 'user_name' );
            //用户名
            $data['user_id'] = session( 'user_id' );
            //用户id
            $data['answer_uniqueness'] = input( 'answer_uniqueness' );
            //唯一标识
            $data['add_time'] = date( 'Y-m-d', time() );
            $data['answer_next'] = '1';
            //这里测试数据为1
            $topic = Db::name( 'topic' )->where( 'id', $data['topic_id'] )->find();
            if ( $data['choose_id'] == $topic['choose_correct_id'] ) {
                $data['answer_whether'] = 1;
                //答对
                $data['user_correct'] = 1;
                //答对
                $whether = 1;
            } else {
                $data['answer_whether'] = 0;
                $data['user_correct'] = 0;
                $whether = 0;
            }
            $ins = Db::name( 'answer' )->insert( $data );
            //正确答案

            if ( $number == 10 ) {
                $new_time = date( 'Y-m-d', time() );
                $where['answer_uniqueness'] = $data['answer_uniqueness'];
                $where['user_id'] = $data['user_id'];
                $where['add_time'] = $new_time;
                //必须为当天的时间才可
                $lottery = Db::name( 'answer' )->where( $where )->sum( 'user_correct' );
                if ( $lottery > 8 ) {
                    //将可抽奖人的名单放在一个表中
                    $draw['user_id'] = session( 'user_id' );
                    $draw['user_name'] = session( 'user_name' );
                    $draw['activity_id'] = input( 'activity_id' );
                    $draw['add_time'] = $new_time;
                    $draw['answer_uniqueness'] = input( 'answer_uniqueness' );
                    Db::name( 'activity_draw' )->insert( $draw );
                    return 6;
                    //可抽奖
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

    public function test() {

    }

    //抽奖页面

    public function draw() {
        echo '我是抽检';
    }

    //分享功能

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
                //表示你还没有分享
                $shaer_id = $all['id'];
                $shaer['answer_number'] = $all['answer_number'] + 1;
                $shaer['share_add'] = 1;
                //已经分享
                $up = Db::name( 'answer_number' )->where( 'id', $shaer_id )->update( $shaer );
            }
        } else {
            $data['answer_number'] = 1;
            $data['share_add'] = 1;
            //已经分享
            $ins = Db::name( 'answer_number' )->insert( $data );
            if ( $ins ) {
                return 2;
            } else {
                return 3;
            }
        }
    }

    public function choujiang() {
        $all = ["手机","电脑","大牛"];
     $arr = $this->getRand($all);
     dump($arr);
    }

    function getRand( $proArr ) {
        //传入的为一维数字数组, 此数组中度数字即为相应概率知
        $result = '';
        //概率数组的总概率精道度
        $proSum = 2;

        //概率数组循环
        foreach ( $proArr as $key => $proCur ) {
            $randNum = mt_rand( 1, $proSum );
            if ( $randNum <= $proCur ) {
                $result = $key;
                break;
            } else {
                $proSum -= $proCur;
            }
        }
        unset ( $proArr );
        return $result;
    }

}
