<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<script>
function jalert(param){
	$("#alert-dialog").attr("title", (param.title == undefined) ? '<spring:message code="jalert.title"/>' : param.title);
	$("#alert-dialog p").html(param.message);
	
	$("#alert-dialog").dialog({
		width: 450, modal: true, autoOpen: true,
		show: "explode", hide: "explode", buttons:{
			'<spring:message code="jalert.close"/>': function(){
				$("#alert-dialog").dialog("close");
				if(param.callback != undefined){
					param.callback();
				}
			}
		}
	});
}

function jconfirm(param){
	$("#confirm-dialog").attr("title", (param.title == undefined) ? '<spring:message code="jconfirm.title"/>' : param.title);
	$("#confirm-dialog p").html(param.message);
	
	$("#confirm-dialog").dialog({
		width: 450, modal: true, autoOpen: true,
		show: "explode", hide: "explode", buttons:{
			'<spring:message code="jconfirm.yes"/>': function(){
				$("#confirm-dialog").dialog("close");
				if(param.callback != undefined){
					param.callback(true);
				}
			},
			'<spring:message code="jconfirm.no"/>': function(){
				$("#confirm-dialog").dialog("close");
				if(param.callback != undefined){
					param.callback(false);
				}
			}
		}
	});
}

function jprompt(param){
	$("#prompt-dialog").attr("title", (param.title == undefined) ? '<spring:message code="jprompt.title"/>' : param.title);
	$("#prompt-dialog p").html(param.message);
	$("#prompt-dialog input").val((param.input == undefined) ? "" : param.input);
	
	$("#prompt-dialog").dialog({
		width: 450, modal: true, autoOpen: true,
		show: "explode", hide: "explode", buttons:{
			'<spring:message code="jalert.title"/>': function(){
				$("#prompt-dialog").dialog("close");
				if(param.callback != undefined){
					param.callback($("#prompt-dialog input").val());
				}
			},
			'<spring:message code="jalert.title"/>': function(){
				$("#prompt-dialog").dialog("close");
			}
		}
	});
}
</script>
<style>
	#alert-dialog, #confirm-dialog, #prompt-dialog{
		display: none; 
		text-align: center; 
		color: gray;
	}
	#prompt-dialog input{
		width:95%; 
		padding:5px; 
		border:1px dotted gray; 
		border-radius:10px; 
		text-align: center;
	}
</style>

<div id="alert-dialog" title="@title">
	<img src="images/others/Warning.png">
	<p>@message</p>
</div>

<div id="confirm-dialog" title="@title">
	<img src="images/others/Warning.png">
	<p>@message</p>
</div>

<div id="prompt-dialog" title="@title">
	<img src="images/others/Warning.png">
	<p>@message</p>
	<input>
</div>