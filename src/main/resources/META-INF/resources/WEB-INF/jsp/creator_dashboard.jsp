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
<body style="background-image: url('/webapp_res/background4.jpg'); background-size: 100% 100%; background-repeat: no-repeat; background-attachment: fixed;">
	<div class="page-header text-center bg-primary pt-4 pl-4 pr-4 pb-2 text-white" style="margin: 0; padding-right: 20px; padding-bottom: 0.005mm; height: fit-content;">
		<h3 >Welcome Creator <u>${username}</u> - Blog On</h3>
        <p style="text-align:right; font-size: x-small;"><a href="/home" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure; margin-right: 20px;">Back to Home</a><a href="/logout" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure;">Sign Out</a></p></span>
	</div>

    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Add new blogs</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Content for data panel -->
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-md-12">
                                <input type="text" name="blogHeading" id="blogHeading" placeholder="Enter blog Heading (* Required)" class="input-1 input-group">
                            </div>
                            <div class="col-md-12 py-5">
                                <textarea name="blogText" id="blogText" placeholder="Enter your blog here" class="input-1 input-group form-control animated-textarea" rows="6"></textarea>
                            </div>
                            <div class="col-md-12">
                                <label for="blogFile" class="icon fa fa-picture-o clickable" style="font-size:25pt;" aria-hidden="true"></label>
                                <input type="file" name="fileup" id="blogFile" style="display: none;">
                                <span id="blogFileDescription">No File selected ...</span>
                            </div>
                            <div class="col-md-12 text-center">
                                <button class="login btn btn-success" style="transition: 200ms; margin-top: 40px;" onclick="sendAddBlogRequestButtonListener()">Add Blog</button>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="windowUpdate" style="display: none;">
    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Update blog</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Content for data panel -->
                        <div class="row" style="margin-bottom: 10px;">
                            <div class="col-md-12">
                                <input type="text" name="blogHeading" id="blogHeadingUpdate" placeholder="Enter blog Heading (* Required)" class="input-1 input-group">
                            </div>
                            <div class="col-md-12 py-5">
                                <textarea name="blogText" id="blogTextUpdate" placeholder="Enter your blog here" class="input-1 input-group form-control animated-textarea" rows="6"></textarea>
                            </div>
                            <div class="col-md-12">
                                <label for="blogFileUpdate" class="icon fa fa-picture-o clickable" style="font-size:25pt;" aria-hidden="true"></label>
                                <input type="file" name="fileup" id="blogFileUpdate" style="display: none;">
                                <span id="blogFileDescriptionUpdate">No File selected ...</span>
                            </div>
                            <div class="col-md-12 text-center">
                                <button class="login btn btn-success" style="transition: 200ms; margin-top: 40px;" onclick="closeUpdatePage()">Cancel</button>
                                <button class="login btn btn-success" style="transition: 200ms; margin-top: 40px;" onclick="sendUpdateBlogRequestButtonListener()">Update Blog</button>
                            </div>
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
                        <h3 class="panel-title" style="color: blue; text-align: center;">Your Blogs</h3>
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
        resultPanel = document.getElementById('result')
        console.log('Username: ' + username)

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

        showMessage('Welcome creator ' + username + ' ...')
    </script>

    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
    <script src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
    <script src="/js/creator.js"></script>
</body>
</html>