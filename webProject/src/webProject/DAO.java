package webProject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import webProject.Vo;

public class DAO {
	private Connection conn;
	private ResultSet rs;
	
	public DAO() {
		try {
			String dbURL = "jdbc:mysql://192.168.100.71:3306/android";   
			String dbID = "root";
			String dbPassword = "dlguswn#123";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Vo regId(String ID)
	{
		
		String SQL = "SELECT ID FROM MEMBER WHERE ID='"+ID+"'";
		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			if(rs.next()) 
			{
				Vo vo = new Vo();
				vo.setID(rs.getString(1));
				
				return vo;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	public Vo login(String ID, String PWD) {
		
		String SQL = "SELECT ID,PWD,TYPE FROM MEMBER WHERE ID='"+ID+"' AND PWD='"+PWD+"'";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Vo vo = new Vo();
				vo.setID(rs.getString(1));
				vo.setPWD(rs.getString(2));
				vo.setTYPE(Integer.parseInt(rs.getString(3)));
				
				return vo;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int addMember(String ID, String PWD, String NAME,String ip, String port) {
		
		String SQL = "INSERT INTO MEMBER(ID,PWD,NAME,IP,PORT,TYPE) VALUES(?,?,?,?,?,0)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, ID);
			pstmt.setString(2, PWD);
			pstmt.setString(3, NAME);
			pstmt.setString(4, ip);
			pstmt.setString(5, port);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}
