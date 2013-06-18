<%@ page import="teammates.common.Common"%>
<%@ page import="teammates.common.FieldValidator"%>
<%@ page import="teammates.common.datatransfer.EvaluationDetailsBundle"%>
<%@ page import="teammates.common.datatransfer.FeedbackSessionDetailsBundle"%>
<%@ page import="teammates.ui.controller.InstructorFeedbackPageData"%>
<%
InstructorFeedbackPageData data = (InstructorFeedbackPageData)request.getAttribute("data");
%>
<!DOCTYPE html>
<html>
<head>
	<link rel="shortcut icon" href="/favicon.png">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teammates - Instructor</title>
	<link rel="stylesheet" href="/stylesheets/common.css" type="text/css" media="screen">
	<link rel="stylesheet" href="/stylesheets/instructorFeedback.css" type="text/css" media="screen">
	<link rel="stylesheet" href="/stylesheets/common-print.css" type="text/css" media="print">
    <link rel="stylesheet" href="/stylesheets/instructorEval-print.css" type="text/css" media="print">
	
	<script type="text/javascript" src="/js/googleAnalytics.js"></script>
	<script type="text/javascript" src="/js/jquery-minified.js"></script>
	<script type="text/javascript" src="/js/tooltip.js"></script>
	<script type="text/javascript" src="/js/date.js"></script>
	<script type="text/javascript" src="/js/CalendarPopup.js"></script>
	<script type="text/javascript" src="/js/AnchorPosition.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
	<script type="text/javascript" src="/js/instructor.js"></script>
	<script type="text/javascript" src="/js/instructorFeedback.js"></script>
	<%
		if(data.newFeedbackSession==null){
	%>
	<script type="text/javascript">
		var doPageSpecificOnload = selectDefaultTimeOptions;
	</script>
	<%
		}
	%>
    <jsp:include page="../enableJS.jsp"></jsp:include>
</head>

