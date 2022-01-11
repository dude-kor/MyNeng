package member.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class ManagerDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	// 전체 회원수
	public int getMemberCount() {
		int membercount = 0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from member where master=0");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				membercount = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return membercount;
	}

	// 탈퇴 회원수
	public int getquitMemberCount() {
		int membercount = 0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from member where master=3");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				membercount = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return membercount;
	}

	public List<String> getallMemberId() {
		List<String> memId = null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select id from member where master=0");
			rs = pstmt.executeQuery();
			memId = new ArrayList<String>();
			while (rs.next()) {
				memId.add(rs.getString("id"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return memId;
	}

	public List<Integer> getallRecipeNum() {
		List<Integer> recipenum = null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select num from recipe");
			rs = pstmt.executeQuery();
			recipenum = new ArrayList<Integer>();
			while (rs.next()) {
				recipenum.add(rs.getInt("num"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return recipenum;
	}

	public HashMap<Integer, Integer> getScrapCount() {
		HashMap<Integer, Integer> scrapcount = null;
		List<String> memId = getallMemberId();
		List<Integer> recipenum = getallRecipeNum();
		scrapcount = new HashMap<Integer, Integer>();

		for (int j = 0; j < recipenum.size(); j++) {
			scrapcount.put(recipenum.get(j), 0);
		}
		
		  for (int i = 0; i < memId.size(); i++) {
		  
				try {
					conn = ConnectionDAO.getConnection();
					String sc = memId.get(i) + "_scrap";
					pstmt = conn.prepareStatement("select rec_id from " + sc);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						int num = rs.getInt("rec_id");
						int last = scrapcount.get(num);
						scrapcount.put(num, ++last);
						// System.out.println(num + " " + scrapcount.get(num));

					} } catch (Exception e) { e.printStackTrace(); 
					} finally {ConnectionDAO.close(rs, pstmt, conn); } 
			}
		 

		return scrapcount;

	}
	
	public List <String> getGrooupId(){
		List <String> g_name = null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select distinct group_id from member where master=0");
			rs = pstmt.executeQuery();
			g_name  = new ArrayList<String>();
			while (rs.next()) {
				g_name.add(rs.getString("group_id"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		
		
		return g_name;
	}
	
	public List <String> getGroupMember(String ref_id) {
		List <String> group = null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select name from member where group_id = ?");
			pstmt.setString(1, ref_id);
			rs = pstmt.executeQuery();
			group  = new ArrayList<String>();
			while (rs.next()) {
				group.add(rs.getString("name"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return group;
	}
	
	public boolean checkIng(String name) {
		boolean check = false;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from ingredient where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				check = true;
			}
		} catch(Exception e) {e.printStackTrace();}
		finally {ConnectionDAO.close(rs,pstmt,conn);}
		return check;
	}
	
	public void addIngredient(String name) {
		try {
			conn = ConnectionDAO.getConnection(); // 그룹비밀번호 회원가입 랜덤으로 그룹비밀번호 지정하기
			
			String sql = "insert into ingredient values(ing_seq.NEXTVAL,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, name);

			pstmt.executeUpdate();//insert			
		}catch(Exception e) {e.printStackTrace();}
		finally {ConnectionDAO.close(rs,pstmt,conn);}
	}
	
	public HashMap <String, Integer> getDayTotal() {
		HashMap <String, Integer> daytotal  = null;
		/*
		 * SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		 * 
		 * Date day = new Date();
		 */
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -7);
		daytotal = new HashMap<String, Integer>();
		for(int i = 0; i < 7; i++) {
			cal.add(Calendar.DAY_OF_MONTH, 1);
			String day = format.format(cal.getTime());
			//System.out.println(day);
			daytotal.put(day, 0);
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select count(*) from recipe where day like '%" + day + "%'");
				//pstmt.setString(1, day);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					int count = rs.getInt(1);
					daytotal.put(day, count);
					System.out.println(daytotal);
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
		}
		
		
		
		
		return daytotal;
	}
	
	//날짜별 레시피 게시글 갯수
	public int getcount(String day) {
		int count = 0; 
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from recipe where day like '%" + day + "%'");
			//pstmt.setString(1, day);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return count;
	}
	
	//날짜별 공동구매 게시글 갯수
	public int groupbuyingcount(String day) {
		int count = 0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from groupbuying_board where reg_date like '%" + day + "%'");
			//pstmt.setString(1, day);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return count;
	}
	
	//날짜별 레시피요청 게시글 갯수
	public int recipeRequestcount(String day) {
		int count = 0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from reciperequest_board where reg_date like '%" + day + "%'");
			//pstmt.setString(1, day);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return count;
	}
	
	//날짜별 쇼핑정보공유 게시글 갯수
	public int shoppingcount(String day) {
		int count = 0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from sis_board where reg_date like '%" + day + "%'");
			//pstmt.setString(1, day);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return count;
	}
	
	public List <String> getIng() {
		List <String> ing =null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select name from ingredient");
			rs = pstmt.executeQuery();
			ing  = new ArrayList<String>();
			while (rs.next()) {
				ing.add(rs.getString("name"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return ing;
	}
}
