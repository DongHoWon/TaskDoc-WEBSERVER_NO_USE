package com.taskdoc.www.database.dao.userinfo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.UserInfoVO;

@Repository
public class UserInfoDAOImpl implements UserInfoDAO {
	
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "userinfo_SQL.";
	private final String INSERT = "insert";
	private final String VIEW = "view";
	private final String UPDATE = "update";
	private final String DELETE = "delete";

	@Override
	public UserInfoVO userInfoView(String userId) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, userId);
	}
	
	@Override
	public int insertUserInfo(UserInfoVO userInfoVo) {
		// TODO Auto-generated method stub
		try {
			return sql.insert(NAMESPACE + INSERT, userInfoVo);
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int updateUserInfo(UserInfoVO userInfoVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, userInfoVo);
	}
	
	@Override
	public int deleteUserInfo(String userId) {
		// TODO Auto-generated method stub
		 return sql.delete(NAMESPACE + DELETE, userId);
	}
}
