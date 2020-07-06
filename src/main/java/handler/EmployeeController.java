package handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import entity.Employee;
import entity.Msg;
import service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeservice;

	
	
	//删除员工 
	//单个删除： 一个id
	//多个删除：1-2-3 shiyong-连接
	@RequestMapping(value="/emp/{ids}" ,method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids") String ids)
	{
		if(ids.contains("-"))
		{
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			
			for(String str : str_ids)
			{
				del_ids.add(Integer.parseInt(str));
			}
				
			employeeservice.deleteBatch(del_ids);
		}
		else
		{
			employeeservice.deleteEmp(Integer.parseInt(ids));
		}
		
		
		
		return Msg.success();
	}
	
	
	//更新员工
	@RequestMapping(value="/emp/{empId}" ,method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee)
	{
		System.out.println(employee);
		
		employeeservice.updateEmp(employee);
		
		return Msg.success();
	}
	
	
	//根据id查询员工
	@RequestMapping(value = "/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id)
	{
		Employee employee = employeeservice.getEmp(id);
				
		return Msg.success().add("emp", employee);
	}
	
	
	//ajax检查用户名是否可用（重名）
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkUser(@RequestParam("empName")  String empName)
	{
		//先判断用户名是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx))
		{
			return Msg.fail().add("va_msg", "ajax校验错误：用户名可以是2-5位中文或者4-16位英文");
		}
		
		//再进行数据库重名校验
		boolean b = employeeservice.checkUser(empName);
		
		if(b)
		{
			return Msg.success().add("va_msg","ajax校验：用户名可用");
		}
		else
		{
			return Msg.fail().add("va_msg","ajax校验：用户名不可用");
		}
	
	}
	
	
	//员工保存 
	//1、支持JSR303校验
	//2、导入Hibernate-Validator
	@RequestMapping(value="/emp",method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result)
	{
		if(result.hasErrors())
		{
			List<FieldError> fieldErrors = result.getFieldErrors();
			Map<String,Object> map = new HashMap<>();
			for(FieldError fe :fieldErrors)
			{
				System.out.println(fe.getField()+":"+fe.getDefaultMessage());
				map.put(fe.getField(), fe.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		else
		{
			employeeservice.saveEmp(employee);
			return Msg.success();
		}
	}
	
	
	//Jason字符串方式返回查询员工信息
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn" , defaultValue="1") Integer pn)
	{
		//引入PageHelper分页插件
		//传入页码和每页数量，startPage后面接着的查询就是分页查询
		PageHelper.startPage(pn,10);
		
		List<Employee>  emps = employeeservice.getAll();
		
		//使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行，封装了详细的分页信息以及查询出来的数据
		PageInfo page = new PageInfo(emps,5);//连续显示5页			
		
		return Msg.success().add("pageInfo", page);
	}
	
	
	//传统MVC方式查询员工
	  @RequestMapping("/empss") 
	  public String getEmps(@RequestParam(value = "pn" ,defaultValue="1") Integer pn,Model model) 
	  { 
		  //引入PageHelper分页插件
		  //传入页码和每页数量，startPage后面接着的查询就是分页查询
	
		  PageHelper.startPage(pn,5);
		  
		  List<Employee> emps = employeeservice.getAll();
		  
		  //使用PageInfo包装查询后的结果，只需要将PageInfo交给页面就行，封装了详细的分页信息以及查询出来的数据 
		  PageInfo page =	  new PageInfo(emps,5);//连续显示5页
		  
		  model.addAttribute("pageInfo", page);
	  
		  return "list";
	  
	  
	  }
	 
	  
	
	
}
