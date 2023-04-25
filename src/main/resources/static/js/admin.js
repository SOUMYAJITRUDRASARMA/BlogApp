socket = new SockJS('/ws')
stompClient = Stomp.over(socket)




blogListSuper = []
filterBlogName = ''
filterCreatorName = ''




blogNameElement = document.getElementById('blogName')
creatorNameElement = document.getElementById('creatorName')
blogListElement = document.getElementById('blogList')




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
    ans += '<h6 class="panel-title" style="color: blue; text-align: right;" id="blogUsername">- ' + blog.username + '</h6>'
    ans += '<hr>' + blog.blogText.split('\n').slice(0, 3).join('\n').substring(0, 50).trim().replace(/\n/g, "<br>")
    if(blog.blogFile){ 
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
    elemDiv.innerHTML = '<div class="small-border flight-item">' + getBlogStr(blog) + '<div class="text-right"> <a href="/viewblogs?id=' + blog.id + '" target="_blank"><button class="login btn btn-primary" style="transition: 200ms;">View</button></a> <button class="login btn btn-primary" style="transition: 200ms;" onclick="sendDeleteBlogRequest(\'' + blog.id + '\')">Delete</button></div></div>'
    blogListElement.appendChild(elemDiv)
}

redrawUpdatedBlogList = (blogList) => {
    blogListElement.innerHTML = ''
    if(blogList == null) return
    for(blog of blogList) addBlogToList(blog)
}




updateFilteredBlogList = () => {
    filteredBlogList = blogListSuper.filter(b => b.username.includes(filterCreatorName.trim()) && b.blogHeading.includes(filterBlogName.trim()))
    redrawUpdatedBlogList(filteredBlogList)
}

blogNameElement.addEventListener('input', (event) => {
    filterBlogName = event.target.value
    console.log('Blog Name Updated:', filterBlogName)

    updateFilteredBlogList()
})

creatorNameElement.addEventListener('input', (event) => {
    filterCreatorName = event.target.value
    console.log('Creator Name Updated:', filterCreatorName)

    updateFilteredBlogList()
})




sendDeleteBlogRequest = (id) => {
    if(confirm('Are you sure you want to delete this blog ?')) {
        stompClient.send('/app/delete_blog', {}, JSON.stringify({'username': username, 'id': id}))
    }
}

sendGiveAllBlogRequest = () => {
    stompClient.send('/app/give_all_blog/' + username, {}, null)
}




stompClient.connect({}, function (frame) {
    console.log('Connected: ', frame)

    stompClient.subscribe('/topic/blog_added', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog Add Received:', blog)
        blogListSuper.push(blog)

        if(blog.id != null && blog.id) {
            msg = 'Blog named "' + blog.blogHeading + '" created by ' + blog.username + ' has been addded !!!'
            if(blog.username.includes(filterCreatorName.trim()) && blog.blogHeading.includes(filterBlogName.trim())) addBlogToList(blog)
            else msg += '<br> It doesnot match with your current search parameters ...'
            showMessage(msg)
        }
    })

    stompClient.subscribe('/topic/blog_updated', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog Update Received:', blog)

        var prevHeading = '', updatedCreator = ''
        if(blog.id != null && blog.id && blog.id != '-1' && blogListSuper.some(b =>{ prevHeading = b.blogHeading; updatedCreator = b.username; if(b.id == blog.id){ b.blogHeading = blog.blogHeading; b.blogText = blog.blogText; b.blogFile = blog.blogFile; b.timesRead = blog.timesRead; } return b.id == blog.id })) { 
            msg = 'Blog named "' + prevHeading + '" created by ' + blog.username + ' has been updated'
            if(prevHeading != blog.blogHeading) msg += ' to ' + blog.blogHeading + ' !!!'
            else msg += ' !!!'
            if(updatedCreator.includes(filterCreatorName.trim()) && prevHeading.includes(filterBlogName.trim())) updateFilteredBlogList()
            else msg += '<br> It doesnot match with your current search parameters ...'
            showMessage(msg)
        }
    })

    stompClient.subscribe('/topic/blog_deleted', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog Delete Received:', blog)

        var removedHeading = '', removedCreator = ''
        if(blog.id != null && blog.id && blogListSuper.some(b =>{ removedHeading = b.blogHeading; removedCreator = b.username; return b.id == blog.id })) {
            console.log('Lol 1 -> Deletion reached ...')
            blogListSuper = blogListSuper.filter(b => b.id != blog.id)
            msg = 'Blog named "' + removedHeading + '" created by ' + removedCreator + ' has been removed by '
            if(blog.username == username) msg += 'you successfully'
            else if(blog.username == removedCreator) msg += 'its creator'
            else msg += 'another admin'
            msg += ' !!!'
            if(removedCreator.includes(filterCreatorName.trim()) && removedHeading.includes(filterBlogName.trim())) updateFilteredBlogList()
            else msg += '<br> It doesnot match with your current search parameters ...'
            showMessage(msg)
        }
    })

    stompClient.subscribe('/topic/blog_viewed', (message) => {
        var blog = JSON.parse(message.body)
        console.log('Blog View Received:', blog)

        var updatedHeading = '', updatedCreator = ''
        if(blog.id != null && blog.id && blogListSuper.some(b =>{ updatedHeading = b.blogHeading; updatedCreator = b.username; if(b.id == blog.id) b.timesRead++; return b.id == blog.id })) {
            if(updatedCreator.includes(filterCreatorName.trim()) && updatedHeading.includes(filterBlogName.trim())) updateFilteredBlogList()
        }
    })

    stompClient.subscribe('/topic/get_all_blog/' + username, (message) => {
        var blogList = JSON.parse(message.body)
        blogListSuper = blogList
        console.log('Received All Blogs: ', blogListSuper)
        redrawUpdatedBlogList(blogListSuper)
    })

    sendGiveAllBlogRequest()
})