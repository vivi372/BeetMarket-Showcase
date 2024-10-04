<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모의투자</title>
<style>
  .row {
    display: flex;
  }
  .col {
    flex: 1;
    padding: 10px;
    border: 1px solid #ddd;
  }
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
<div class="container-fluid">
  <div class="row">
  
  <div class="col">col</div>
  
  <div class="col">
  	<jsp:include page="/WEB-INF/views/chart/chart.jsp"/>
  
  </div>
  </div>
</div>
</body>
</html>