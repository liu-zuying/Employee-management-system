package handler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import entity.Department;
import entity.Msg;
import service.DepartmentService;

/*
 *处理和部门相关的请求 
 */

@Controller
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	/*   返回所有部门信息	  */
	
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts()
	{
		List<Department> list = departmentService.getDepts();
		
		return Msg.success().add("depts", list);
	}

}
