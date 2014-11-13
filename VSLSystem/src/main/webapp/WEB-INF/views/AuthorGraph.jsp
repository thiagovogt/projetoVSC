<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>VSLSystem</title>
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/main.css" />" />
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/js/DataTables-1.10.3/media/css/jquery.dataTables.css" />" />
<link type="text/css" rel="stylesheet" href="<c:url value="/resources/js/vis/css/vis.css" />" />

<script type="text/javascript" src="<c:url value="/resources/js/jQuery-2.1.1/jquery.min.js" />"> </script>
<script type="text/javascript" src="<c:url value="/resources/js/DataTables-1.10.3/media/js/jquery.dataTables.js" />"> </script>
<script type="text/javascript" src="<c:url value="/resources/js/vis/js/vis.js" />"> </script>

<style>
	body {
		font: 10pt arial;
	}
	
	#mynetwork {
		width: 1000px;
		height: 600px;
		border: 1px solid lightgray;
		background: #F3F3F3;
	}
</style>


<script type="text/javascript">
	$(document).ready(function() {
		var table = $('#publications').DataTable();
	});
	
    var DIR = '/VSLSystem/resources/js/vis/images/vis-network-icons/';
    var nodes = null;
    var edges = null;
    var network = null;
    function draw() {
      // create people
      nodes = [
        {id: 1,  label: 'Sabrina Marczak',  image: DIR + 'User-Executive-Green-icon.png', shape: 'image'},
        {id: 2,  label: 'Technologies to Support Collaboration across Time Zones.',  image: DIR + 'Document-icon48.png', shape: 'image'},
        {id: 3,  label: 'Trust in virtual teams: theory and tools.',    image: DIR + 'Document-icon48.png', shape: 'image'},
        {id: 4,  label: 'Ban Al-Ani',    image: DIR + 'User-Administrator-Blue-icon.png', shape: 'image'},
        {id: 5,  label: 'David F. Redmiles',    image: DIR + 'User-Administrator-Blue-icon.png', shape: 'image'},
        {id: 6,  label: 'Cleidson R. B. de Souza',    image: DIR + 'User-Administrator-Blue-icon.png', shape: 'image'},
        {id: 7,  label: 'Rafael Prikladnicki',    image: DIR + 'User-Administrator-Blue-icon.png', shape: 'image'},
        {id: 8,  label: 'Filippo Lanubile',    image: DIR + 'User-Administrator-Blue-icon.png', shape: 'image'},
        {id: 9,  label: 'Fabio Calefato',    image: DIR + 'User-Administrator-Blue-icon.png', shape: 'image'}
      ];
      // create connections
      var color = '#BFBFBF';
      edges = [
        {from: 1,   to: 2, value: 2, color: color},
        {from: 1,   to: 3, value: 2, color: color},
        {from: 3,   to: 4, value: 2, color: color},
        {from: 3,   to: 5, value: 2, color: color},
        {from: 3,   to: 6, value: 2, color: color},
        {from: 3,   to: 7, value: 2, color: color},
        {from: 3,   to: 8, value: 2, color: color},
        {from: 3,   to: 9, value: 2, color: color}
      ];
      // create a network
      var container = document.getElementById('mynetwork');
      var data = {
        nodes: nodes,
        edges: edges
      };
      var options = {};
      network = new vis.Network(container, data, options);
    }
  </script>
</head>
<body onload="draw()">
	<center>
		<h1>VSLSystem</h1>
		<h2>Search by Author</h2>
		<h2>Author: ${author.name}</h2>
		<br>
		<br>
		<span class="errorMessage">${msg}</span>
		<br>
		<br>
		<table id="publications" class="display" cellspacing="0" width="100%">
		 	<thead>
	            <tr>
	                <th>Publication Key</th>
	                <th>Publication XML</th>
	            </tr>
	        </thead>
	        <tfoot>
	            <tr>
 					<th>Publication Key</th>
	                <th>Publication XML</th>
	            </tr>
	        </tfoot>
			<tbody>
				<c:forEach items="${author.publications}" var="publication">
					<tr>
						<td>${publication.urlKey}</td>
						<td><pre><c:out value="${publication}"/></pre></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<div id="mynetwork"></div>
	</center>
</body>
</html>