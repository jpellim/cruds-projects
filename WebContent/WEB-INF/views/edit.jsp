<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>

    <title>Edit</title>
    <style type="text/css">.hidden {display: none;}</style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
    
    <style>
    
    .control-label2 {
    	font-color: #FF0000 !important;
    }
    
    .div-prod {
    	margin-top: 10px;
    }
    
    fieldset.scheduler-border {
	    border: solid 1px #DDD !important;
	    padding: 0 10px 10px 10px;
	    border-bottom: none;
	}
	
	legend.scheduler-border {
	    width: auto !important;
	    border: none;
	    font-size: 14px;
	}
    </style>
    
    <script type="text/javascript">
    
     $(function() {

        // Start indexing at the size of the current list
        var index = ${fn:length(pessoa.produtos)};
        
        // Add a new Product
        $("#add").off("click").on("click", function() {
        	  
            $("#produtoAdd").after(function() {
            	
	            var prodNome = $("#produtoNome").val();
	            	 
	            $("#produtoNome").val("");
	            	 
	            var prodValor = $("#produtoValor").val();
	            	
	            $("#produtoValor").val("");
	            	
	            var html = '<div id="produtos' + index + '.wrapper" class="col-sm-offset-2 col-sm-10 div-prod"   >';       
	                
	                html += '<div class="col-xs-5 col-sm-4">  ';
	                
	                html += '<input type="text" id="produtos' + index + '.nome" name="produtos[' + index + '].nome" value="' + prodNome + '"  class="form-control"   />' ;
	           
	                html += '</div>';
	                
	                html += '<div class="col-xs-5 col-sm-4">  ';
	                
	                html += '<input type="number" id="produtos' + index + '.valor" name="produtos[' + index + '].valor"  value="' + prodValor + '"  class="form-control"   />';
	                
	                html += '</div>';
	                
	                html += '<input type="hidden" id="produtos' + index + '.remove" name="produtos[' + index + '].remove" value="0" />';
	               
	                html += '<a href="#" class="produtos.remove" data-index="' + index + '"  onclick="removerProduto('+ index +')"    >remover</a>';                    
	                
	                html += "</div>";
	                
	                return html;
            
	        });
	           
	        $("#produtos" + index + "\\.wrapper").show();
	         
	        index++;
	         
	        return false;
	     });
 
    });
     
    function removerProduto(index2remove){
        
        $("#produtos" + index2remove + "\\.wrapper").hide();
 
        $("#produtos" + index2remove + "\\.remove").val("1");
         
    } 
     
    </script>

</head>
<body>

    <c:choose>
        <c:when test="${type eq 'create'}"><c:set var="actionUrl" value="create" /></c:when>
        <c:otherwise><c:set var="actionUrl" value="update/${employer.id}" /></c:otherwise>
    </c:choose>

	<jsp:include page="../views/fragments/header.jsp" />
	
	<div class="container">
	
		<c:choose>
			<c:when test="${type eq 'create'}">
				<h1>Cadastrar Nova Pessoa</h1>
			</c:when>
			<c:otherwise>
				<h1>Atualizar Pessoa</h1>
			</c:otherwise>
		</c:choose>
		<br />
	
		<spring:url value="/users" var="userActionUrl" />
	
		<form:form class="form-horizontal" method="post" modelAttribute="pessoa" action="${pessoaActionUrl}">
	
	
			<form:errors path="msg" class="control-label control-label2" />
			<br />
	
			<form:hidden path="id" />
	
			<spring:bind path="nome">
				<div class="form-group ${status.error ? 'has-error' : ''}">
					<label class="col-sm-2 control-label">Name</label>
					<div class="col-sm-10">
						<form:input path="nome" type="text" class="form-control" id="nome" placeholder="Nome" />
						<form:errors path="nome" class="control-label" />
					</div>
				</div>
			</spring:bind>
	
			<spring:bind path="email">
				<div class="form-group ${status.error ? 'has-error' : ''}">
					<label class="col-sm-2 control-label">Email</label>
					<div class="col-sm-10">
						<form:input path="email" class="form-control" id="email" type="email" placeholder="Email" />
						<form:errors path="email" class="control-label" />
					</div>
				</div>
			</spring:bind>
	
			<fieldset  class="scheduler-border col-sm-offset-2 col-sm-10" >
		
				<legend class="scheduler-border">Produtos</legend>
		
				<div class="form-group">
					 
					<div id="produtoAdd">
					
						<div class="col-sm-offset-2 col-sm-10">
							<div class="col-xs-5 col-sm-4">
			                     <span>Nome</span>
			                </div>
				                 
			                <div class="col-xs-5 col-sm-4">
			                     <span>Valor</span>
			                </div>
			            </div>     
						
						<div class="col-sm-offset-2 col-sm-10">
							
			            	<div class="col-xs-5 col-sm-4">
			                     <input type="text" id="produtoNome" class="form-control" />
			                 </div>
				                 
			                 <div class="col-xs-5 col-sm-4">
			                     <input type="number" id="produtoValor" class="form-control" />
			                 </div>
				                     
			                 <div class="col-xs-5 col-sm-2">
			                     <button id="add" type="button">adicionar</button>			                
							</div>
						</div>
					</div>						 
				</div>
			 
 				<c:if  test="${fn:length(pessoa.produtos) gt 0}">		
		 			<c:forEach items="${pessoa.produtos}" varStatus="loop">		                 	            
	    				  <c:choose>
	                            <c:when test="${pessoa.produtos[loop.index].remove eq 1}">
	                                <div id="produtos${loop.index}.wrapper" class="hidden col-sm-offset-2 col-sm-10 div-prod">
	                            </c:when>
	                            <c:otherwise>
	                                <div id="produtos${loop.index}.wrapper" class="col-sm-offset-2 col-sm-10 div-prod">
	                            </c:otherwise>
	                        </c:choose>
                            <!-- Generate the fields -->
                            <div class="col-xs-5 col-sm-4">
                            	<form:input path="produtos[${loop.index}].nome" class="form-control"  />
                            </div>
                            <div class="col-xs-5 col-sm-4">	
                            	<form:input path="produtos[${loop.index}].valor" class="form-control" />
                            </div>
                            <!-- Add the remove flag -->
                            <c:choose>
                                <c:when test="${produtos[loop.index].remove eq 1}"><c:set var="hiddenValue" value="1" /></c:when>
                                <c:otherwise><c:set var="hiddenValue" value="0" /></c:otherwise>
                            </c:choose>
                            <form:hidden path="produtos[${loop.index}].id" />                            
                            <form:hidden path="produtos[${loop.index}].remove" value="${hiddenValue}" />
                            <!-- Add a link to remove the Products -->
                             
                            	<a href="#" class="produtos.remove" onclick="removerProduto(${loop.index})"   data-index="${loop.index}">remover</a>
                        	 
                        </div>
		                     
		            </c:forEach>				
				</c:if>				 
			 
			 
			</fieldset>
			 
	 
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10"> 
					<button type="submit" class="btn-lg btn-primary pull-right">Save</button>
				</div>
			</div>
			 
		</form:form>
	
	</div>
	
	<jsp:include page="../views/fragments/footer.jsp" />

</body>
</html>