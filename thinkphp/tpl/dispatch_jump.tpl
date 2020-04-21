{__NOLAYOUT__}
<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport"
        content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>跳转提示</title>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        .tip {
            width: 20%;
            min-height: 200px;
            margin: 0 auto;
            margin-top: 10%;
        }

        .tip h1 {
            font-size: 20px;
            text-align: center;
            color: #333;
        }

        .tip a {
            color: #777;
            font-size: 22px;
        }

        .tip span {
            color: red;
            font-size: 22px;
        }

        .tip h2 {
            color: #FF9800;
            text-align: center;
            font-size: 30px;
            margin-top: 20px;
        }

        @media screen and (max-width: 1400px) {
            .tip img {
                width: 280px;
            }
        }

        .jump {
            text-align: center;
            margin-top: 7%;
            font-size: 1.2em;
        }

        .system-message {
            text-align: center;

        }

        #href {
            color: #C0C0C0;
            font-size: 1.4em;
        }

        #wait {
            color: red;
            
        }

        .success {
            margin-top: 2%;
            text-align: center;
            font-size: 1.8em;
            color: #FFCC33;
        }

        .error {
            text-align: center;
            margin-top: 2%;
            font-size: 1.8em;
            color: #FF0000;
        }

        .successimg {
            width: 242px;
            height: 242px;
            margin-top: 2%;

        }

        .errorimg {
            width: 331px;
            height: 331px;
        }
    </style>
</head>

<body>
    <div class="system-message">
        <p class="jump">
            页面自动 <a id="href" href="<?php echo($url);?>">跳转</a> 等待时间： <b id="wait"><?php echo($wait);?></b>
        </p>

        <?php switch ($code) {?>
        <?php case 1:?>
        <p class="success"><?php echo(strip_tags($msg));?></p>
        <img class="successimg" src="/Happy/success.png" alt="">

        <?php break;?>
        <?php case 0:?>

        <p class="error"><?php echo(strip_tags($msg));?></p>
        <img class="errorimg" src="/Happy/lose.png" alt="">

        <?php break;?>
        <?php } ?>
        <p class="detail"></p>
    </div>

</body>

</html>

<script type="text/javascript">
    (function () {
        var wait = document.getElementById('wait'),
            href = document.getElementById('href').href;
        var interval = setInterval(function () {
            var time = --wait.innerHTML;
            if (time <= 0) {
                location.href = href;
                clearInterval(interval);
            };
        }, 1000);
    })();
</script>