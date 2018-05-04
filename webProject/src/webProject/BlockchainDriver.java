package webProject;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;



public class BlockchainDriver {
 
  List<Block> blockchain = new ArrayList<Block>();
 
  public static void main(String[] args) throws NoSuchAlgorithmException {
 
	  //BlockChain(args);
	  
  }
  
  
public static void BlockChain(String string) throws Exception , NoSuchAlgorithmException, SQLException 
{
		
	  Connection conn = null;
	  String prvBlockHash = null;
	  String transaction = string;
	  System.out.println(transaction);
	  
	  try {
		Class.forName("org.sqlite.JDBC");
		conn = DriverManager.getConnection("jdbc:sqlite:C:\\data\\data.db","admin1","1234");
		//System.out.println(sql);
		try {
			Statement stmt =conn.createStatement();
			ResultSet rs = stmt.executeQuery("select blockHash from BLOCK order by loginTime DESC");
			if (rs.next())
			{	
				prvBlockHash = rs.getString("blockHash");
				Block genesisBlock = new Block(transaction,prvBlockHash); //로그인 데이터과 이전 블록의 해쉬값으로 현재 블록을 생성한다.
				// insert문 생성
				String sql = "insert into BLOCK(prvBlockHash,blockHash,data, loginTime) values ('"+prvBlockHash+"', '"+genesisBlock.hash+"', '"+genesisBlock.data+"', datetime('now','localtime'));";
				
				/*sqlite 와 접속 종료하지 않으면 error발생*/
				rs.close();
	  			stmt.close();
				conn.close();
				try {
					sendBlock(prvBlockHash,sql);
				}catch(Exception ex) {
    	            //ex.printStackTrace();
    				throw ex;
    	        }
			
			}else
			{
				
			}
			
		} catch (SQLException e) {
			
			conn.close();
			// TODO Auto-generated catch block
			throw e;
		}
	} catch (ClassNotFoundException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	} 

  }
	//다른 네트워크 에 블록 전송
	public static void 	sendBlock(String hash, String insertSql) throws SQLException, Exception
	{
		Connection connection = null;
        Statement st = null;
        Statement st_user = null;
        ResultSet rs = null;
        ResultSet rs_insert = null;
        String ip = null;
        int user = 0;
        int port=0;
        try {
        	//네트워크에 등록된 사용자 불어오기
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://192.168.100.65:3306/test" , "test", "123456");
            st = connection.createStatement();
            st_user = connection.createStatement();
 
            String sql;
            sql = "select IP,PORT FROM USER;";
 
            rs = st.executeQuery(sql);
            rs_insert =st_user.executeQuery(sql);
            /*
            while (rs.next()) {
                
                System.out.println(rs.getString("IP"));
                System.out.println(rs.getString("PORT"));
                
                cd9001ff253416a7cd00f5c88bf94b5cc99290668ce047f28f093cb52b346a57
                cd9001ff253416a7cd00f5c88bf94b5cc99290668ce047f28f093cb52b346a57
            }
            */
            
            InetAddress myIp = InetAddress.getLocalHost();
            String myAdress = myIp.getHostAddress().toString();
            
            //클라이언트 생성
            Client cm = new Client();
            
            
    		//네트워크에 값 전송
    		while (rs.next()) {
    			
    			ip = rs.getString("IP");
    			
             	//본인 IP제외 소스 코드 추가
    			if(myAdress.equals(ip))  
    			{
    				continue;
    			}
    			user++;
    			port = Integer.parseInt(rs.getString("PORT"));
    			cm.ClientRun(ip,port,hash);

    		}
            
            
            System.out.println("나를 제외한 MySql에 등록된 사용자의 수 :"+user);

    		if(cm.cnt > user/2)
			{
				System.out.println("참 블록");
				while (rs_insert.next()) {
	    			ip = rs_insert.getString("IP");
	    			port = Integer.parseInt(rs_insert.getString("PORT"));
	    			cm.ClientInsert(ip,port,insertSql);
	    		}
			}
			else
			{
				System.out.println("거짓블록");
			}

            rs.close();
            rs_insert.close();
            st.close();
            connection.close();
        } catch (SQLException se1) {
            se1.printStackTrace();
        } catch (Exception ex) {
			throw ex;
        } finally {
            try {
                if (st != null)
                {
                	st.close();
                }else if(st_user != null)
                {
                	st_user.close();
                }
                    
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