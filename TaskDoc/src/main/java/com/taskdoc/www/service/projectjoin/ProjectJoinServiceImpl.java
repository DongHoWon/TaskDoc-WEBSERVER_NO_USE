package com.taskdoc.www.service.projectjoin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taskdoc.www.database.dao.chatroomjoin.ChatRoomJoinDAO;
import com.taskdoc.www.database.dao.project.ProjectDAO;
import com.taskdoc.www.database.dao.projectjoin.ProjectJoinDAO;
import com.taskdoc.www.database.dao.userinfo.UserInfoDAO;
import com.taskdoc.www.database.dto.ChatRoomJoinVO;
import com.taskdoc.www.database.dto.ProjectJoinVO;
import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.database.dto.UserInfoVO;

@Service("ProjectJoinService")
public class ProjectJoinServiceImpl implements ProjectJoinService {

	@Autowired
	ProjectJoinDAO joinDao;

	@Autowired
	UserInfoDAO userDao;

	@Autowired
	ProjectDAO projectDao;

	@Autowired
	ChatRoomJoinDAO chatRoomJoinDao;

	@Override
	public Map<String, Object> projectJoinList(String uid) {
		Map<String, Object> map = new HashMap<>();
		List<ProjectVO> projectList = new ArrayList<>();

		List<ProjectJoinVO> projectJoinList = joinDao.projectJoinList(uid);

		for (ProjectJoinVO vo : projectJoinList) {
			projectList.add(projectDao.projectView(vo.getPcode()));
		}

		map.put("projectList", projectList);
		map.put("projectJoinList", projectJoinList);

		return map;
	}

	@Override
	public Map<String, Object> projectJoinListUser(int pcode) {
		List<ProjectJoinVO> userJoinListAll = joinDao.projectJoinListUser(pcode);

		List<ProjectJoinVO> joinList = new ArrayList<>();
		List<UserInfoVO> userList = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();

		for (ProjectJoinVO vo : userJoinListAll) {
			userList.add(userDao.userInfoView(vo.getUid()));
			joinList.add(vo);
		}

		map.put("userInfoList", userList);
		map.put("projectJoinList", joinList);

		return map;
	}

	@Override
	public int projectJoinInsert(ProjectJoinVO projectJoinVo) {
		projectJoinVo.setPinvite(0);
		projectJoinVo.setPpermission("MEMBER");
		return joinDao.projectJoinInsert(projectJoinVo);
	}

	@Override
	@Transactional
	public int projectJoinUpdate(ProjectJoinVO projectJoinVo) {
		int result = joinDao.projectJoinUpdate(projectJoinVo);

		int crcode = chatRoomJoinDao.crcodeMin(projectJoinVo.getPcode());
		ChatRoomJoinVO chatRoomJoinVo = new ChatRoomJoinVO();
		chatRoomJoinVo.setCrcode(crcode);
		chatRoomJoinVo.setPcode(projectJoinVo.getPcode());
		chatRoomJoinVo.setUid(projectJoinVo.getUid());
		chatRoomJoinDao.chatRoomJoinInsert(chatRoomJoinVo);

		return result;
	}

	@Override
	public int projectJoinDelete(ProjectJoinVO projectJoinVo) {
		return joinDao.projectJoinDelete(projectJoinVo);
	}

	@Override
	public List<ProjectJoinVO> projectSelectid(ProjectJoinVO projectJoinVo) {
		return joinDao.projectSelectid(projectJoinVo);
	}

}
