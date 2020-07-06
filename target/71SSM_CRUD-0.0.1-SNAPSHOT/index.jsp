<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!-- web路径
	不以/开始的相对路径，找资源一资源路径为基准 容易出问题
	以/开始的相对路径，找资源一服务器路径为基准(http://locallhost:8080)
 -->
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/javaScript/jquery.min.js"></script>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      
	      <div class="modal-body">
		      <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
				    	<label class="radio-inline">
  							<input type="radio" name="gender" id="gender1_add_input" value='m' checked="checked"> 男
						</label>
						<label class="radio-inline">
					 		<input type="radio" name="gender" id="gender2_add_input" value='f'> 女
						</label>
				    </div>
				  </div>
				   <div class="form-group">
				    <label class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-3">
				    	<!-- 提交部门id即可 -->
				    	<select class="form-control" name="dId" id="dept_add_select"></select>
				    </div>
				  </div>
			</form>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	      
	    </div>
	  </div>
	</div>

	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      
	      <div class="modal-body">
		      <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">empName</label>
				    <div class="col-sm-10">
				      <p class="form-control-static" id="empName_update_static"></p>
				       <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">email</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">gender</label>
				    <div class="col-sm-10">
				    	<label class="radio-inline">
  							<input type="radio" name="gender" id="gender1_update_input" value='m' checked="checked"> 男
						</label>
						<label class="radio-inline">
					 		<input type="radio" name="gender" id="gender2_update_input" value='f'> 女
						</label>
				    </div>
				  </div>
				   <div class="form-group">
				    <label class="col-sm-2 control-label">deptName</label>
				    <div class="col-sm-3">
				    	<select class="form-control" name="dId" id="dept_update_select"></select>
				    </div>
				  </div>
			</form>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
	<div class="container">
		<!-- 标题 -->
		<div class="row">
		  <div class="col-md-12">
		  	<h1>SSM_CRUD</h1>
		  </div>
		</div>
		<!-- 按钮 -->
		<div class="row">
	  		<div class="col-md-4 col-md-offset-8">
	  			<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
	  			<button class="btn btn-danger" id="emp_delete_all_btn">批量删除</button>
	  		</div>
		</div>
		
		<!-- 显示表格数据 -->
		<div class="row">
		  <div class="col-md-12">
		  	<table class="table table-hover" id="emps_table" >
			  	<thead>
			  		<tr>
			  			<th>
			  				<input type = "checkbox" id="check_all" />
			  			</th>
				  		<th>#</th>
				  		<th>empName</th>
				  		<th>gender</th>
				  		<th>email</th>
				  		<th>deptName</th>
				  		<th>操作</th>		  		
			  		</tr>
			  	</thead>
			  	<tbody>		  		
			  	</tbody>		  	
		  	</table>
		  </div>
		</div>
		
		<!-- 显示分页信息 -->
		<div class="row">
			<!--文字分页信息  -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	
	<script type="text/javascript">		
	//定义总记录数,作为新增员工后返回的尾页；当前页码,给修改、删除操作之后返回本页使用
	var totalRecord,currentPageNum;
	
	$(function(){
		to_page(1)		
	});
	
	//构建员工信息表格
	function build_emps_table(result){
		
		$("#emps_table tbody").empty();//构建前先清空上一次的数据
		
		var emps = result.extend.pageInfo.list;
		$.each(emps,function(index,item){
			var checkBoxTd = $("<td><input type ='checkbox' class='check_item'/></td>");
			var empId = $("<td></td>").append(item.empId);
			var empName = $("<td></td>").append(item.empName);
			var gender = $("<td></td>").append(item.gender=='m'?"男":"女");
			var email = $("<td></td>").append(item.email);
			var deptName = $("<td></td>").append(item.department.deptName);		
			var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");			
				editBtn.attr("edit-id",item.empId);//为编辑按钮添加自定义属性作为员工ID
			
			var deletBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				deletBtn.attr("delete-id",item.empId);//为删除按钮添加自定义属性作为员工ID
				
			var btnTd = $("<td></td>").append(editBtn).append(" ").append(deletBtn);
			$("<tr></tr>").append(checkBoxTd).append(empId).append(empName).append(gender).append(email).append(deptName).append(btnTd).appendTo("#emps_table tbody");
		});
	}
	
	//构建分页文字信息
	function build_page_info(result){
		$("#page_info_area").empty();//构建前先清空上一次的数据
		$("#page_info_area").append("当前 "+result.extend.pageInfo.pageNum+"页,总共"+result.extend.pageInfo.pages+" 页,总 "+result.extend.pageInfo.total+"条记录");
		totalRecord = result.extend.pageInfo.total;
		currentPageNum = result.extend.pageInfo.pageNum;
	}
	
	//构建分页条
	function build_page_nav(result){		
		/* 分页条结构：
			nav 
				ul 
					li a		
		*/
		
		$("#page_nav_area").empty();//构建前先清空上一次的数据
		var ul = $("<ul></ul>").addClass("pagination");
		
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		
		//判断前一页和首页能否点击
		if(result.extend.pageInfo.hasPreviousPage==false){
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}
		else
		{
			//为首页和上一页按钮添加点击事件
			firstPageLi.click(function(){to_page(1);}); 
			prePageLi.click(function(){to_page(result.extend.pageInfo.pageNum-1);}); 
		}
				
		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页"));
		
		//判断下一页和尾页能否点击
		if(result.extend.pageInfo.hasNextPage==false){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}
		else
		{			
			//为首页和上一页按钮添加点击事件
			nextPageLi.click(function(){to_page(result.extend.pageInfo.pageNum+1);}); 
			lastPageLi.click(function(){to_page(result.extend.pageInfo.pages);}); 
		}

		//添加首页和前一页
		ul.append(firstPageLi).append(prePageLi);
		
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if(result.extend.pageInfo.pageNum == item){
				numLi.addClass("active");
			}
			numLi.click(function(){to_page(item);}); //为元素添加点击事件
			ul.append(numLi);//添加页码信息
		});
		
		ul.append(nextPageLi).append(lastPageLi);//添加下一页和尾页
		
		var nav = $("<nav></nav>").append(ul);
		
		nav.appendTo("#page_nav_area");
	}
	
	function to_page(pn){
		$.ajax({
			url:"${APP_PATH }/emps",
			data:"pn="+pn,
			type:"get",
			success:function(result){
				//0、清空多选项勾选情况
				$("#check_all").prop("checked",false);
				//1、解析并显示员工数据
				build_emps_table(result);
				//2、解析并显示分页信息
				build_page_info(result);
				//3、解析显示分页条信息
				build_page_nav(result);
			}
		});
	}
	
	
	//清空表单样式和内容
	function reset_form(ele)
	{
		$(ele)[0].reset();
		$(ele).find("*").removeClass("has-error has-success");
		$(ele).find(".help-block").text("");
	}
	
	//新增按钮点击事件，弹出模态框
	$("#emp_add_modal_btn").click(function(){
		
		//清除表单数据
		reset_form("#empAddModal form");
		
		
		//发送ajax请求，查出部门信息，之后显示在下拉列表中		
		 getDepts("#dept_add_select");
		
		//弹出模态框
		$("#empAddModal").modal({
			backdrop:"static"
		});
	});
	
	
	//以ajax请求查出所有部门信息，显示在下拉列表中
	function getDepts(ele)
	{	
		$(ele).empty();//构建前先清空上一次的数据	
		$.ajax({
			url:"${APP_PATH }/depts",
			type:"get",
			success:function(result){
					
				$.each(result.extend.depts,function(){
					var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
					optionEle.appendTo(ele);
				});
				
			}
			
		});
	}
	
	//工具函数：显示校验结果的提示信息
	function show_validate_msg(ele,status,msg)
	{
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		
		if("success"==status)
		{
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text("");
		}
		else if("error"==status)
		{
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}
	}
	
	//前端校验表单数据
	function validate_add_form()
	{
		//1、拿到要校验的数据，使用正则表达式
		var empName = $("#empName_add_input").val();
		var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
		if(!regName.test(empName))
		{
			show_validate_msg("#empName_add_input","error","前端校验：用户名可以是2-5位中文或者4-16位英文");
			return false;
		}
		else
		{
			show_validate_msg("#empName_add_input","success","");
		};
		
		//2、校验邮箱
		var email = $("#email_add_input").val();
		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!regEmail.test(email))
		{
			show_validate_msg("#email_add_input","error","前端校验：邮箱格式不正确!");
			return false;
		}
		else
		{
			show_validate_msg("#email_add_input","success","");
		};
		
		
		return true;
		
	}
	
	

	
	//用户名输入框有变化时，发送ajax至后端，请求校验用户名是否可用
 	$("#empName_add_input").change(function(){
		
		var empName = this.value;
		$.ajax({			
			url:"${APP_PATH }/checkuser",
			type:"POST",
			data:"empName="+empName,
			success:function(result){
				if(result.code==100)
				{
					show_validate_msg("#empName_add_input","success",result.extend.va_msg);
					$("#emp_save_btn").attr("ajax-va","success");
				}
				else
				{
					show_validate_msg("#empName_add_input","error",result.extend.va_msg);
					$("#emp_save_btn").attr("ajax-va","error");
				}
			}
		});
		
	}); 
	
	
	//保存按钮
	$("#emp_save_btn").click(function()
	{
		
		//调用前端校验函数，校验数据
 		if(!validate_add_form())
		{
			return false;
		}; 
		
		//调用ajax校验函数，校验数据
 		if($("#emp_save_btn").attr("ajax-va")=="error")
		{
			return false;
		} 
		
		//1、模态框中填写的表单数据提交给服务器保存
		//2、发送ajax请求保存员工	
		//3、在后端还会进行SRS303校验
   		$.ajax({
				url:"${APP_PATH }/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result)
				{
				
					//判断保存状态
					if(result.code==100)
					{
						//1、关闭模态框
						$("#empAddModal").modal('hide');
						//2、跳转到最后一页，显示保存的数据
						to_page(totalRecord);	
					}
					else
					{
						//显示失败信息
						if(undefined != result.extend.errorFields.email)
						{
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined != result.extend.errorFields.empName)
						{							
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
						
					}
				
				}			
			
			}); 		
 		
	});
	
	
	//编辑按钮,通过edit_btn类绑定
	$(document).on("click",".edit_btn",function(){
		
		//清除表单数据
		reset_form("#empUpdateModal form");		
		
		//发送ajax请求，查出部门信息，之后显示在下拉列表中		
		 getDepts("#dept_update_select");
		
		//查询员工信息
		getEmp($(this).attr("edit-id"));
		
		//把id传给更新按钮
		$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
		
		//弹出模态框
		$("#empUpdateModal").modal({
			backdrop:"static"
		});
			
	});
	
	//根据id查询员工信息,供修改页面使用
	function getEmp(id)
	{	
		
		$.ajax({
			url:"${APP_PATH }/emp/"+id,
			type:"get",
			success:function(result){
				var empDate = result.extend.emp;
				$("#empName_update_static").text(empDate.empName);
				$("#email_update_input").val(empDate.email);
				$("#empUpdateModal input[name=gender]").val([empDate.gender]);
				$("#empUpdateModal select").val([empDate.dId]);
			}
			
		});
	}
	
	//更新按钮，提交更新信息
	$("#emp_update_btn").click(function(){
		//验证邮箱
		var email = $("#email_update_input").val();
		var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!regEmail.test(email))
		{
			show_validate_msg("#email_update_input","error","邮箱格式不正确!");
			return false;
		}
		else
		{
			show_validate_msg("#email_update_input","success","");
		}
		
		//保存员工
		$.ajax({
			url:"${APP_PATH }/emp/"+$(this).attr("edit-id"),
			type:"POST",
			data:$("#empUpdateModal form").serialize()+"&_method=PUT",
			success:function(result){
				//alert(result.msg);
				//1、关闭模态框
				$("#empUpdateModal").modal("hide");
				//2、回到本页面
				to_page(currentPageNum);
			}
			
		});
		
	});
	
	//单个删除按钮,通过delete_btn类绑定
	$(document).on("click",".delete_btn",function(){
		
		//1、弹出是否确认删除对话框
		var empName = $(this).parents("tr").find("td:eq(2)").text();
		var empId = $(this).attr("delete-id");
		if(confirm("确认删除【"+empName+"】吗？"))
		{
			$.ajax({
				url:"${APP_PATH }/emp/"+empId,
				type:"DELETE",
				success:function(result){
					
					alert(result.msg);
					//回到本页
					to_page(currentPageNum);
				}
			});
		}
			
	});

	//全选功能
	$("#check_all").click(function(){
		//attr获取checked是undefine，这些是dom原生的属性,使用prop来修改dom原生属性的值
		//alert($(this).prop("checked"));
		$(".check_item").prop("checked",$(this).prop("checked"));
		
		
		
	});
	
	//单选功能，判断当前选中的元素是否为5个,单个逐步选满一页时，全选项选中
	$(document).on("click",".check_item",function(){
				
		var flag = $(".check_item:checked").length==$(".check_item").length;
		$("#check_all").prop("checked",flag);
		
	});
	
	//批量删除按钮

  	$("#emp_delete_all_btn").click(function(){
		
		var empNames = "";
		var empIds = "";
		
		$.each($(".check_item:checked"),function(){
			empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
			empIds += $(this).parents("tr").find("td:eq(1)").text()+"-";
		});
				
		//去除empNames多余的逗号、empIds多余的短横线
		empNames = empNames.substring(0,empNames.length-1);
		empIds = empIds.substring(0,empNames.length-1);
		
		//有复选框被选中，才进行删除操作
		if($(".check_item:checked").length>0)
		{		
	 		if(confirm("确认删除【"+empNames+"】吗？"))
			{
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH }/emp/"+empIds,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到本页
						to_page(currentPageNum);
						
						
					}
					
				});
			} 
		}

	});  
	
	
	
	
	
	</script>
	
	
		
</body>
</html>