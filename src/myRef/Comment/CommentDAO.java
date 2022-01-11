package myRef.Comment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import myRef.ConnectionDAO;
import myRef.Comment.CommentDTO;

public class CommentDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 댓글 입력
	public void insertRecipeComment(CommentDTO recipeComment) {
		try {
			conn = ConnectionDAO.getConn();
			String tableName = "recipe_comment_"+recipeComment.getNum(); 	// 댓글테이블 이름
			String sql = "insert into "+tableName+" values("+tableName+"_seq.NEXTVAL,?,?,?,?,"+tableName+"_seq.CURRVAL,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, recipeComment.getComment_id());
			pstmt.setString(2, recipeComment.getComment_text());
			pstmt.setTimestamp(3, recipeComment.getReg_date());
			pstmt.setInt(4, recipeComment.getNum());
			pstmt.setInt(5, recipeComment.getRe_step());
			pstmt.setInt(6, recipeComment.getRe_level());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	// 대댓글 입력
	public void insertRecipeComment(CommentDTO recipeComment, int comment_num) {
		try {
			String sql = "";
			String tableName = "recipe_comment_"+recipeComment.getNum(); 	// 댓글테이블 이름
			int ref = 0;
			int re_step = 0;
			int re_level = 0;
			
			conn = ConnectionDAO.getConn();
			pstmt = conn.prepareStatement("select * from "+tableName+" where comment_num=?");
			pstmt.setInt(1, comment_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {	 			// 대댓글 작성
				ref = rs.getInt("ref");
				System.out.println("ref : "+ref);
				re_step = rs.getInt("re_step");
				re_level = rs.getInt("re_level");
				
				if(ref == 0) {			// 새로둔 대댓글인 경우
					pstmt = conn.prepareStatement("select max(re_step) from "+tableName+" where ref=?");
					pstmt.setInt(1, ref);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						re_step = rs.getInt(1) + 1;
					}
				}else {					// 기존 대댓글의 대댓글인 경우
					sql = "update "+tableName+" set re_step = re_step+1 where ref=? and re_step > ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
					pstmt.setInt(2, re_step);
					pstmt.executeUpdate();
					re_step = re_step + 1;
				}
			}
			
			sql = "insert into "+tableName+" values("+tableName+"_seq.NEXTVAL,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, recipeComment.getComment_id());
			pstmt.setString(2, recipeComment.getComment_text());
			pstmt.setTimestamp(3, recipeComment.getReg_date());
			pstmt.setInt(4, recipeComment.getNum());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level + 1);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	public int deleteArticle_comment(int num,int listNum, String id,int comment_pageNum) throws Exception
	{
		int getListNum = listNum + (10*(comment_pageNum-1));
		int x = -1;
		String seqName = "recipe_comment_"+num+"_seq";
		String tableName = "recipe_comment_"+num;
		try 
		{
			conn = ConnectionDAO.getConn();
			String sql = "select "+seqName+",comment_id,comment_text,reg_date,ref,re_step,re_level,r "
					+"from (select "+seqName+",comment_id,comment_text,reg_date,ref,re_step,re_level,rownum r "
				     +"from (select "+seqName+",comment_id,comment_text,reg_date,ref,re_step,re_level "
				            +"from "+tableName+" order by ref asc, re_step asc) order by ref asc, re_step asc ) "
				+"where r="+getListNum;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int dbRef = 0;
			int dbRe_step = 0;
			if(rs.next())
			{
				dbRef = rs.getInt("ref");
				dbRe_step = rs.getInt("re_step");
				
				sql = "delete from "+tableName+" where ref = "+dbRef+" and re_step="+dbRe_step;
				pstmt = conn.prepareStatement(sql);
				pstmt.executeUpdate();
				x = 1;
			}
			else 
			{
				x = 0;
			}
			/*while(rs.next() && x != 1)
			{
				String dbId = rs.getString("comment_id");
				int rowNum = rs.getInt("rownum");
				int seqNum = rs.getInt(seqName);
				if(dbId.equals(id) && rowNum == listNum)
				{
					sql="delete from "+tableName+" where "+seqName+"="+seqNum;
					pstmt = conn.prepareStatement(sql);
					pstmt.executeUpdate();
					x = 1;
				}
				else
				{
					x = 0;
				}
			}*/
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			ConnectionDAO.close(rs, pstmt, conn);
		}
		if(getListNum % 10 == 1 && getListNum != 1)
		{
			x = 2;
		}
		return x;
	}
	
	
	public int getCommentCount(int num) {
		int count = 0;
		try {
			conn = ConnectionDAO.getConn();
			pstmt = conn.prepareStatement("select count(*) from recipe_comment_"+num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return count;
	}
	
	public List<CommentDTO> getComments(int start,int end,int tableNum ) throws Exception
	{
		List<CommentDTO> commentList=null;
		String tableName = "recipe_comment_"+tableNum;
		try
		{
			conn = ConnectionDAO.getConn();
			String sql = "select * from (select comment_id, comment_num, comment_text,reg_date,ref,re_step,re_level,rownum r " +
					"from (select comment_id, comment_num, comment_text,reg_date,ref,re_step,re_level " +
					"from "+tableName+" order by ref asc, re_step asc) order by ref asc, re_step asc ) where r >= ? and r <= ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();

			if(rs.next())
			{
				commentList = new ArrayList<CommentDTO>(end);
				do
				{
					CommentDTO comment = new CommentDTO();					
					comment.setComment_num(rs.getInt("comment_num"));
					comment.setComment_id(rs.getString("comment_id"));
					comment.setComment_text(rs.getString("comment_text"));
					comment.setReg_date(rs.getTimestamp("reg_date"));
					comment.setRe_level(rs.getInt("re_level"));
					commentList.add(comment);
				}
				while(rs.next());
			}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return commentList;
	}
	
	// 댓글 삭제시 '삭제된 댓글입니다'로 내용 변경
	public boolean deleteRecipeComment(int num, int comment_num) {
		String tableName = "recipe_comment_"+num;
		boolean result = false;
		try {
			conn = ConnectionDAO.getConn();
			pstmt = conn.prepareStatement("update "+tableName+" set comment_text='삭제된 댓글입니다.' where comment_num=?");
			pstmt.setInt(1, comment_num);
			pstmt.executeUpdate();
			result = true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return result;
	}
	
	// 댓글 작성자 반환
	public String getRecipeComment_id(int num, int comment_num) {
		String comment_id = null;
		String tableName = "recipe_comment_"+num;
		try {
			conn = ConnectionDAO.getConn();
			pstmt = conn.prepareStatement("select comment_id from "+tableName+" where comment_num=?");
			pstmt.setInt(1, comment_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				comment_id = rs.getString("comment_id");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return comment_id;
	}
}
