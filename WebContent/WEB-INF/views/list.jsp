<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
 
  
 	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
 
    <script type="text/javascript">
    	$(function() {
 
	        // Add a new Person
	        $(".btn-info").off("click").on("click", function() {
	         
	            var index2show = $(this).data("index");
	             
	            $("#produtos" + index2show + "\\.wrapper").show(); 
	            
	            return false;
	        });
	
	    });
    </script> 
 

 
<style>

.titulo {

	border-top: 0px !important;	
	margin-top:12px;
    margin-bottom:12px;
    font-weight: bold;
    text-align: left;
}

.panel-body{

	margin-left: 200px;
}

.tabelaProduto {
	width: 60% !important;
}

.panel-group .panel-heading+.panel-collapse>.list-group, .panel-group .panel-heading+.panel-collapse>.panel-body {
  
    border-top: none !important;
}

</style>


<body>
  
		<jsp:include page="../views/fragments/header.jsp" />
  
		<h1>Pessoas e Produtos</h1>
		
		<br>
  
 		<div class="row titulo">
        	<div class="col-sm-12">
                <div class="col-xs-2 col-sm-2">
	 				<span>#ID</span>
				</div>
                <div class="col-xs-2 col-sm-3">
	 				<span>Nome</span>
				</div>
				<div class="col-xs-2 col-sm-3">
	 				<span>Email</span>
				</div>
				<div class="col-xs-2 col-sm-4">
	 				<span> </span>
				</div>									 
			</div>
	 	</div>
 
		<div class="panel-group" id="accordion">
			<c:forEach var="pessoa" items="${pessoas}"  varStatus="loopPessoa" >			
			 	<div class="panel panel-default">			 	
    				<div class="panel-heading">			
						<div class="row">						
					        <div class="col-sm-12">
					                <div class="col-xs-2 col-sm-2">
						 				<span>${pessoa.id}</span>
									</div>
					                <div class="col-xs-2 col-sm-3">
						 				<span>${pessoa.nome}</span>
									</div>
									<div class="col-xs-2 col-sm-3">
						 				<span>${pessoa.email}</span>
									</div>
									<div class="col-xs-2 col-sm-2">
											<spring:url value="/pessoa/${pessoa.id}" var="userUrl" />
											<spring:url value="/pessoa/delete/${pessoa.id}" var="deleteUrl" /> 
											<spring:url value="/pessoa/update/${pessoa.id}" var="updateUrl" />
			 
	     										
	     									<h4 class="panel-title">
	       										<a data-toggle="collapse" data-parent="#accordion" href="#produtos${loopPessoa.index}">
	       												Produtos </a>
	     										</h4>	
											 
									</div>
									<div class="col-xs-2 col-sm-1"> 		
											<button class="btn btn-primary" onclick="location.href='${updateUrl}'">Update</button>
									</div>
									<div class="col-xs-2 col-sm-1">		
											<button class="btn btn-danger" onclick="location.href='${deleteUrl}'">Delete</button></td>
									</div>									 
							</div>
						</div>				 
					</div>
				    <div id="produtos${loopPessoa.index}" class="panel-collapse collapse">
				        <div class="panel-body">
			        		<table class="table tabelaProduto">
								<thead>
									<tr>
										<th colspan="2">Produtos</th>
									</tr>
									<tr>
										<th>Nome</th>
										<th>Valor</th>
									</tr>
								</thead>
				          		<c:forEach var="produto" items="${pessoa.produtos}" varStatus="loop">
 									<tr>
										<td>${produto.nome}</td>
										<td>${produto.valor}</td>
    				    			</tr>	 									
				          		</c:forEach>
		          	 		</table>
						</div>				
				     </div>				     
				 </div>				 
			</c:forEach>		 
 		</div>
 
		<jsp:include page="../views/fragments/footer.jsp" />
	 
</body>
</html>