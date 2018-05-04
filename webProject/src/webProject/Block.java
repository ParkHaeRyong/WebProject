package webProject;
import java.security.MessageDigest;

 

public class Block {
 
  private int blockSize;            // Ignore for now.
  private BlockHeader blockHeader;
  private int transactionCount;    // Ignore for now.
  private Object[] transactions;
  
  public String data; //our data will be a simple message.
  public String previousHash;
  private long timeStamp; //as number of milliseconds since 1/1/1970.
  public String hash; //our data will be a simple message.
  
//Block Constructor.
  public Block(String data,String previousHash ) {

		this.data = data;
		this.previousHash = previousHash;
	//	this.timeStamp = new Date().getTime();
		this.hash = calculateHash(); //Making sure we do this after we set the other values.

	}
  	public static class StringUtil {
		//Applies Sha256 to a string and returns the result. 
		public static String applySha256(String input){		
			try {
				MessageDigest digest = MessageDigest.getInstance("SHA-256");	        
				//Applies sha256 to our input, 
				byte[] hash = digest.digest(input.getBytes("UTF-8"));	        
				StringBuffer hexString = new StringBuffer(); // This will contain hash as hexidecimal
				for (int i = 0; i < hash.length; i++) {
					String hex = Integer.toHexString(0xff & hash[i]);
					if(hex.length() == 1) hexString.append('0');
					hexString.append(hex);
				}
				return hexString.toString();
			}
			catch(Exception e) {
				throw new RuntimeException(e);
			}
		}	
	}
	
	public String calculateHash() {
		String calculatedhash = StringUtil.applySha256( 
				previousHash +
		//		Long.toString(timeStamp) +
				data 
				);
		return calculatedhash;
	}
}