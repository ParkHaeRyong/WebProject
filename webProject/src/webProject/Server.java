package webProject;


import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;
 
public class Server {
    
    public static void main(String[] args) {
        try {
            System.out.println("������ ��ٸ��ϴ�.");
            ServerSocket serverSocket = new ServerSocket(10002);
            AcceptThread acceptThread = new AcceptThread(serverSocket);
            
            // ���⼭ ���ο� �����尡 ����
            new Thread(acceptThread).start();
            // �Ʒ� ������ ���ÿ� ������ ��.
            //System.out.println("���� �ٷ� ������.");
            // ����Ŭ���̾�Ʈ�� ó���ϴ� �޽��������
        } catch (Exception e) {
        }
    }
}
