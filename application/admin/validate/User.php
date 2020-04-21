<?php

namespace app\admin\validate;

use think\Validate;

class User extends Validate
{
    protected $rule = [
        'user_name' => 'require',
        'phone'   => 'require|unique:user',
        'password' => 'min:6|max:16',
    ];

    protected $message = [
        'user_name.require' => '用户名不能为空',
        'phone.require'   => '手机号不能为空',
        'phone.unique'    => '手机号已存在',
        'password.min'     => '密码长度不能小于6位',
        'password.max'     => '密码长度不能大于16位',
    ];
}
