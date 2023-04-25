<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fly High</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="background-image: url('/webapp_res/background3.jpg'); background-size: 100% 100%; background-repeat: no-repeat; background-attachment: fixed;">
	<div class="page-header text-center bg-primary pt-4 pl-4 pr-4 pb-2 text-white" style="margin: 0; padding-right: 20px; padding-bottom: 0.005mm; height: fit-content;">
		<h3>Admin <u>LOGIN</u> - Fly High Airlines</h3>
        <p style="text-align:right; font-size: x-small;"><a href="/home" class=" logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure;">Back to Home</a></p></span>
	</div>

    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Enter credentials to log in</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Content for left panel -->
                        <form action="/admin/login" method="post">
                            <div class="row" style="margin-bottom: 40px;">
                                <div class="col-3 text-left font-weight-bold" style="font-size: 30px; font-weight: bold;">
                                    Username:
                                </div>
                                <div class="col-9 text-right">
                                    <input type="text" name="username" id="username" class="input-1 input-group" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 40px;">
                                <div class="col-3 text-left font-weight-bold" style="font-size: 30px; font-weight: bold;">
                                    Password:
                                </div>
                                <div class="col-9 text-right">
                                    <input type="text" name="password" id="password" class="input-1 input-group" required>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 40px;">
                                <div class="col-12 text-center font-weight-bold">
                                    <button class="login btn btn-primary" style="transition: 200ms;">Log In</button>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-10 text-right font-weight-bold">
                                Don't have an account ? <a href="/admin/signup">Sign Up</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="floating-info-panel" id="result">Result here ...</div>

    <script>
        resultPanel = document.getElementById('result')
        console.log('Result: ' + ${result})

        showMessage = (msg) => {
            setTimeout(() => {
                resultPanel.innerHTML = msg
                resultPanel.style.display = 'block'
                resultPanel.classList.add('transition-in')

                setTimeout(() => {
                    resultPanel.classList.remove('transition-in')
                    // resultPanel.style.display = "none";
                }, 3000);
            }, 500)
        }

        if(${result}) showMessage('No admin with such credentials exist ...')
    </script>

    <!-- <script src="../static/script.js"></script> -->
</body>
</html>