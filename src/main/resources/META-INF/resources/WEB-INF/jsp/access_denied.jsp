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
		<h3>Access Denied - Fly High Airlines</h3>
        <p style="text-align:right; font-size: x-small;"><a href="/home" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure; margin-right: 20px;">Back to Home</a><a href="/logout" class="logout" style="height: 20px; padding: 1mm; transition: 200ms; background-color: azure;">Sign Out</a></p></span>
	</div>

    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Your login credentials donot have required role to access this page</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Content for data panel -->
                        <div class="row" style="margin-bottom: 10px; text-align: center;">
                            Please logout and login again using credentials with correct role 
                            <a href="/logout"><button class="btn-outline-primary">Logout</button></a>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>