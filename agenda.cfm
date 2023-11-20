<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8"/>
		<title>
			HD Street Concert Band - Agenda
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
			
				<!---Chapter 4.1 - Static vs Dynamic Query--->
				<cfset var_dynamicDate = CreateODBCDateTime(CreateDateTime(2016, 01, 01, 00, 00, 00))>
				<cfquery datasource="hdStreet" name="rs_allEvents" result="rs_allEvents_recordCount">
					SELECT FLD_EVENTID, FLD_EVENTDATETIME, FLD_EVENTNAME, FLD_EVENTVENUE, FLD_EVENTDESCRIPTION
					FROM TBL_EVENTS
					WHERE FLD_EVENTDATETIME >= <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#var_dynamicDate#">
				</cfquery>
			
				<!---Chapter 5.1 - Main vs Details Page --->
				<!--- If queryString is defined then return/render detail page --->
				<cfif isDefined('url.agendaID')>
					<cfquery datasource="hdStreet" name="rs_singleEvents">
						SELECT FLD_EVENTID, FLD_EVENTDATETIME, FLD_EVENTNAME, FLD_EVENTVENUE, FLD_EVENTDESCRIPTION
						FROM TBL_EVENTS
						WHERE FLD_EVENTID = #url.agendaID#
					</cfquery>
					<cfoutput>
						<div id="calendarContent">
							<h1>
								#rs_singleEvents.FLD_EVENTNAME#
							</h1>
							#rs_singleEvents.FLD_EVENTDESCRIPTION#
						</div>
					</cfoutput>
					<!--- Else return/render main page --->
				<cfelse>
				
					<div id="calendarContent">
						<h1>
							Agenda
						</h1>
						
						<!---<cfdump var="#rs_allEvents_recordCount#" label="Static Query - Record Count">--->
						<!---<cfdump var="#rs_allEvents#" label="Static Query">--->
						<p>
							&nbsp;
						</p>
						
						<cfif rs_allEvents.RecordCount EQ 0>
							<p>
								Sorry, there are no events to display at the moment!
							</p>
						<cfelse>
						
							<table>
								<caption>
									upcoming events
								</caption>
								<cfoutput query="rs_allEvents">
								
									<tr>
										<th>
											#dateFormat(rs_allEvents.FLD_EVENTDATETIME, 'mmm dd yyyy')#
											-
											#TimeFormat(rs_allEvents.FLD_EVENTDATETIME, 'h:mm tt')#
										</th>
										<td>
											#rs_allEvents.FLD_EVENTNAME#
											<br>
											#rs_allEvents.FLD_EVENTVENUE#
										</td>
										<td>
											<a href="agenda.cfm?agendaID=#FLD_EVENTID#">
												Read More
											</a>
										</td>
									</tr>
									
								</cfoutput>
							</table>
						</cfif>
						<p>
							&nbsp;
						</p>
						<!---Chapter 4 - To HERE--->
					</div>
				</cfif>
				<!--- This would only output the first record of the query since query attribute is NOT used in 
				cfoutput --->
				<div id="calendarSideBar">
					<h1>
						Next Event
					</h1>
					<cfif rs_allEvents.RecordCount EQ 0>
						<p>
							Sorry, there are no events to display at the moment!
						</p>
					<cfelse>
						<cfoutput>
						
							<div id="EventDetails">
								<p id="eventDate">
									<span id="month">
										#dateFormat(rs_allEvents.FLD_EVENTDATETIME, 'mmm')#
									</span>
									<span id="days">
										#dateFormat(rs_allEvents.FLD_EVENTDATETIME, 'dd')#
									</span>
								</p>
								<h2>
									#rs_allEvents.FLD_EVENTNAME#
								</h2>
							</div>
							<p>
								#rs_allEvents.FLD_EVENTDESCRIPTION#
							</p>
							<p class="alignRight">
								<a href="events/20110719.html">
									Read More
								</a>
							</p>
						</cfoutput>
					</cfif>
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