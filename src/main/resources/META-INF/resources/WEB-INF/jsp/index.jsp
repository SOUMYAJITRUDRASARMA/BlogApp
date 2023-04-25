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
	<div class="page-header text-center bg-primary p-4 text-white" style="margin: 0; padding-right: 20px; padding-bottom: 0.005mm; height: fit-content;">
		<h3>Welcome to Blog On !!!</h3>
        <h6>Your One and Only Blog Platform</h6>
	</div>

    <div class="container" style="margin-top: 90px;">
        <div class="row">
            <div class="col-md-12" style="padding-bottom: 70px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Want to view some blogs ?</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Content for left panel -->
                        <div class="row" style="margin-bottom: 40px;">
                            <div class="col-6 text-left font-weight-bold">
                                Click here to view interesting blogs &rarr;
                            </div>
                            <div class="col-6 text-right">
                                <a href="/viewblogs"><button type="button" class="btn btn-primary">View Blogs</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6" style="padding-right: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Are you a creator ?</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Content for left panel -->
                        <div class="row" style="margin-bottom: 40px;">
                            <div class="col-6 text-left font-weight-bold">
                                Click here to log in &rarr;
                            </div>
                            <div class="col-6 text-right">
                                <a href="/login"><button type="button" class="btn btn-primary">Log In</button></a>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6 text-left font-weight-bold">
                                Don't have an account ?
                            </div>
                            <div class="col-6 text-right">
                                <a href="/creator/signup"><button type="button" class="btn btn-primary">Sign Up</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-6" style="padding-left: 40px;">
                <div class="panel panel-default small-border">
                    <div class="panel-heading" style="margin-bottom: 50px;">
                        <h3 class="panel-title" style="color: blue; text-align: center;">Are you an admin ?</h3>
                    </div>
                    <div class="panel-body">
                        <!-- Content for right panel -->
                        <div class="row" style="margin-bottom: 40px;">
                            <div class="col-6 text-left font-weight-bold">
                                Click here to log in &rarr;
                            </div>
                            <div class="col-6 text-right">
                                <a href="/login"><button type="button" class="btn btn-primary">Log In</button></a>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-6 text-left font-weight-bold">
                                Don't have an account ?
                            </div>
                            <div class="col-6 text-right">
                               <a href="/admin/signup"> <button type="button" class="btn btn-primary">Sign Up</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      </div>

    <!-- <script src="../static/script.js"></script> -->
</body>
</html>