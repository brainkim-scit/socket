package global.sesoc.board.dao.reply;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.board.vo.reply;

public interface replyMapper {

	public int insert(reply reply);
	public int delete(reply reply);
	public int modify(reply reply);
	public ArrayList<Integer> count();
	public ArrayList<reply> selectAll(int boardno, RowBounds rb);
	public int getTotalCount(int boardno);

}
