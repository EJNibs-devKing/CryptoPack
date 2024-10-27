/******************************************************************************************************
 * @Author:      E.J. Nibi <neipe@vlocity.com>
 * @Company:     Vlocity
 * @Date:        21/11/2019
 * @Reviewer:    
 * @Review Date: 
 * @Description: Util class to Encrypt and Decrypt data
 *
 *******************************************************************************************************/

public class VCryptoUtils {


    public class myGenericException extends Exception {}
    
    /************************************************************
    * doEncryption
    * This is utility method to encrypt the passed value.
    * @param    algorithm   : Name of the algorithm used to encrypt the data.
    * @param    setting     : Cryptographic setting which contains the configuration for the encryption.
    * @param    data        : String value that needs to be encrypted.
    * @return   String      : Enrypted value.
    ************************************************************/
    
    public static String doEncryption(String algorithm, EncodeDecode__c setting, String data) {
        String encryptedValue;
        
        try {
            Blob cryptoKey = EncodingUtil.base64Decode(setting.CRYPTO__c);      
            Blob encryptedData = Crypto.encryptWithManagedIV(algorithm, cryptoKey, Blob.valueOf(data));
            encryptedValue =  EncodingUtil.convertToHex(encryptedData);
            return encryptedValue;
        } catch (Exception thrownException) {
            System.debug(thrownException.getMessage());
            return encryptedValue;
        }
    }
    
    /************************************************************
    * doDecryption
    * This is utility method to decrypt the passed value.
    * @param    algorithm   : Name of the algorithm used to decrypt the data.
    * @param    setting     : Cryptographic setting which contains the configuration for the decryption.
    * @param    data        : String value that needs to be decrypted.
    * @return   String      : Decrypted value.
    ************************************************************/
    public static String doDecryption(String algorithm, EncodeDecode__c setting, String data) {
        String decryptedValue;        
        
        try {
            Blob cryptoKey = EncodingUtil.base64Decode(setting.CRYPTO__c);
            Blob decryptedData = Crypto.decryptWithManagedIV(algorithm, cryptoKey, EncodingUtil.convertFromHex(data));
            decryptedValue = decryptedData.toString();
            return decryptedValue;
        } catch (Exception thrownException) {
            System.debug(thrownException.getMessage());
            return decryptedValue;
        }
    }

}