<body>
	<div id="dhtmltooltip"></div>
	<div id="frameTop">
		<jsp:include page="<%=Common.JSP_INSTRUCTOR_HEADER_NEW%>" />
	</div>

	<div id="frameBody">
		<div id="frameBodyWrapper">
			<div id="topOfPage"></div>
			<div id="headerOperation">
				<h1>Add New Feedback Session</h1>
			</div>
			
			<form method="post" action="<%=Common.PAGE_INSTRUCTOR_FEEDBACK_CHANGE_TYPE%>" name="form_changesessiontype">
			<p class="bold centeralign middlealign">Session Type&nbsp;&nbsp;
			<select style="width:730px" name="<%=Common.PAGE_INSTRUCTOR_FEEDBACK_CHANGE_TYPE%>"
									id="<%=Common.PAGE_INSTRUCTOR_FEEDBACK_CHANGE_TYPE%>"
									onmouseover="ddrivetip('Change session type')"
									onmouseout="hideddrivetip()" tabindex="0" 
									onclick="submit">
									<option value="STANDARD" selected="selected">Standard Feedback Session</option>
									<option value="TEAM">Team Feedback Session</option>
									<option value="PRIVATE">Private Feedback Session</option>
									<option value="EVALUATION">Peer Evaluation Session</option>			
			</select></p>
			<script type="text/javascript">
			//<![CDATA[ 
			$(document).ready(function(){
			    $('select').change(function ()
			    {
			        $(this).closest('form[name="form_changesessiontype"]').submit();
			    });
			});//]]>  
			</script>
			</form>
			<br><br>
			<form method="post" action="<%=Common.PAGE_INSTRUCTOR_FEEDBACK_ADD%>" name="form_addfeedbacksession">
				<table class="inputTable sessionTable" id="sessionNameTable">
					<tr>
						<td class="label bold" >Course:</td>
						<td><select name="<%=Common.PARAM_COURSE_ID%>"
									id="<%=Common.PARAM_COURSE_ID%>"
									onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_COURSE%>')"
									onmouseout="hideddrivetip()" tabindex="1">
										<%
											for(String opt: data.getCourseIdOptions()) out.println(opt);
										%>
							</select></td>
						<td class="label bold" >Time zone:</td>
						<td><select name="<%=Common.PARAM_FEEDBACK_SESSION_TIMEZONE%>" id="<%=Common.PARAM_FEEDBACK_SESSION_TIMEZONE%>"
									onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_EVALUATION_INPUT_TIMEZONE%>')"
									onmouseout="hideddrivetip()" tabindex="3">
										<%
											for(String opt: data.getTimeZoneOptions()) out.println(opt);
										%>
							</select></td>
					</tr>
					<tr>
						<td class="label bold" >Feedback session name:</td>
						<td colspan="3"><input  type="text"
									name="<%=Common.PARAM_FEEDBACK_SESSION_NAME%>" id="<%=Common.PARAM_FEEDBACK_SESSION_NAME%>"
									onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_INPUT_NAME%>')"
									onmouseout="hideddrivetip()" maxlength =<%=FieldValidator.FEEDBACK_SESSION_NAME_MAX_LENGTH%>
									value="<%if(data.newFeedbackSession!=null) out.print(InstructorFeedbackPageData.escapeForHTML(data.newFeedbackSession.feedbackSessionName));%>"
									tabindex="2" placeholder="e.g. Class presentation feedback session"></td>
					</tr>
				</table>
				<br>
				<table class="inputTable sessionTable" id="sessionViewableTable">
					<tr>
						<td class="label bold">Session visible from:</td>
						<td><input type="radio" name="<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>_custom" value="custom"
							<%if(data.newFeedbackSession!=null &&
									 data.newFeedbackSession.sessionVisibleFromTime.equals(Common.TIME_REPRESENTS_FOLLOW_OPENING) == false &&
									 data.newFeedbackSession.sessionVisibleFromTime.equals(Common.TIME_REPRESENTS_LATER) == false)  
									out.print("checked=\"checked\"");%>
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_SESSIONVISIBLECUSTOM%>')"
							onmouseout="hideddrivetip()"
							onclick="document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_VISIBLEDATE%>').disabled='';
							document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_VISIBLETIME%>').disabled=''">
							<input style="width: 100px;" type="text"
							name="<%=Common.PARAM_FEEDBACK_SESSION_VISIBLEDATE%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_VISIBLEDATE%>"
							onclick="cal.select(this,'<%=Common.PARAM_FEEDBACK_SESSION_VISIBLEDATE%>','dd/MM/yyyy')"
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_VISIBLEDATE%>')"
							onmouseout="hideddrivetip()"
							value="<%=((data.newFeedbackSession==null || Common.isSpecialTime(data.newFeedbackSession.sessionVisibleFromTime)) ? "" : Common.formatDate(data.newFeedbackSession.sessionVisibleFromTime))%>"
							readonly="readonly" tabindex="3"
							disabled="if(document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>_custom').checked){'disabled'}else{''}"
							> @ <select
							style="width: 70px;"
							name="<%=Common.PARAM_FEEDBACK_SESSION_VISIBLETIME%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_VISIBLETIME%>" tabindex="4"
							disabled="if(document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>_custom').checked){'disabled'}else{''}"
							>
								<%
									for(String opt: data.getTimeOptions(true)) out.println(opt);
								%>
						</select></td>
						<td><input type="radio" name="<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>_atopen" value="atopen"
							<%if(data.newFeedbackSession==null || data.newFeedbackSession.sessionVisibleFromTime.equals(Common.TIME_REPRESENTS_FOLLOW_OPENING)) 
									out.print("checked=\"checked\"");%>
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_SESSIONVISIBLEATOPEN%>')"
							onmouseout="hideddrivetip()"
							onclick="document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_VISIBLEDATE%>').disabled='disabled';
							document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_VISIBLETIME%>').disabled='disabled';">
							 At opening time</td>
						<td colspan="2"><input type="radio" name="<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_SESSIONVISIBLEBUTTON%>_never" value="never"
							<%if(data.newFeedbackSession!=null && data.newFeedbackSession.sessionVisibleFromTime.equals(Common.TIME_REPRESENTS_NEVER)) 
									out.print("checked=\"checked\"");%>
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_SESSIONVISIBLENEVER%>')"
							onmouseout="hideddrivetip()"
							onclick="document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_VISIBLEDATE%>').disabled='disabled'
							document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_VISIBLETIME%>').disabled='disabled';">
							 Never (This is a private session)</td>
					</tr>
					<tr>
						<td class="label bold">Results visible from:</td>
						<td><input type="radio" name="<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>_custom" value="custom"
							<%if(data.newFeedbackSession!=null &&
									 data.newFeedbackSession.resultsVisibleFromTime.equals(Common.TIME_REPRESENTS_FOLLOW_VISIBLE) == false &&
									 data.newFeedbackSession.resultsVisibleFromTime.equals(Common.TIME_REPRESENTS_LATER) == false &&
									 data.newFeedbackSession.resultsVisibleFromTime.equals(Common.TIME_REPRESENTS_NEVER) == false) 
									out.print("checked=\"checked\"");%>
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_RESULTSVISIBLECUSTOM%>')"
							onmouseout="hideddrivetip()"
							onclick="document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHDATE%>').disabled=''
							document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHTIME%>').disabled=''"> 
							<input style="width: 100px;" type="text"
							name="<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHDATE%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHDATE%>"
							onclick="if(document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>_custom').checked){cal.select(this,'<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHDATE%>','dd/MM/yyyy');}
							else{return false;}"
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_PUBLISHDATE%>')"
							onmouseout="hideddrivetip()"
							value="<%=((data.newFeedbackSession==null || Common.isSpecialTime(data.newFeedbackSession.resultsVisibleFromTime)) ? "" : Common.formatDate(data.newFeedbackSession.resultsVisibleFromTime))%>"
							readonly="readonly" tabindex="5"
							disabled="if(document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>_custom').checked){'disabled'}else{''}">
							 @ <select
							style="width: 70px;"
							name="<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHTIME%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHTIME%>" tabindex="6"
							disabled="if(document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>_custom').checked){'disabled'}else{''}"
							>
								<%
									for(String opt: data.getTimeOptions(true)) out.println(opt);
								%>
						</select></td>
						<td><input type="radio" name="<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>_atvisible" value="atvisible"
							<%if(data.newFeedbackSession==null || data.newFeedbackSession.resultsVisibleFromTime.equals(Common.TIME_REPRESENTS_FOLLOW_VISIBLE)) 
									out.print("checked=\"checked\"");%>
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_RESULTSVISIBLEATVISIBLE%>')"
							onmouseout="hideddrivetip()"
							onclick="document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHDATE%>').disabled='disabled';
							document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHTIME%>').disabled='disabled'">
							 Once the session is visible</td>
						<td><input type="radio" name="resultsVisibleFromButton"
							id="<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>_later" value="later"
							<%if(data.newFeedbackSession!=null && data.newFeedbackSession.resultsVisibleFromTime.equals(Common.TIME_REPRESENTS_LATER)) 
									out.print("checked=\"checked\"");%>
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_PUBLISHDATE%>')"
							onmouseout="hideddrivetip()"
							onclick="document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHDATE%>').disabled='disabled';
							document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHTIME%>').disabled='disabled'">
							 Later </td>
						<td><input type="radio"
							name="<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_RESULTSVISIBLEBUTTON%>_never" value="never"
							<%if(data.newFeedbackSession!=null && data.newFeedbackSession.resultsVisibleFromTime.equals(Common.TIME_REPRESENTS_NEVER)) 
									out.print("checked=\"checked\"");%>
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_RESULTSVISIBLENEVER%>')"
							onmouseout="hideddrivetip()"
							onclick="document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHDATE%>').disabled='disabled'
							document.getElementById('<%=Common.PARAM_FEEDBACK_SESSION_PUBLISHTIME%>').disabled='disabled'">
							 Never</td>
					</tr>
				</table>
				<br>
				<table class="inputTable sessionTable" id="timeFrameTable">
					<tr>
						<td class="label bold">Opening time:</td>
						<td><input style="width: 100px;" type="text"
							name="<%=Common.PARAM_FEEDBACK_SESSION_STARTDATE%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_STARTDATE%>"
							onclick="cal.select(this,'<%=Common.PARAM_FEEDBACK_SESSION_STARTDATE%>','dd/MM/yyyy')"
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_STARTDATE%>')"
							onmouseout="hideddrivetip()"
							value="<%=(data.newFeedbackSession==null? Common.formatDate(Common.getNextHour()) : Common.formatDate(data.newFeedbackSession.startTime))%>"
							readonly="readonly" tabindex="7"> @ <select
							style="width: 70px;"
							name="<%=Common.PARAM_FEEDBACK_SESSION_STARTTIME%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_STARTTIME%>" tabindex="4">
								<%
									for(String opt: data.getTimeOptions(true)) out.println(opt);
								%>
						</select></td>
						<td class="label bold">Closing Time:</td>
						<td><input style="width: 100px;" type="text"
							name="<%=Common.PARAM_FEEDBACK_SESSION_ENDDATE%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_ENDDATE%>"
							onclick="cal.select(this,'<%=Common.PARAM_FEEDBACK_SESSION_ENDDATE%>','dd/MM/yyyy')"
							onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_FEEDBACK_SESSION_ENDDATE%>')"
							onmouseout="hideddrivetip()"
							value="<%=(data.newFeedbackSession==null? "" : Common.formatDate(data.newFeedbackSession.endTime))%>"
							readonly="readonly" tabindex="8"> @ <select
							style="width: 70px;"
							name="<%=Common.PARAM_FEEDBACK_SESSION_ENDTIME%>"
							id="<%=Common.PARAM_FEEDBACK_SESSION_ENDTIME%>" tabindex="4">
								<%
									for(String opt: data.getTimeOptions(true)) out.println(opt);
								%>
						</select></td>
						<td class="label bold">Grace Period:</td>
						<td><select style="width: 75px;" name="<%=Common.PARAM_FEEDBACK_SESSION_GRACEPERIOD%>"
								id="<%=Common.PARAM_FEEDBACK_SESSION_GRACEPERIOD%>"
								onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_EVALUATION_INPUT_GRACEPERIOD%>')"
								onmouseout="hideddrivetip()" tabindex="7">
									<%
										for(String opt: data.getGracePeriodOptions()) out.println(opt);
									%>
						</select></td>
					</tr>
				</table>
				<br>
				<table class="inputTable" id="instructionsTable">
					<tr>
						<td class="label bold middlealign" >Instructions to students:</td>
						<td>
							<%
								if(data.newFeedbackSession==null){
							%>
								<textarea rows="4" cols="110" class="textvalue" name="<%=Common.PARAM_FEEDBACK_SESSION_INSTRUCTIONS%>" id="<%=Common.PARAM_FEEDBACK_SESSION_INSTRUCTIONS%>"
										onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_EVALUATION_INPUT_INSTRUCTIONS%>')"
										onmouseout="hideddrivetip()" tabindex="8">Please answer all the given questions.</textarea>
							<%
								} else {
							%>
								<textarea rows="4" cols="110" class="textvalue" name="<%=Common.PARAM_FEEDBACK_SESSION_INSTRUCTIONS%>" id="<%=Common.PARAM_FEEDBACK_SESSION_INSTRUCTIONS%>"
										onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_EVALUATION_INPUT_INSTRUCTIONS%>')"
										onmouseout="hideddrivetip()" tabindex="8"><%=InstructorFeedbackPageData.escapeForHTML(data.newFeedbackSession.instructions.getValue())%></textarea>
							<%
								}
							%>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="centeralign"><input id="button_submit"
							type="submit" class="button"
							onclick="return checkAddFeedbackSession(this.form);"
							value="Create Feedback Session" tabindex="9"></td>
					</tr>
				</table>
				<input type="hidden" name="<%=Common.PARAM_USER_ID%>" value="<%=data.account.googleId%>">
				<input type="hidden" name="<%=Common.PARAM_FEEDBACK_SESSION_CREATOR%>" value="<%=data.account.email%>">
			</form>
			
			<jsp:include page="<%=Common.JSP_STATUS_MESSAGE_NEW%>" />
			<br>
			
			<table class="dataTable">
				<tr>
					<th class="leftalign color_white bold">
						<input class="buttonSortAscending" type="button" id="button_sortcourseid" 
								onclick="toggleSort(this,1)">Course ID</th>
					<th class="leftalign color_white bold">
						<input class="buttonSortNone" type="button" id="button_sortname"
								onclick="toggleSort(this,2)">Feedback Session</th>
					<th class="centeralign color_white bold">Status</th>
					<th class="centeralign color_white bold"><span
						onmouseover="ddrivetip('<%=Common.HOVER_MESSAGE_EVALUATION_RESPONSE_RATE%>')"
						onmouseout="hideddrivetip()">Response Rate</span></th>
					<th class="centeralign color_white bold no-print">Action(s)</th>
				</tr>
				<%
					int fsIdx = -1;
										if (data.existingSessions.size() > 0) {
											for(FeedbackSessionDetailsBundle fdb: data.existingSessions){ fsIdx++;
				%>
							<tr class="evaluations_row" id="evaluation<%=fsIdx%>">
								<td class="t_eval_coursecode"><%=fdb.feedbackSession.courseId%></td>
								<td class="t_eval_name"><%=InstructorFeedbackPageData.escapeForHTML(fdb.feedbackSession.feedbackSessionName)%></td>
								<td class="t_eval_status centeralign"><span
									onmouseover="ddrivetip(' <%=InstructorFeedbackPageData.getInstructorHoverMessageForFeedbackSession(fdb.feedbackSession)%>')"
									onmouseout="hideddrivetip()"><%=InstructorFeedbackPageData.getInstructorStatusForFeedbackSession(fdb.feedbackSession)%></span></td>
								<td class="t_eval_response centeralign"><%= fdb.stats.submittedTotal %>
									/ <%= fdb.stats.expectedTotal %></td>
								<td class="centeralign no-print"><%=data.getInstructorFeedbackSessionActions(fdb.feedbackSession,fsIdx, false)%>
								</td>
							</tr>
						<%	} %>
				<%	} else { %>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				<%	} %>
			</table>
			<br>
			<br>
			<br>
			<%	if(fsIdx==-1){ %>
				<div class="centeralign">No records found.</div>
				<br>
				<br>
				<br>
			<%	} %>
		</div>
	</div>

	<div id="frameBottom">
		<jsp:include page="<%= Common.JSP_FOOTER_NEW %>" />
	</div>
</body>
</html>