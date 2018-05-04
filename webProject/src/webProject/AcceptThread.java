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
            // Ŭ���̾�Ʈ�κ��� �����͸� ������ ���� OutputStream ����
            
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
      				//���� ������ ����� ��������ؽÿ� Ÿ ����� ����ؽð��� ���Ͽ� �� ���� �Ǵ�
      				prvBlockHash = rs.getString("blockHash");
      				if(data.equals(prvBlockHash))
      				{
      					transaction="�� : ��������ؽ�"+prvBlockHash;
      				}else
      				{
      					transaction="���� : ��������ؽ�"+prvBlockHash;
      				}
      				//System.out.println(prvBlockHash);
      				/*
      				Block genesisBlock = new Block(transaction,prvBlockHash); //�α��� �����Ͱ� ���� ����� �ؽ������� ���� ����� �����Ѵ�.
      				System.out.println("Hash for block 1 : " + genesisBlock.hash);
      				// �ٸ� ��Ʈ��ũ �� ��� ����
      				
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
         // sqlite ���� ��
            bw.write(transaction);            // Ŭ���̾�Ʈ�� ������ ����
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
            // Ŭ���̾�Ʈ�κ��� �����͸� ������ ���� OutputStream ����
            
          Connection conn = null;
      	  try {
      		Class.forName("org.sqlite.JDBC");
      		conn = DriverManager.getConnection("jdbc:sqlite:C:\\data\\data.db","admin1","1234");
      		try {
      			Statement stmt =conn.createStatement();
      			System.out.println("insert �� : " + sql);
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
         // sqlite ���� ��
            bw.write(sql);            // Ŭ���̾�Ʈ�� ������ ����
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
            	System.out.println("-------���� �����------");
            	client = serverSocket.accept();         // Ŭ���̾�Ʈ�� �����ϸ� ����� �� �ִ� ���� ��ȯ
                System.out.println(client.getInetAddress() + "�� ���� �����û�� ����");
                if(!client.isClosed())
                {
	                is = client.getInputStream();
	                isr = new InputStreamReader(is);
	                br = new BufferedReader(isr);
	                // Ŭ���̾�Ʈ�κ��� �����͸� �ޱ� ���� InputStream ����
	                
	                String data=null;
	                data=br.readLine();
	                System.out.println("Ŭ���̾�Ʈ�� ���� ���� data:" + data);
	                
	                if(data.substring(0, 7).equals("insert "))
	                {
	                	insertData(data, client);        
	                }else
	                {
	                	receiveData(data, client);       
	                }
	                System.out.println("****** ó�� �Ϸ� ****");
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
