<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta charset='UTF-8'/>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0' />
    <title>Responsive Design</title>
   <style>
   	* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

.page {
  display: flex;
  flex-wrap: wrap;
}

.section {
  width: 100%;
  height: 300px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.menu {
  background-color: #5995DA;
  height: 80px;
}

.header {
  background-color: #B2D6FF;
}

.content {
  background-color: #EAEDF0;
  height: 600px;
}

.sign-up {
  background-color: #D6E9FE;
}

.feature-1 {
  background-color: #F5CF8E;
}

.feature-2 {
  background-color: #F09A9D;
}

.feature-3 {
  background-color: #C8C6FA;
}

/* Mobile Styles */
@media only screen and (max-width: 400px) {
  body {
    background-color: #F09A9D; /* Red */
  }
}

/* Tablet Styles */
@media only screen and (min-width: 401px) and (max-width: 960px) {
  .sign-up,
  .feature-1,
  .feature-2,
  .feature-3 {
    width: 50%;
  }
}



/* Desktop Styles */
@media screen and (max-width: 991px) {
.page {
    width: 990px;
    margin: 0 auto;
  }
  .feature-1,
  .feature-2,
  .feature-3 {
    width: 33.3%;
  }
  .header {
    height: 400px;
  }
}

   </style>
  </head>
  <body>
    <div class='page'>
	  <div class='section menu'></div>
	  <div class='section header'>
	    <img src='ordertracker/images/header.svg'/>
	    Header
	  </div>
	  <div class='section content'>
	    <img src='ordertracker/images/content.svg'/>
	    Content
	  </div>
	  <div class='section sign-up'>
	    <img src='ordertracker/images/sign-up.svg'/>
	    Sign-up
	  </div>
	  <div class='section feature-1'>
	    <img src='ordertracker/images/feature.svg'/>
	    Feature
	  </div>
	  <div class='section feature-2'>
	    <img src='ordertracker/images/feature.svg'/>
	    Feature
	  </div>
	  <div class='section feature-3'>
	    <img src='ordertracker/images/feature.svg'/>
	    Feature
	  </div>
	</div>

  </body>
</html>
