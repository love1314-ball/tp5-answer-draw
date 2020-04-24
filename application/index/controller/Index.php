<?php

namespace app\index\controller;

use app\common\controller\IndexBase;
use think\Db;
use think\Request;
use think\Session;
use think\Log;
//首页

class Index extends IndexBase
{

    public function index()
    {
        $username = session('user_name');
        if (!$username) {
            $this->error('请登录账号', 'index/Login/index');
        }
        session('topic_all', null);
        //清空session
        $activity = Db::name('activity')->select();
        $this->assign('activity', $activity);
        return $this->fetch('index');

    }

    //点进活动内然后进行答题

    public function answer()
    {
        $request = Request::instance();
        $id = input('answer');
        $activity = Db::name('activity')->where('id', $id)->find();
        $time = date('Y-m-d', time());
        $begin_time = date('Y-m-d', $activity['begin_time']);
        $finish_time = date('Y-m-d', $activity['finish_time']);
        if ($time < $begin_time) {
            return 0;
            exit;
        }
        if ($time > $finish_time) {
            return 1;
            exit;
        }
        //判断你还有没有机会答题
//        $judge['user_id] = session('user_id');
//        $judge[''] = $time;
        Log::record(  $first );
        exit;

        $all = session('topic_all');
        if (!$all) {
            $num = 10;
            //需要随机抽取的数据
            $list = Db::name('topic')->order('id desc')->limit(100)->select();
            //获取数据集 总数100条，可以根据自己的实际情况决定是否需要limit
            shuffle($list);
            //打乱数组
            $new_ary = array_slice($list, 0, $num);
            //抽取数据
            session('topic_all', $new_ary);
            $all = session('topic_all');
            unset($new_ary);
        } else {
            $all = $all;
        }
        //生成链接
        $url = $request->domain();
        $control = '/index/index/response/';
        $uniqueness = time();
        foreach ($all as $key => $value) {
            $all[$key]['url'] = $url . $control . 'topic_id/' . $value['id'] . '/activity_id/' . $id;
            $all[$key]['answer_id'] = $id;
            $all[$key]['uniqueness'] = $uniqueness;//生成唯一标识
        }

        //当我点击这个活动以后我就代表已经进行答题了
        
        return $all;
    }

    //回答题啊

    public function response()
    {
        return $this->fetch('response');
    }

    // 显示题的内容（不重复）

    public function particular()
    {
        $choose_id = input('choose_id');
        $topic_id = input('topic_id');
        //        $choose_id = '489,490,491,492,493';
        $choose_id = explode(',', $choose_id);
        for ($i = 0; $i < count($choose_id);
             $i++) {
            $where['id'] = $choose_id[$i];
            $where['topic_id'] = $topic_id;
            $data[] = Db::name('choose')->where($where)->find();
        }
        return json($data);
    }

    // 回答问题表插入（在这里判断答题次数)

    public function in_answer()
    {
        $number = input('number');

        if ($number < 11) {
            $data['topic_id'] = input('topic_id');
            //题的id
            $data['choose_id'] = input('choose');
            //用户选项的id
            $data['activity_id'] = input('activity_id');
            //活动的id
            $data['user_name'] = session('user_name');
            //用户名
            $data['user_id'] = session('user_id');
            //用户id
            $data['answer_uniqueness'] = input('answer_uniqueness');
            //唯一标识
            $data['add_time'] = date('Y-m-d', time());
            $data['answer_next'] = "1";//这里测试数据为1
            $topic = Db::name('topic')->where('id', $data['topic_id'])->find();
            if ($data['choose_id'] == $topic['choose_correct_id']) {
                $data['answer_whether'] = 1;//答对
                $data['user_correct'] = 1;//答对
                $whether = 1;
            } else {
                $data['answer_whether'] = 0;
                $data['user_correct'] = 0;
                $whether = 0;
            }
            $ins = Db::name('answer')->insert($data);
            //正确答案


            if ($number == 10) {
                $new_time = date('Y-m-d', time());
                $where['answer_uniqueness'] = $data['answer_uniqueness'];
                $where['user_id'] = $data['user_id'];
                $where['add_time'] = $new_time;//必须为当天的时间才可
                $lottery = Db::name('answer')->where($where)->sum('user_correct');
                if ($lottery > 8) {
                    //将可抽奖人的名单放在一个表中
                    $draw['user_id'] = session('user_id');
                    $draw['user_name'] = session('user_name');
                    $draw['activity_id'] = input('activity_id');
                    $draw['add_time'] = $new_time;
                    $draw['answer_uniqueness'] = input('answer_uniqueness');
                    Db::name('activity_draw')->insert($draw);
                    return 6;//可抽奖
                } else {
                    return 7;
                }
            }
            $tures = $topic['topic_correct'];
            if ($ins) {
                $arr = [0, $whether, $tures];
                return $arr;
            } else {
                $arr = [1, $whether, $tures];
                return $arr;
            }

        }


    }

    public function test()
    {


    }

    //抽奖页面
    public function draw()
    {
        echo "我是抽检";
    }


    //分享功能
    public function share()
    {
        $data['user_name'] = session('user_name');
        $data['user_id'] = session('user_id');
        $data['activity_id'] = input('answer');
        $data['add_time'] = date('Y-m-d', time());
        $where['user_id'] = $data['user_id'];
        $where['add_time'] = $data['add_time'];
        $where['activity_id'] = $data['activity_id'];
        $all = Db::name('share')->where($where)->setInc('share_number', 1);
        if ($all) {
            return 1;//分享成功
        } else {
            $data['share_number'] = 1;
            $ins = Db::name('share')->insert($data);
            if ($ins) {
                return 2;
            } else {
                return 3;
            }
        }
    }


}
