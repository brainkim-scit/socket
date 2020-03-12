package global.sesoc.board.dao.guestbook;

import java.util.ArrayList;
import java.util.HashMap;

import global.sesoc.board.vo.guestbook;

public interface guestbookMapper {

	public int insert(guestbook guest);
	public ArrayList<guestbook> selectAll();
	public ArrayList<guestbook> search(HashMap<String, Object> map);
	public guestbook select(int seqno);
	public void delete(int seqno);
	public void update(guestbook guest);
}
