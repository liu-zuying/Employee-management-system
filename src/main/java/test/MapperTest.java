package test;


import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import dao.DepartmentMapper;
import dao.EmployeeMapper;
import entity.Department;
import entity.Employee;
import service.EmployeeService;


@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext-spring.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeService es;
	
	@Autowired
	EmployeeMapper employee;
	

	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void test()
	{
		/*
		 * ApplicationContext ioc = new ClassPathXmlApplicationContext();
		 * 
		 * DepartmentMapper dMapper=ioc.getBean(DepartmentMapper.class);
		 */
		
		//使用spring的单元测试
		
		System.out.println(departmentMapper);
		System.out.println(es);
		
	//	departmentMapper.insertSelective(new Department(1, "测试部"));
	//	departmentMapper.insertSelective(new Department(2, "销售部"));
	
	//	employee.insertSelective(new Employee(1, "张三", "m", "qq@qq.com", 1));
		
		/*
		 * EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
		 * 
		 * for(int i = 0;i<1000;i++) 
		 * { 
		 * 		String uid=UUID.randomUUID().toString().substring(0, 5)+i;
		 * 		mapper.insertSelective(new Employee(null, uid, "m", uid+"@edu.com", 1)); 
		 * }
		 */
		
	}

}
