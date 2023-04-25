socket = new SockJS('/ws')
stompClient = Stomp.over(socket)




blogListSuper = []
curUpdatingBlogId = null




blogHeadingElement = document.getElementById('blogHeading')
blogTextElement = document.getElementById('blogText')
blogFileElement = document.getElementById('blogFile')
blogFileDescriptionElement = document.getElementById('blogFileDescription')
blogHeadingUpdateElement = document.getElementById('blogHeadingUpdate')
blogTextUpdateElement = document.getElementById('blogTextUpdate')
blogFileUpdateElement = document.getElementById('blogFileUpdate')
blogFileDescriptionUpdateElement = document.getElementById('blogFileDescriptionUpdate')
blogListElement = document.getElementById('blogList')
windowUpdateElement = document.getElementById('windowUpdate')

autosize(blogTextElement)
blogFileElement.addEventListener("change", () =>{
    console.log('New File Added ->')
    console.log(blogFileElement.files[0])
    console.log('Value:', blogFileElement.value)

    if(blogFileElement.files[0] == null) blogFileDescriptionElement.innerHTML = 'No File Selected ...'
    else blogFileDescriptionElement.innerHTML = blogFileElement.files[0].name
})
blogFileUpdateElement.addEventListener("change", () =>{
    console.log('New File Added (Update) ->')
    console.log(blogFileUpdateElement.files[0])
    console.log('Value (Update):', blogFileUpdateElement.value)

    if(blogFileUpdateElement.files[0] == null) blogFileDescriptionUpdateElement.innerHTML = 'Select new file to replace (dont to keep the previous one) ...'
    else blogFileDescriptionUpdateElement.innerHTML = blogFileUpdateElement.files[0].name
})




getBlogSize = (blog) => {
    blogText = blog.blogText
    numChar = blogText.length
    numWord = blogText.split(/\s+/).filter(e => e.trim()).length
    numSent = blogText.split(/[.?!\n]+/).filter(e => e.trim()).length
    numPara = blogText.split(/\n\n/).filter(e => e.trim()).length

    return numChar + ' Characters  |  ' + numWord + ' Words  |  ' + numSent + ' Sentences  |  ' + numPara + ' Paragraphs ...'
}

function formatTime(s) {
    var years = Math.floor(s / (60 * 60 * 24 * 365));
    s -= years * (60 * 60 * 24 * 365);
    var days = Math.floor(s / (60 * 60 * 24));
    s -= days * (60 * 60 * 24);
    var hours = Math.floor(s / (60 * 60));
    s -= hours * (60 * 60);
    var minutes = Math.floor(s / 60);
    s -= minutes * 60;
    var seconds = Math.floor(s);
  
    var result = '';
    if (years > 0) {
        result += years + ' year' + (years > 1 ? 's' : '') + ' ';
    }
    if (days > 0) {
        result += days + ' day' + (days > 1 ? 's' : '') + ' ';
    }
    if (hours > 0) {
        result += hours + ' hour' + (hours > 1 ? 's' : '') + ' ';
    }
    if (minutes > 0) {
        result += minutes + ' minute' + (minutes > 1 ? 's' : '') + ' ';
    }
    if (seconds > 0) {
        result += seconds + ' second' + (seconds > 1 ? 's' : '') + ' ';
    }

    result = result.trim()
    return (result)? result: 'Quick GG :)';
}

getAvgTimeToRead = (blog) => {
    blogText = blog.blogText
    numChar = blogText.length
    // Avg speed is = 1500 char / min = 25 char / sec
    timeSeconds = Math.floor(numChar / 25)
    return formatTime(timeSeconds) 
}

getBlogStr = (blog) => {
    ans = '<h3 class="panel-title" style="color: blue; text-align: center;" id="blogHeading">' + blog.blogHeading + '</h3>'
    ans += '<hr>' + blog.blogText.split('\n').slice(0, 3).join('\n').substring(0, 50).trim().replace(/\n/g, "<br>")
    if(blog.blogFile) { 
        if(blog.blogFile.includes('.')) extension = blog.blogFile.split('.').pop()
        else extension = ''
        ans += '<hr>' + 'File Attached: ' + ((extension)? (extension + ' file'): 'Binary File (no extension)') + ' <a href="/user_files/' + blog.blogFile + '" target="_blank">See here</a>'
    }
    stats = 'Size of Blog = ' + getBlogSize(blog)
    stats += '<br>Average Time to Read = ' + getAvgTimeToRead(blog)
    stats += '<br>#Times Read = ' + blog.timesRead
    ans += '<hr>' + stats
    // ans += '<hr> Give stats here ...'
    return ans
}

