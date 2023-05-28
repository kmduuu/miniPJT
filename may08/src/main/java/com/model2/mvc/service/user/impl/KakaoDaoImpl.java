package com.model2.mvc.service.user.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.kakao.KakaoDao;

@Repository("KakaoDaoImpl")
public class KakaoDaoImpl implements KakaoDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public KakaoDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("KakaoMapper.addUser", user);
		System.out.println("카카오 매퍼 유저 저장");
	}

	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("카카오 유저 불러오기");
		return sqlSession.selectOne("KakaoMapper.getUser", userId);
	}

	@Override
	public boolean checkDuplication(String userId) throws Exception {
		boolean result = true;
		User user = sqlSession.selectOne("KakaoMapper.getUser", userId);
		if(user==null) {
			result = false;
		}
		
		return result;
	}
	
}
