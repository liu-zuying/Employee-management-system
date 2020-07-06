package test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;

import entity.Employee;

@RunWith(value = SpringJUnit4ClassRunner.class)
@WebAppConfiguration //通过该注解获取springmvc的IOC
@ContextConfiguration(locations= {"classpath:applicationContext-spring.xml","classpath:applicationContext-springMVC.xml"})
public class MvcTest {
	
	//传入springMvc的IOC
	@Autowired
	WebApplicationContext context;
	//虚拟MVC的请求，获取处理结果
	MockMvc mockMvc;
	
	@Before
	public void initMocKmVC()
	{
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception
	{
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "2")).andReturn();
		
		//请求成功后，请求域中有pageinfo，可以取出进行验证
		MockHttpServletRequest request = result.getRequest();
		
		PageInfo attribute = (PageInfo)request.getAttribute("pageInfo");
		
		//获取分页信息
		System.out.println("当前页码 "+attribute.getPageNum());
		System.out.println("总页码 "+attribute.getPages());
		System.out.println("总记录数 "+attribute.getTotal());
		System.out.println("页面需要连续显示的页码");
		int[] nums = attribute.getNavigatepageNums();		
		for(int e:nums)
		{
			System.out.println(" "+e);
		}
		
		//获取员工数据
		List<Employee> list = attribute.getList();
		for(Employee e :list)
		{
			System.out.println("id"+e.getdId()+":"+e.getEmpName());
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