addBlogToList = (blog) => {
    elemDiv = document.createElement('div')
    elemDiv.innerHTML = '<div class="small-border flight-item">' + getBlogStr(blog) + '<div class="text-right"> <button class="login btn btn-primary" style="transition: 200ms;" onClick="showUpdatePage(\'' + blog.id + '\')">Update</button>       <a href="/viewblogs?id=' + blog.id + '" target="_blank"><button class="login btn btn-primary" style="transition: 200ms;">View</button></a> <button class="login btn btn-primary" style="transition: 200ms;" onclick="sendDeleteBlogRequest(\'' + blog.id + '\')">Delete</button></div></div>'
    blogListElement.appendChild(elemDiv)
}

redrawUpdatedBlogList = (blogList) => {
    blogListElement.innerHTML = ''
    if(blogList == null) return
    for(blog of blogList) addBlogToList(blog)
}

clearBlogForm = () => {
    blogHeadingElement.value = ''
    blogTextElement.value = ''
    blogFileElement.value = ''
    blogFileDescriptionElement.innerHTML = 'No File Selected ...'
}

showUpdatePage = (id) => {
    foundBlog = blogListSuper.find(b => b.id == id)
    if(foundBlog == null){ showMessage('ID = ' + id + ' -> Blog not found in super list !!!'); return }
    
    curUpdatingBlogId = id
    blogHeadingUpdateElement.value = foundBlog.blogHeading
    blogTextUpdateElement.value = foundBlog.blogText
    blogFileUpdateElement.value = ''
    blogFileDescriptionUpdateElement.innerHTML = 'Select new file to replace (dont to keep the previous one) ...'
    windowUpdateElement.style.display = 'block'
    windowUpdateElement.scrollIntoView({behavior: "smooth"})
}

closeUpdatePage = () => {
    curUpdatingBlogId = null
    windowUpdate.style.display = 'none'
}

clearBlogForm()




sendAddBlogRequest = (blog) => {
    stompClient.send('/app/add_blog', {}, JSON.stringify(blog))
}

sendUpdateBlogRequest = (blog) => {
    stompClient.send('/app/update_blog', {}, JSON.stringify(blog))
}

sendDeleteBlogRequest = (id) => {
    if(confirm('Are you sure you want to delete this blog ?')) {
        stompClient.send('/app/delete_blog', {}, JSON.stringify({'username': username, 'id': id}))
    }
}

sendGiveAllCreatorBlogRequest = () => {
    stompClient.send('/app/give_all_creator_blog/' + username, {}, null)
}




sendAddBlogRequestButtonListener = () => {
    blogHeading = blogHeadingElement.value.trim()
    blogText = blogTextElement.value.trim()

    if(!blogHeading){ alert('Cannot add blog with no heading'); return  }
    else if(!blogText){ alert('Cannot add blog with no content'); return  }

    sendAddBlogRequestButtonListenerContinue = (username, blogHeading, blogText, blogFileContentsActual, fileName) => {
        blog = {
            'username': username, 
            'blogHeading': blogHeading, 
            'blogText': blogText, 
            'blogFileContents': Array.from(blogFileContentsActual), 
            'fileName': fileName, 
        }
        console.log('Before Sending Blog Add Request , blogFileContents --> ', blog.blogFileContents)
        console.log('Sending Blog Add Request --> ', blog)
        sendAddBlogRequest(blog)
    }

    fileName = blogFileElement.value
    console.log('Lol -> ' + fileName)
    if(fileName != null && fileName) { 
        var reader = new FileReader();
        reader.onload = () => {
            blogFileContents = new Uint8Array(reader.result)
            console.log('Result of File Reader -> ', reader.result);
            console.log('Blog File Contents -> ', blogFileContents);
            sendAddBlogRequestButtonListenerContinue(username, blogHeading, blogText, blogFileContents, fileName)
        }
        console.log('File Reader reading from -> ', blogFileElement.files[0])
        reader.readAsArrayBuffer(blogFileElement.files[0])
    }
    else{ blogFileContents = []; sendAddBlogRequestButtonListenerContinue(username, blogHeading, blogText, blogFileContents, fileName) }
}

