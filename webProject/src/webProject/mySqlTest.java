package webProject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;



public class mySqlTest {
	public static void main(String[] args) {
        Connection connection = null;
        Statement st = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://192.168.100.64:3306/test" , "test", "123456");
            st = connection.createStatement();
 
            String sql;
            sql = "select * FROM USER;";
 
            ResultSet rs = st.executeQuery(sql);
 
            while (rs.next()) {
                //String sqlRecipeProcess = rs.getString("test_id");
                System.out.println(rs.getString("usrid"));
                System.out.println(rs.getString("username"));
            }
 
            rs.close();
            st.close();
            connection.close();
        } catch (SQLException se1) {
            se1.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (st != null)
                    st.close();
            } catch (SQLException se2) {
            }
            try {
                if (connection != null)
                    connection.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }    
    }

}



