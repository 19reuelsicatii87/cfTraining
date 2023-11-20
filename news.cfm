<!---Get news years--->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<title>
			HD Street Concert Band - News
		</title>
		<link href="/cfTraining/styles/hdStreet.css" rel="stylesheet" type="text/css" media="screen"/>
		<script type="text/javascript" src="/cfTraining/script/jquery.js">

		</script>
		<script type="text/javascript" src="/cfTraining/script/menu.js">

		</script>
	</head>
	
	<body>
		<div id="wrapper">
			<div id="header">
				<a href="#"><img src="/cfTraining/images/logo.png" alt="logo" name="logo" width="188" height="181" id="logo" /></a>
				<p id="mainTitle">
					<img src="/cfTraining/images/mainTitle.png" width="398" height="158" 
					     alt="HD Street Concert Band"/>
					<span>
						HD Street Concert Band
					</span>
				</p>
				<ul>
					<li>
						<a href="siteMap.html">
							Site Map
						</a>
					</li>
					<li>
						<a href="contactUs.html">
							Contact us
						</a>
					</li>
				</ul>
			</div>
			<div id="menu">
				<ul>
					<li>
						<a href="index.html">
							Home
						</a>
					</li>
					<li>
						<a href="agenda.html">
							Agenda
						</a>
					</li>
					<li>
						<a href="#">The Band</a>
						<ul>
							<li>
								<a href="director.html">
									The director
								</a>
							</li>
							<li>
								<a href="history.html">
									The band History
								</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="wePlayForYou.html">
							We play for You
						</a>
					</li>
					<li>
						<a href="comePlayWithUs.html">
							Come play with us
						</a>
					</li>
					<li>
						<a href="news.html">
							News
						</a>
					</li>
				</ul>
			</div>
			<div id="pageBody">

				
				<cfif isDefined('url.newsID')>
				<cfquery datasource="hdStreet" name="rs_singleNews">
					SELECT FLD_NEWSID, FLD_NEWSCREATIONDATE, FLD_NEWSTITLE, FLD_NEWSCONTENT, FLD_USERFIRSTNAME, FLD_USERLASTNAME
					FROM TBL_NEWS
					INNER JOIN TBL_USERS
					ON FLD_NEWSAUTHOR = FLD_USERID
					WHERE FLD_NEWSID = #url.newsID#
				</cfquery>			
				<cfoutput query="rs_singleNews">
					<div id="calendarContent">
					<h1> Happy new year</h1>
					<p class="metadata">Published on #dateFormat(FLD_NEWSCREATIONDATE, 'mmm dd yyyy')# by #FLD_USERFIRSTNAME# #FLD_USERLASTNAME#</p>
					#FLD_NEWSCONTENT#
					</div>
				</cfoutput>
				
				
					
				<cfelseif isDefined('url.year')>
				<cfquery datasource="hdStreet" name="rs_yearNews">
					SELECT FLD_NEWSID, FLD_NEWSCREATIONDATE, FLD_NEWSTITLE
					FROM TBL_NEWS
					WHERE YEAR(FLD_NEWSCREATIONDATE) = #url.year#
				</cfquery>
				
				<div id="calendarContent">
					<h1>
						News
					</h1>
					<p>
						&nbsp;
					</p>
					<table>
                    	<caption>
                    		Latest news
                    	</caption>						
						
						<!--- Adding query attribute loops through all the records of the resultset--->
						<!--- This is for the dd suffix--->
						<cfset DateSuffix=["st", "nd", "rd", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", 
						"th", "th", "th", "th", "th", "th", "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th", "th", "st"]>
						<cfoutput query="rs_yearNews">							
                   			<tr>
            	                <th>                                            	
                                	#DateFormat(FLD_NEWSCREATIONDATE,'yyyy')# 
                                	#DateFormat(FLD_NEWSCREATIONDATE,'mmm')#                                            	 
                                	#DateFormat(FLD_NEWSCREATIONDATE,'d')##DateSuffix[DateFormat(FLD_NEWSCREATIONDATE,'d')]#
                                	  
            	                </th>
            	                <td>
                                	#FLD_NEWSTITLE#
            	                </td>
            	                <td>
            	                    <a href="news.cfm?newsID=#FLD_NEWSID#">
            	                        Read More
            	                    </a>
            	                </td>
            	            </tr>   				
						</cfoutput>						
					</table>
					<p>
						&nbsp;
					</p>
				</div>
				
				<cfelse>
				<!---Chapter 4.1 - Static vs Dynamic Query--->			
				<!--- This is a Dynamic Content - Static Query--->
				<cfquery datasource="hdStreet" name="rs_NewsAll">
					SELECT FLD_NEWSID, FLD_NEWSCREATIONDATE, FLD_NEWSTITLE
					FROM TBL_NEWS
				</cfquery>
				
				<div id="calendarContent">
					<h1>
						News
					</h1>
					<p>
						&nbsp;
					</p>
					<table>
                    	<caption>
                    		Latest news
                    	</caption>						
						
						<!--- Adding query attribute loops through all the records of the resultset--->
						<!--- This is for the dd suffix--->
						<cfset DateSuffix=["st", "nd", "rd", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", "th", 
						"th", "th", "th", "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th", "th", "st"]>
						<cfoutput query="rs_NewsAll">							
                   			<tr>
            	                <th>                                            	
                                	#DateFormat(FLD_NEWSCREATIONDATE,'yyyy')# 
                                	#DateFormat(FLD_NEWSCREATIONDATE,'mmm')#                                            	 
                                	#DateFormat(FLD_NEWSCREATIONDATE,'d')##DateSuffix[DateFormat(rs_NewsAll.FLD_NEWSCREATIONDATE,'d')]#
                                	  
            	                </th>
            	                <td>
                                	#FLD_NEWSTITLE#
            	                </td>
            	                <td>
            	                    <a href="news.cfm?newsID=#FLD_NEWSID#">
            	                        Read More
            	                    </a>
            	                </td>
            	            </tr>   				
						</cfoutput>						
					</table>
					<p>
						&nbsp;
					</p>
				</div>
		
				</cfif>
				
				
				<!--- This is a Dynamic Content - Static Query--->		
				<cfquery datasource="hdStreet" name="rs_NewsAllYearOnly">
					SELECT YEAR(FLD_NEWSCREATIONDATE) as FLD_NEWSCREATIONYEAR
					FROM TBL_NEWS
				</cfquery>	
				<div id="calendarSideBar">					
					<h1> NonGroup News archive </h1>		
					<ul>
						<!--- Adding query attribute loops through all the records of the resultset--->
						<cfoutput query="rs_NewsAllYearOnly" >
							<li>
								<a href="news.cfm?year=#FLD_NEWSCREATIONYEAR#">#FLD_NEWSCREATIONYEAR#</a>
							</li>	
						</cfoutput>
					</ul>					
                	<p class="alignRight"> &nbsp; </p>							
				</div>
				
				<div id="calendarSideBar">
					<h1> Group News archive </h1>	
					<ul>
						<!--- Adding query attribute loops through all the records of the resultset--->
						<!--- Adding group attribute group through all the records of the resultset--->
						<cfoutput query="rs_NewsAllYearOnly" group="FLD_NEWSCREATIONYEAR">							
							<li>
								<a href="news.cfm?year=#FLD_NEWSCREATIONYEAR#">#FLD_NEWSCREATIONYEAR#</a>
							</li>	
						</cfoutput>
					</ul>						
				</div>	
							
			</div>
			<div id="footer">
				<p>
					&copy; Copyright 2011 - HD Street Concert Band
				</p>
			</div>
		</div>
	</body>
</html>