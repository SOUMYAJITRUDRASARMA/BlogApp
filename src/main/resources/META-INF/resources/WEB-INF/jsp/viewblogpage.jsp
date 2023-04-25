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
        <p style="text-align:right; font-size: x-small;"><a href="/home" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure; margin-right: 20px;">Back to Home</a><a href="/viewblogs" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure; margin-right: 20px;">Back to View Blogs</a><a href="/logout" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure;">Sign Out</a></p></span>
	</div>

    

    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 10px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;" id="blogHeading">${blogHeading}</h3>
                        <h6 class="panel-title" style="color: blue; text-align: right;" id="blogUsername">- ${blogUsername}</h6>
                    </div>
                    <div class="panel-body" id="blogBody" style="color: black;">
                        <hr style="height: 3px; border: none; color: rgb(19, 156, 205); background-color: rgb(19, 156, 205); margin-bottom: 40px;">
                        <!-- Blog Body ... -->
                        <div id="blogText">${blogText}</div>

                        <div class="panel-body my-5" id="blogFile">
                            <!-- Put extension here if present ... -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="floating-info-panel" id="result">Result here ...</div>

    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>

    <script>
        username = '${username}'
        role = '${role}'
        
        blogId = '${blogId}'
        blogUsername = '${blogUsername}'
        blogHeading = '${blogHeading}'
        blogText = `${blogText}`
        blogFile = '${blogFile}'

        resultPanel = document.getElementById('result')
        console.log('Username: ' + username)
        console.log('Role: ' + role)
        console.log('blogId: ' + blogId)
        console.log('blogUsername: ' + blogUsername)
        console.log('blogHeading: ' + blogHeading)
        console.log('blogText: ' + blogText)
        console.log('blogFile: ' + blogFile)

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

        if(blogUsername == username) showMessage('This is your blog ...')
        else showMessage('This is ' + blogUsername + '\'s blog ...')

        blogHeadingElement = document.getElementById('blogHeading')
        blogUsernameElement = document.getElementById('blogUsername')
        blogBodyElement = document.getElementById('blogBody')
        blogTextElement = document.getElementById('blogText')
        blogFileElement = document.getElementById('blogFile')
        flag = true

        const imgExtList = ['apng', 'gif', 'ico', 'cur', 'jpg', 'jpeg', 'jfif', 'pjpeg', 'pjp', 'png', 'svg']
        const videoExtList = ['mp4', 'webm']
        const audioExtList = ['mp3', 'wav']

        if(blogFile) {
            if(blogFile.includes('.')) extension = blogFile.split('.').pop()
            else extension = ''

            elemDiv = document.createElement('div')
            
            blogFileUrl = '/user_files/' + blogFile
            if(imgExtList.includes(extension)) elemDiv.innerHTML = '<img src="' + blogFileUrl + '" style="width:100%; max-width:600px;">'
            else if(videoExtList.includes(extension)) elemDiv.innerHTML = '<video src="' + blogFileUrl + '" controls style="width:100%; max-width:600px;">'
            else if(audioExtList.includes(extension)) elemDiv.innerHTML = '<audio src="' + blogFileUrl + '" controls style="width:100%; max-width:600px; min-width:300px;">'
            else elemDiv.innerHTML = '<a href="' + blogFileUrl + '" download><button class="btn-success" style="transition: 0.2s; float: right; padding-left: 10px; padding-right: 10px;">Download (' + ((extension)? extension: 'File (no extension)') + ')</button>'

            blogFileElement.appendChild(elemDiv)
        }

        deleteCurrentBlog = (deletingUser) => {
            flag = false

            blogHeadingElement.innerHTML = 'This blog has been deleted ...'
            showMessage('This blog has been deleted by ' + deletingUser)
            blogUsernameElement.innerHTML = ''
            blogBodyElement.innerHTML = ''
        }

        socket = new SockJS('/ws')
        stompClient = Stomp.over(socket)

        stompClient.connect({}, function (frame) {
            console.log('Connected: ', frame)

            stompClient.subscribe('/topic/blog_updated', (message) => {
                var blog = JSON.parse(message.body)
                console.log('Blog Update Received:', blog)

                if(blog.id != null && blog.id && blog.id != '-1' && blog.id == blogId && flag) { 
                    msg = 'Blog named "' + blogHeading + '" created by ' + blogUsername + ' has been updated'
                    if(blogHeading != blog.blogHeading) msg += ' to ' + blog.blogHeading + ' !!!'
                    else msg += ' !!!'
                    
                    blogHeadingElement.innerHTML = blog.blogHeading
                    blogTextElement.innerHTML = blog.blogText.replace(/\n/g, '<br>')

                    blogFile = blog.blogFile
                    if(blogFile) {
                        if(blogFile.includes('.')) extension = blogFile.split('.').pop()
                        else extension = ''

                        blogFileElement.innerHTML = ''
                        elemDiv = document.createElement('div')
                        
                        blogFileUrl = '/user_files/' + blogFile
                        if(imgExtList.includes(extension)) elemDiv.innerHTML = '<img src="' + blogFileUrl + '" style="width:100%; max-width:600px;">'
                        else if(videoExtList.includes(extension)) elemDiv.innerHTML = '<video src="' + blogFileUrl + '" controls style="width:100%; max-width:600px;">'
                        else if(audioExtList.includes(extension)) elemDiv.innerHTML = '<audio src="' + blogFileUrl + '" controls style="width:100%; max-width:600px; min-width:300px;">'
                        else elemDiv.innerHTML = '<a href="' + blogFileUrl + '" download><button class="btn-success" style="transition: 0.2s; float: right; padding-left: 10px; padding-right: 10px;">Download (' + ((extension)? extension: 'File (no extension)') + ')</button>'

                        blogFileElement.appendChild(elemDiv)
                    }

                    showMessage(msg)

                    setTimeout(() => {
                            if(blogFile) {
                            if(blogFile.includes('.')) extension = blogFile.split('.').pop()
                            else extension = ''

                            blogFileElement.innerHTML = ''
                            elemDiv = document.createElement('div')
                            
                            blogFileUrl = '/user_files/' + blogFile
                            if(imgExtList.includes(extension)) elemDiv.innerHTML = '<img src="' + blogFileUrl + '" style="width:100%; max-width:600px;">'
                            else if(videoExtList.includes(extension)) elemDiv.innerHTML = '<video src="' + blogFileUrl + '" controls style="width:100%; max-width:600px;">'
                            else if(audioExtList.includes(extension)) elemDiv.innerHTML = '<audio src="' + blogFileUrl + '" controls style="width:100%; max-width:600px; min-width:300px;">'
                            else elemDiv.innerHTML = '<a href="' + blogFileUrl + '" download><button class="btn-success" style="transition: 0.2s; float: right; padding-left: 10px; padding-right: 10px;">Download (' + ((extension)? extension: 'File (no extension)') + ')</button>'

                            blogFileElement.appendChild(elemDiv)
                        }
                    }, 5000)
                }
            })

            stompClient.subscribe('/topic/blog_deleted', (message) => {
                var blog = JSON.parse(message.body)
                console.log('Blog Delete Received:', blog)
                if(blog.id != null && blog.id && blog.id == blogId && flag) deleteCurrentBlog((blog.username == blogUsername)? 'its creator': 'admin')
            })

            // This page has been viewed ...
            stompClient.send('/app/view_blog', {}, JSON.stringify(blogId))
        })
    </script>
</body>
</html>