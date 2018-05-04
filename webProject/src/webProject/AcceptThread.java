package webProject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
 
public class AcceptThread implements Runnable {
 
    ServerSocket serverSocket;
    Socket client;
    
    InputStream is = null;
    InputStreamReader isr = null;
    BufferedReader br = null;

    
    public void receiveData(String data, Socket socket){
        OutputStream os = null;
        OutputStreamWriter osw = null;
        BufferedWriter bw = null;
        
        try{
            os = socket.getOutputStream();
            osw = new OutputStreamWriter(os);
            bw = new BufferedWriter(osw);
            // 클라이언트로부터 데이터를 보내기 위해 OutputStream 선언
            
          Connection conn = null;
      	  String prvBlockHash = null;
      	  String transaction = data;
      	  //System.out.println(transaction);
      	  
      	  try {
      		Class.forName("org.sqlite.JDBC");
      		conn = DriverManager.getConnection("jdbc:sqlite:C:\\data\\data.db","admin1","1234");
      		//System.out.println(sql);
      		try {
      			Statement stmt =conn.createStatement();
      			ResultSet rs = stmt.executeQuery("select blockHash from BLOCK order by loginTime DESC");
      			if (rs.next())
      			{	
      				//새로 생성한 블록의 이전블록해시와 타 노드의 블록해시값을 비교하여 참 거짓 판단
      				prvBlockHash = rs.getString("blockHash");
      				if(data.equals(prvBlockHash))
      				{
      					transaction="참 : 이전블록해시"+prvBlockHash;
      				}else
      				{
      					transaction="거짓 : 이전블록해시"+prvBlockHash;
      				}
      				//System.out.println(prvBlockHash);
      				/*
      				Block genesisBlock = new Block(transaction,prvBlockHash); //로그인 데이터과 이전 블록의 해쉬값으로 현재 블록을 생성한다.
      				System.out.println("Hash for block 1 : " + genesisBlock.hash);
      				// 다른 네트워크 에 블록 전송
      				
      				String sql = "insert into BLOCK(prvBlockHash,blockHash,data, loginTime) values ('"+prvBlockHash+"', '"+genesisBlock.hash+"', '"+genesisBlock.data+"', datetime('now'));";
      				stmt.executeUpdate(sql);
      				*/
      			
      			}else
      			{
      				
      			}
      			rs.close();
      			stmt.close();
      			conn.close();
      		} catch (SQLException e) {
      			conn.close();
      			// TODO Auto-generated catch block
      			e.printStackTrace();
      		}
      	} catch (ClassNotFoundException e1) {
      		// TODO Auto-generated catch block
      		e1.printStackTrace();
      	} 
         // sqlite 접속 끝
            bw.write(transaction);            // 클라이언트로 데이터 전송
            bw.flush();
        }catch(Exception e1){
            e1.printStackTrace();
        }finally {
            try{
                bw.close();
                osw.close();
                os.close();
                //socket.close();
            }catch(Exception e1){
                e1.printStackTrace();
            }
        }
    }

    
    public void insertData(String sql, Socket socket){
        OutputStream os = null;
        OutputStreamWriter osw = null;
        BufferedWriter bw = null;
        
        try{
            os = socket.getOutputStream();
            osw = new OutputStreamWriter(os);
            bw = new BufferedWriter(osw);
            // 클라이언트로부터 데이터를 보내기 위해 OutputStream 선언
            
          Connection conn = null;
      	  try {
      		Class.forName("org.sqlite.JDBC");
      		conn = DriverManager.getConnection("jdbc:sqlite:C:\\data\\data.db","admin1","1234");
      		try {
      			Statement stmt =conn.createStatement();
      			System.out.println("insert 문 : " + sql);
      			stmt.executeUpdate(sql);
      			stmt.close();
      			conn.close();
      		} catch (SQLException e) {
      			conn.close();
      			// TODO Auto-generated catch block
      			e.printStackTrace();
      		}
      	} catch (ClassNotFoundException e1) {
      		// TODO Auto-generated catch block
      		e1.printStackTrace();
      	} 
         // sqlite 접속 끝
            bw.write(sql);            // 클라이언트로 데이터 전송
            bw.flush();
        }catch(Exception e1){
            e1.printStackTrace();
        }finally {
            try{
                bw.close();
                osw.close();
                os.close();
                //socket.close();
            }catch(Exception e1){
                e1.printStackTrace();
            }
        }
    }


    
    public AcceptThread(ServerSocket serverSocket) {
        this.serverSocket = serverSocket;
    }
 
    @Override
    public void run() {
        while (true) {
        	
            try {
            	System.out.println("-------접속 대기중------");
            	client = serverSocket.accept();         // 클라이언트가 접속하면 통신할 수 있는 소켓 반환
                System.out.println(client.getInetAddress() + "로 부터 연결요청이 들어옴");
                if(!client.isClosed())
                {
	                is = client.getInputStream();
	                isr = new InputStreamReader(is);
	                br = new BufferedReader(isr);
	                // 클라이언트로부터 데이터를 받기 위한 InputStream 선언
	                
	                String data=null;
	                data=br.readLine();
	                System.out.println("클라이언트로 부터 받은 data:" + data);
	                
	                if(data.substring(0, 7).equals("insert "))
	                {
	                	insertData(data, client);        
	                }else
	                {
	                	receiveData(data, client);       
	                }
	                System.out.println("****** 처리 완료 ****");
                }
                //break;

            } catch (Exception e) {
            	e.printStackTrace();
			}finally {
                try{
                    br.close();
                    isr.close();
                    is.close();
                    //serverSocket.close();
                }catch(Exception e){
                    e.printStackTrace();
                }
            }


        }
    }
}
