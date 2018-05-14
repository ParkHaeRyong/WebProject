package webProject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.HttpURLConnection;
import java.net.URL;

public class Client {
    
    public int cnt = 0;
	public static void main(String[] args) {
		
		//Client cm = new Client();
        //cm.ClientRun("192.168.100.64",10002,"");
    }
 
	/*생성한 블록을 서버노드로 전송*/
    public void ClientRun(String ip, int port,String hash) throws Exception{
        
        Socket socket = null;
        OutputStream os = null;
        OutputStreamWriter osw =null;
        BufferedWriter bw = null;
        BufferedReader in = null;
        
        InputStream is =null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        
        try{
            socket = new Socket(ip,port); //블록 전송할 IP
            os = socket.getOutputStream();
            osw = new OutputStreamWriter(os);
            bw = new BufferedWriter(osw);            //서버로 전송을 위한 OutputStream
        
            is = socket.getInputStream();
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);        // 서버로부터 Data를 받음
            
            bw.write(hash);
            bw.newLine();
            bw.flush();
            
            String receiveData = "";
            receiveData = br.readLine();        // 서버로부터 데이터 한줄 읽음
            System.out.println("서버로부터 받은 데이터 : " + receiveData);
            if(receiveData.substring(0, 1).equals("참"))
            {
            	cnt++;
            }
            
        }catch(Exception e){
        	System.out.println(ip+"의 사용자와 연결에 실패하였습니다.");
        	//String errMsg = ip+"의 사용자와 연결에 실패하였습니다.";
        	throw e;
        }finally {
            try{
                bw.close();
                osw.close();
                os.close();
                br.close();
                isr.close();
                is.close();
                socket.close();
            }catch(Exception e){
            	e.printStackTrace();
            }
        }    
        
    }
    /*생성한 블록이 참일 경우 전체 노드에 insert*/
    public void ClientInsert(String ip, int port,String sql){
        
        Socket socket = null;
        OutputStream os = null;
        OutputStreamWriter osw =null;
        BufferedWriter bw = null;
        
        InputStream is =null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        
        try{
            socket = new Socket(ip,port); //블록 전송할 IP
            os = socket.getOutputStream();
            osw = new OutputStreamWriter(os);
            bw = new BufferedWriter(osw);            //서버로 전송을 위한 OutputStream
        
            is = socket.getInputStream();
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);        // 서버로부터 Data를 받음
            
            bw.write(sql);
            bw.newLine();
            bw.flush();
            
            String receiveData = "";
            receiveData = br.readLine();        // 서버로부터 데이터 한줄 읽음
            System.out.println("서버로부터 받은 데이터 : " + receiveData);
            
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try{
                bw.close();
                osw.close();
                os.close();
                br.close();
                isr.close();
                is.close();
                socket.close();
            }catch(Exception e){
                e.printStackTrace();
            }
        }    
        
    }
}
