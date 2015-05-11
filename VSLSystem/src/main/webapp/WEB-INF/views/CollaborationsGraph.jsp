<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="br.com.vsc.VSCSystem.model.entity.Publication"%>
<%@page import="java.util.HashMap"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

<title>VSCSystem</title>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/main.css" />" />

<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/theme.css">



<link rel="stylesheet" href="<c:url value="/resources/js/vis/css/vis.css" />" />


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>


<script type="text/javascript" src="<c:url value="/resources/js/vis/js/vis.js" />"> </script>

<style>
	
	#dvGraph, #dvFilters {
		width: 1000px;
		height: 450px;
		border: 1px solid lightgray;
		background: white;
	}
	
	#dvFilters{
		height: 38px !important;
		padding-top: 13px;
	}
	
	#dvYearFilter span, #dvTypeFilter span, #dvVenueFilter span{
		font-weight: bold;
		font-size: 15px;
	}
	
	#dvYearFilter, #dvTypeFilter, #dvButtonFilter, #dvVenueFilter, #dvButtonClearFilter{
		display: inline;
	}
	
	#dvYearFilter, #dvTypeFilter, #dvVenueFilter{
		text-align: left;
		margin-left: 10px;
		position: relative;
		left: -10px;
	}
	#dvYearFilter{
		width: 115px;
	}
	#dvTypeFilter, #dvVenueFilter{
		width: 230px;
	}
	#dvButtonFilter{
		position: relative;
		right: -5px;
	}
	#dvButtonClearFilter {
		position: relative;
		right: -10px;
	}
	#dvButtonClearFilter input {
		width: 45px !important;
	}
	
</style>
<script type="text/javascript">
	
	var DIR = '/VSCSystem/resources/js/vis/images/';
	var nodes = null;
	var edges = null;
	var collaborations = null;
	var network = null;
	function draw() {
		collaborations = [];
		// create nodes
		var nodes = [];
		nodes.push(
			{
				id : 1,
				label : "${author.name}",
				image : DIR + 'User-Executive-Green-icon.png',
				shape : 'image'
			}				
		);
		// create connections
		var color = '#BFBFBF';
 		var edges = [];
		var countIdNodes = 2;
		
		<c:forEach items="${author.collaborations}" var="collaboration">
			collaborations[countIdNodes] = {name : "${collaboration.key.name}"};
			nodes.push(
				{
					id : countIdNodes,
					label :"${collaboration.key.name}",
					image : DIR + 'User-Administrator-Green-icon.png',
					shape : 'image'
				}	
			);
			edges.push(
				{
		 			from : 1,
		 			to : countIdNodes,
		 			value : "${collaboration.value}",
		 			label : "${collaboration.value}",
		 			color : color
				}
			);
			countIdNodes++;
			
		</c:forEach>		
		// create a network
		var container = document.getElementById('dvGraph');
		var data = {
			nodes : nodes,
			edges : edges
		};
		var options = {
// 			configurePhysics:true,
			
		};
// var options = {physics: {barnesHut: {enabled: false}, repulsion: {nodeDistance:150, springConstant: 0.013, damping: 0.3}}, smoothCurves:false};
		network = new vis.Network(container, data, options);
		network.on('doubleClick', function (properties) {
			if(collaborations[properties.nodes] != null){
				window.open(encodeURI('../VSCSystem/ListAuthors?searchName='+collaborations[properties.nodes].name), '_blank');
			}
		});
		
	}
	
	function clearFilter(){
		$('#yearFilter option[value="0"]').prop('selected', true);
		$('#typeFilter option[value=""]').prop('selected', true);
		$('#venueFilter option[value=""]').prop('selected', true);
	}
	
</script>
</head>
<body onload="draw()">
	<center>
		<h1><a href="Home" title="Home">VSCSystem</a></h1>
		<h2><a href="SearchAuthor" title="Search new Author">Search by Author</a></h2>
		<h2>Author: ${author.name}</h2>
		<br>
		<span class="errorMessage">${msg}</span>
		<br>
		<h4>FILTERS</h4>
		<form action="Filter" method="post">
			<div id="dvFilters">
				<div id="dvYearFilter">
					<span>Year:</span>
					<select id="yearFilter" name="yearFilter">
						<option value="0">Select a year...</option>
						<c:forEach items="${yearsFilter}" var="yearValue">
							<option ${yearValue == yearFiltered ? 'selected' : ''} value="${yearValue}">${yearValue}</option>
						</c:forEach>
					</select>
				</div>
				<div id="dvTypeFilter">
					<span>Type:</span>
					<select id="typeFilter" name="typeFilter">
						<option value="">Select a type...</option>
						<c:forEach items="${typesFilter}" var="typeValue">
							<option ${typeValue == typeFiltered ? 'selected' : ''} value="${typeValue}">${typeValue}</option>
						</c:forEach>
					</select>
				</div>
				<div id="dvVenueFilter">
					<span>Venue:</span>
					<select id="venueFilter" name="venueFilter">
						<option value="">Select a venue...</option>
						<c:forEach items="${venuesFilter}" var="venueValue">
							<option ${venueValue == venueFiltered ? 'selected' : ''} value="${venueValue}">${venueValue}</option>
						</c:forEach>
					</select>
				</div>
				<div id="dvButtonFilter">
					<input type="submit" class="button formButton" title="Apply Filter" value="Apply Filter"/>
				</div>
				<div id="dvButtonClearFilter">
					<input type="button" onclick="clearFilter()" class="button formButton" title="Clear" value="Clear"/>
				</div>
			</div>	
		</form>
		<h4>GRAPH</h4>
		<div id="dvGraph"></div>
	</center>
</body>
</html>