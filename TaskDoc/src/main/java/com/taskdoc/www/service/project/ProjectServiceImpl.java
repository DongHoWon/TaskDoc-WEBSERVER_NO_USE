package com.taskdoc.www.service.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.project.ProjectDAO;
import com.taskdoc.www.database.dao.projectjoin.ProjectJoinDAO;
import com.taskdoc.www.database.dto.ChatRoomVO;
import com.taskdoc.www.database.dto.ProjectJoinVO;
import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.database.dto.PublicTaskVO;
import com.taskdoc.www.database.dto.UserInfoVO;
import com.taskdoc.www.service.chatroom.ChatRoomService;
import com.taskdoc.www.service.publictask.PublicTaskService;

@Service("ProjectService")
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	ProjectDAO projectDao;
	
	@Autowired
	ProjectJoinDAO projectJoinDao;
	
	@Autowired
	PublicTaskService publicTaskService;
	
	@Autowired
	ChatRoomService chatRoomService;
	
	@Override
	@Transactional
	public int projectInsert(ProjectVO projectVo, UserInfoVO userInfoVo) throws Exception{
		// TODO Auto-generated method stub
		int pcode = projectDao.projectInsert(projectVo);
		
		PublicTaskVO publicTaskVo = new PublicTaskVO();
		publicTaskVo.setTtitle("OUTPUT");
		publicTaskVo.setTcolor("f0f0ff");
		publicTaskVo.setPcode(pcode);
		publicTaskService.publicTaskInsert(publicTaskVo);
		
		ChatRoomVO chatRoomVo = new ChatRoomVO();
		chatRoomVo.setCrmode(1);
		try {
			chatRoomService.chatRoomInsert(chatRoomVo, userInfoVo, projectVo);
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
		
		ProjectJoinVO projectJoinVo = new ProjectJoinVO();
		projectJoinVo.setPcode(pcode);
		projectJoinVo.setUid(userInfoVo.getUid());
		projectJoinVo.setPpermission("OWNER");
		projectJoinVo.setPinvite(1);
		projectJoinDao.projectJoinInsert(projectJoinVo);
		return pcode;
	}

	@Override
	public int projectUpdate(ProjectVO projectVo) {
		// TODO Auto-generated method stub
		return projectDao.projectUpdate(projectVo);
	}

	@Override
	public int projectDelete(int pcode) {
		// TODO Auto-generated method stub
		return projectDao.projectDelete(pcode);
	}

}
