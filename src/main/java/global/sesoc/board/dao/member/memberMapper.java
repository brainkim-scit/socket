package global.sesoc.board.dao.member;

import java.util.HashMap;

import global.sesoc.board.vo.member;

public interface memberMapper {

	public int signup(member member);
	public member login(String id);
	public int check(member member);
	public void delete(HashMap<String, Object> map);
	public void update(member member);
}
