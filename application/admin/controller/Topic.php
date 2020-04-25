<?php
namespace app\admin\controller;
use app\common\controller\AdminBase;
use think\Log;
use think\Request;
use think\Db;
//题目管理

class Topic extends AdminBase {
    protected function _initialize() {
        parent::_initialize();
    }

    public function index() {
        $param = $this->request->param();
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
            for ( $i = 0; $i < count( $topic_id );
            $i++ ) {
                Db::name( 'choose' )->delete( $topic_id[$i] );
            }
            for ( $z = 0; $z < count( $choose_name ) ;
            $z++ ) {
                $data['topic_id'] = $id;
                $data['choose_name'] = $choose_name[$z];
                $data['add_time'] = time();
                $choose[] = Db::name( 'choose' )->insertGetId( $data );
            }
            $new_topic['choose_id'] = implode( ',', $choose );
            $new_topic['topic_name'] = input( 'topic_name' );
            $where['topic_id'] = $id;
            $where['choose_name'] = $topic['topic_correct'];
            $new_topic['choose_correct_id'] = Db::name( 'choose' )->where( $where )->value( 'id' );
            $up = Db::name( 'topic' )->where( 'id', $id )->update( $new_topic );
            if ( $choose ) {
                $this->success( '更新成功', 'admin/Topic/index' );
            } else {
                $this->error( '更新失败' );
            }
        } else {
            $topic_id = Db::name( 'topic' )->insertGetId( $topic );
            for ( $i = 0; $i < count( $choose_name ) ;
            $i++ ) {
                $data['topic_id'] = $topic_id;
                $data['choose_name'] = $choose_name[$i];
                $data['add_time'] = time();
                $choose[] = Db::name( 'choose' )->insertGetId( $data );
            }
            $new_topic['choose_id'] = implode( ',', $choose );
            $where['topic_id'] = $topic_id;
            $where['choose_name'] = $topic['topic_correct'];
            $new_topic['choose_correct_id'] = Db::name( 'choose' )->where( $where )->value( 'id' );
            $up = Db::name( 'topic' )->where( 'id', $topic_id )->update( $new_topic );
            if ( $choose ) {
                $this->success( '操作成功', 'admin/Topic/index' );
            } else {
                $this->error( '插入失败' );
            }
        }

    }


    public function lead() {
        return $this->fetch( 'lead' );
    }

    public function lead_add()
 {
        $file = $this->request->file( 'excel' );
        $info = $file->move( ROOT_PATH . 'public' . DS . 'Excel' );
        if ( $info ) {
            $file_name = ROOT_PATH . 'public' . DS . 'excel' . DS . $info->getsaveName();
            $extension = strtolower( pathinfo( $file_name, PATHINFO_EXTENSION ) );
            vendor( 'PHPExcel.PHPExcel' );
            $objPHPExcel = new \PHPExcel();
            if ( $extension == 'xls' ) {
                $objReader = \PHPExcel_IOFactory::createReader( 'Excel5' );
            }
            if ( $extension == 'xlsx' ) {
                $objReader = \PHPExcel_IOFactory::createReader( 'Excel2007' );
            }
            $obj_PHPExcel = $objReader->load( $file_name, $encode = 'utf-8' );
            $excel_array = $obj_PHPExcel->getsheet( 0 )->toArray();
            array_shift( $excel_array );
            foreach ( $excel_array as $key => $value ) {
                $excel_array[$key] = array_filter( $value );
            }
            $exist = 0;
            $inexistence = 0;
            foreach ( $excel_array as $ke => $val ) {
                $already = Db::name( 'topic' )->where( 'topic_name', $val[0] )->find();
                if ( !$already ) {
                    $topic['add_time'] = time();
                    $topic['topic_name'] = $val[0];
                    $topic['topic_correct'] = $val[1];
                    $topic_id = Db::name( 'topic' )->insertGetId( $topic );
                    ++$inexistence;
                    for ( $i = 2; $i < count( $val );
                    $i++ ) {
                        $data['topic_id'] = $topic_id;
                        $data['choose_name'] = $val[$i];
                        $data['add_time'] = time();
                        $choose[] = Db::name( 'choose' )->insertGetId( $data );
                    }
                    $new_topic['choose_id'] = implode( ',', $choose );
                    unset( $choose );
                    $where['topic_id'] = $topic_id;
                    $where['choose_name'] = $topic['topic_correct'];
                    $new_topic['choose_correct_id'] = Db::name( 'choose' )->where( $where )->value( 'id' );
                    $up = Db::name( 'topic' )->where( 'id', $topic_id )->update( $new_topic );
                } else {
                    ++$exist;
                    $up = true;
                }
            }
            if ( $up ) {
                $this->success( "导入成功 $inexistence 条 , 数据库存在 $exist 条", 'admin/topic/index' );
            } else {
                $this->error( '导入失败' );
            }
        } else {
            $this->error( $file->getError() );
        }
    }


    public function below() {
        $file = '/Excel/默认表.xlsx';
        $file_lj = str_replace( '\\', '/', ROOT_PATH.'public' );
        $files = $file_lj.$file;
        if ( !file_exists( $files ) ) {
            return '文件不存在';
        } else {
            $file1 = fopen( $files, 'r' );
            Header( 'Content-type: application/octet-stream' );
            Header( 'Accept-Ranges: bytes' );
            Header( 'Accept-Length: ' . filesize( $files ) );
            Header( 'Content-Disposition: attachment; filename=例子表.xlsx' );
            echo fread( $file1, filesize( $files ) );
            fclose( $file1 );
        }
    }

}
