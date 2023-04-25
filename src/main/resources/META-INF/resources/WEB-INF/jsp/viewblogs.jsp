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
<body style="background-image: url('/webapp_res/background1.jpg'); background-size: 100% 100%; background-repeat: no-repeat; background-attachment: fixed;">
	<div class="page-header text-center bg-primary pt-4 pl-4 pr-4 pb-2 text-white" style="margin: 0; padding-right: 20px; padding-bottom: 0.005mm; height: fit-content;">
		<h3 >Welcome ${role} <u>${username}</u> - Blog On</h3>
        <p style="text-align:right; font-size: x-small;"><a href="/home" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure; margin-right: 20px;">Back to Home</a><a href="/logout" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure;">Sign Out</a></p></span>
	</div>

    

    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Let's view some blogs &#128516;</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Give some information or search filter here ... -->
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-md-6">
                                <input type="text" name="blogHeading" id="blogName" placeholder="Blog Name" class="input-1 input-group">
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="blogHeading" id="creatorName" placeholder="Creator Name" class="input-1 input-group">
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">All Blogs</h3>
                    </div>
                    <div class="panel-body" name="blogList" id="blogList">
                        <!-- Content for data panel -->
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="floating-info-panel" id="result">Result here ...</div>

    <script>
        username = '${username}'
        role = '${role}'
        resultPanel = document.getElementById('result')
        console.log('Username: ' + username)
        console.log('Role: ' + role)

        showMessage = (msg) => {
            setTimeout(() => {
                resultPanel.innerHTML = msg
                resultPanel.style.display = 'block'
                resultPanel.classList.add('transition-in')

                setTimeout(() => {
                    resultPanel.classList.remove('transition-in')
                    // resultPanel.style.display = "none";
                }, 3000);
            }, 100)
        }

        showMessage('Welcome ' + role + ' ' + username + ' ...')
    </script>

    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
    <script src="/js/viewblogs.js"></script>
</body>
</html>