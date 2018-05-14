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
 
	/*������ ����� �������� ����*/
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
            socket = new Socket(ip,port); //��� ������ IP
            os = socket.getOutputStream();
            osw = new OutputStreamWriter(os);
            bw = new BufferedWriter(osw);            //������ ������ ���� OutputStream
        
            is = socket.getInputStream();
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);        // �����κ��� Data�� ����
            
            bw.write(hash);
            bw.newLine();
            bw.flush();
            
            String receiveData = "";
            receiveData = br.readLine();        // �����κ��� ������ ���� ����
            System.out.println("�����κ��� ���� ������ : " + receiveData);
            if(receiveData.substring(0, 1).equals("��"))
            {
            	cnt++;
            }
            
        }catch(Exception e){
        	System.out.println(ip+"�� ����ڿ� ���ῡ �����Ͽ����ϴ�.");
        	//String errMsg = ip+"�� ����ڿ� ���ῡ �����Ͽ����ϴ�.";
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
    /*������ ����� ���� ��� ��ü ��忡 insert*/
    public void ClientInsert(String ip, int port,String sql){
        
        Socket socket = null;
        OutputStream os = null;
        OutputStreamWriter osw =null;
        BufferedWriter bw = null;
        
        InputStream is =null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        
        try{
            socket = new Socket(ip,port); //��� ������ IP
            os = socket.getOutputStream();
            osw = new OutputStreamWriter(os);
            bw = new BufferedWriter(osw);            //������ ������ ���� OutputStream
        
            is = socket.getInputStream();
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);        // �����κ��� Data�� ����
            
            bw.write(sql);
            bw.newLine();
            bw.flush();
            
            String receiveData = "";
            receiveData = br.readLine();        // �����κ��� ������ ���� ����
            System.out.println("�����κ��� ���� ������ : " + receiveData);
            
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
