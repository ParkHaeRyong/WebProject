package webProject;


import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;
 
public class Server {
    
    public static void main(String[] args) {
        try {
            System.out.println("접속을 기다립니다.");
            ServerSocket serverSocket = new ServerSocket(10002);
            AcceptThread acceptThread = new AcceptThread(serverSocket);
            
            // 여기서 새로운 쓰레드가 생성
            new Thread(acceptThread).start();
            // 아래 구문과 동시에 실행이 됨.
            //System.out.println("내가 바로 서버다.");
            // 다중클라이언트를 처리하는 메신저라든지
        } catch (Exception e) {
        }
    }
}