sendUpdateBlogRequestButtonListener = () => {
    if(curUpdatingBlogId == null){ showMessage('curUpdatingBlogId is null ???'); closeUpdatePage() }

    blogHeading = blogHeadingUpdateElement.value.trim()
    blogText = blogTextUpdateElement.value.trim()

    if(!blogHeading){ alert('Cannot update blog with no heading'); return  }
    else if(!blogText){ alert('Cannot update blog with no content'); return  }

    sendUpdateBlogRequestButtonListenerContinue = (username, blogHeading, blogText, blogFileContentsActual, fileName) => {
        blog = {
            'id': curUpdatingBlogId, 
            'username': username, 
            'blogHeading': blogHeading, 
            'blogText': blogText, 
            'blogFileContents': Array.from(blogFileContentsActual), 
            'fileName': fileName, 
        }
        console.log('Before Sending Blog Update Request , blogFileContents --> ', blog.blogFileContents)
        console.log('Sending Blog Update Request --> ', blog)
        sendUpdateBlogRequest(blog)
        closeUpdatePage()
    }

    fileName = blogFileUpdateElement.value
    console.log('Lol -> ' + fileName)
    if(fileName != null && fileName) { 
        var reader = new FileReader();
        reader.onload = () => {
            blogFileContents = new Uint8Array(reader.result)
            console.log('Result of File Reader -> ', reader.result);
            console.log('Blog File Contents -> ', blogFileContents);
            sendUpdateBlogRequestButtonListenerContinue(username, blogHeading, blogText, blogFileContents, fileName)
        }
        console.log('File Reader reading from -> ', blogFileUpdateElement.files[0])
        reader.readAsArrayBuffer(blogFileUpdateElement.files[0])
    }
    else{ blogFileContents = []; sendUpdateBlogRequestButtonListenerContinue(username, blogHeading, blogText, blogFileContents, fileName) }
}




stompClient.connect({}, function (frame) {
    console.log('Connected: ', frame)

    stompClient.subscribe('/topic/blog_added', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog Add Received:', blog)

        if(blog.id == null) {
            if(blog.username == username) showMessage('Blog of yours with heading = ' + blog.blogHeading + ' already exists !!!<br>Blog not added !!!')
        }
        else if(!blog.id) {
            if(blog.username == username) showMessage('Some error occured in uploading !!!<br>Blog not added !!!')
        }
        else if(blog.username == username){ clearBlogForm(); blogListSuper.push(blog); addBlogToList(blog); showMessage('Blog successfully addded !!!') }
    })

    stompClient.subscribe('/topic/blog_updated', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog Update Received:', blog)

        if(blog.id == null) {
            if(blog.username == username) showMessage('Blog with such id not found to update !!!')
        }
        else if(!blog.id) {
            if(blog.username == username) showMessage('Some error occured in uploading !!!<br>Blog not updated !!!')
        }
        else if(blog.id == '-1') {
            if(blog.username == username) showMessage('Blog of yours with heading = ' + blog.blogHeading + ' already exists !!!<br>Blog not updated !!!')
        }
        else if(blog.username == username){ 
            clearBlogForm(); 
            blogListSuper.some(b => { 
                if(b.id == blog.id) {
                    b.blogHeading = blog.blogHeading
                    b.blogText = blog.blogText
                    b.blogFile = blog.blogFile
                    b.timesRead = blog.timesRead
                }
                return b.id == blog.id 
            })
            redrawUpdatedBlogList(blogListSuper)
            showMessage('Blog successfully updated !!!') 
        }
    })

    stompClient.subscribe('/topic/blog_deleted', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog Delete Received:', blog)

        var removedHeading = ''
        if(blog.id != null && blog.id && blogListSuper.some(b =>{ removedHeading = b.blogHeading; return b.id == blog.id })) {
            blogListSuper = blogListSuper.filter(b => b.id != blog.id)
            redrawUpdatedBlogList(blogListSuper)
            if(blog.username == username) showMessage('Blog (named ' + removedHeading + ') successfully removed !!!') 
            else showMessage('Blog (named ' + removedHeading + ') removed by admin !!!') 
        }
    })

    stompClient.subscribe('/topic/blog_viewed', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog View Received:', blog)

        var updatedHeading = ''
        if(blog.id != null && blog.id && blogListSuper.some(b =>{ updatedHeading = b.blogHeading; if(b.id == blog.id) b.timesRead++; return b.id == blog.id })) {
            redrawUpdatedBlogList(blogListSuper)
            showMessage('Your blog (named ' + updatedHeading + ') has been read &#128516; !!!') 
        }
    })

    stompClient.subscribe('/topic/get_all_creator_blog/' + username, (message) => {
        var blogList = JSON.parse(message.body)
        blogListSuper = blogList
        console.log('Received All Blogs: ', blogListSuper)
        redrawUpdatedBlogList(blogListSuper)
    })

    sendGiveAllCreatorBlogRequest()
})