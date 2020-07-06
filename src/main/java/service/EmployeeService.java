package service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.EmployeeMapper;
import entity.Employee;
import entity.EmployeeExample;
import entity.EmployeeExample.Criteria;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	//查询所有员工
	public List<Employee> getAll()
	{
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	//保存员工
	public void saveEmp(Employee employee)
	{
		employeeMapper.insertSelective(employee);
	}
	
	//检验员工: count！=0表示用户名存在，不可用，return false
	public boolean checkUser(String empName)
	{
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		
		return count==0;
	}

	//根据id查询员工
	public Employee getEmp(Integer id) {
	
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		
		return employee;
	}
	
	//更新员工
	public void updateEmp(Employee employee) {
		
		employeeMapper.updateByPrimaryKeySelective(employee);
		
	}

	//删除员工
	public void deleteEmp(Integer id) {
		
		employeeMapper.deleteByPrimaryKey(id);
	}

	//批量删除员工
	public void deleteBatch(List<Integer> ids) {
		
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in ids
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
		
	}
	
	
	
	
}
