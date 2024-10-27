/*
 * @Author:      E.J. Nibi <neipe@vlocity.com>
 * @Company:     Vlocity
 * @Date:        21/11/2019
 * @Reviewer:
 * @Review Date:
 * @Description: Helper Class for VOICipher
 *
 */

global inherited sharing class VHelperCipher {
    //Enums
    global enum Channel { GENERAL , USER_REGISTRATION , RESET_PASSWORD , EMAIL_VERIFICATION , FINDMYNUMBER }


    //Static Variables
    @TestVisible private static final String ALGORITHM                   = 'AES256';
    @TestVisible private static final EncodeDecode__c SETTING            = EncodeDecode__c.getInstance();
    @TestVisible private static final String ENCRYPTION_DATE_TIME_FORMAT = 'yyyy-MM-dd\'T\'hh:mm:ss.SSSS';
    @TestVisible private static final Integer SALT_LENGTH                = 24;


    //Error Messages
    @TestVisible private static final String ERRMSG_ENCRYPT_NULL_VALUE           = 'Value to be encrypted cannot be null';
    @TestVisible private static final String ERRMSG_DECRYPT_NULL_ENCRYPTED_VALUE = 'Encrypted Value cannot be null';
    @TestVisible private static final String ERRMSG_DECRYPT_NULL_VALUE           = 'Error decrypting the specified value';
    @TestVisible private static final String ERRMSG_GET_SALT_RECORD_NOT_FOUND    = 'No salt found for the specified Channel and Key';


    /*
     * decryptData - DEPRECATED PLEASE USE encryptData(Channel thisChannel, String value)
     */
    global static String encryptData(String value) {
        return encryptData(VHelperCipher.Channel.GENERAL, value);
    }


    /*
     * encryptData
     * This method is used to encrypt the passed value from VOICipher class.
     * @param    thisChannel   : The Channel/Journey in which encryption is being performed.
     * @param    value         : String value that needs to be encrypted.
     * @return   String        : Enrypted value.
     */
    global static String encryptData(Channel thisChannel, String value) {
        if (value == null) {
            throw new CipherException(ERRMSG_ENCRYPT_NULL_VALUE);
        }

        return VCryptoUtils.doEncryption(ALGORITHM, SETTING, applyOneTimeSalt(value));
    }


    /*
     * decryptData - DEPRECATED PLEASE USE encryptData(Channel thisChannel, String value)
     */
    global static String encryptDataWithKey(Channel thisChannel, String key, String value) {
        return encryptData(thisChannel, value);
    }


    /*
     * decryptData - DEPRECATED PLEASE USE decryptData(Channel thisChannel, String encryptedValue)
     */
    global static String decryptData(String encryptedValue) {
        return decryptData(VHelperCipher.Channel.GENERAL, encryptedValue);
    }


    /*
     * decryptData
     * This method is used to decrypt the passed value from VOICipher class.
     * @param    thisChannel     : The Channel/Journey in which encryption is being performed
     * @param    encryptedValue  : String value that needs to be decrypted.
     * @return   String          : Decrypted value.
     */
    global static String decryptData(Channel thisChannel, String encryptedValue) {
        if (encryptedValue == null) {
            throw new CipherException(ERRMSG_DECRYPT_NULL_ENCRYPTED_VALUE);
        }

        return removeOneTimeSalt(VCryptoUtils.doDecryption(ALGORITHM, SETTING, encryptedValue));
    }


    /*
     * decryptDataWithKey - DEPRECATED PLEASE USE decryptData(Channel thisChannel, String encryptedValue)
     */
    global static String decryptDataWithKey(Channel thisChannel, String key, String encryptedValue) {
        return decryptData(encryptedValue);
    }

    @TestVisible
    private static String applyOneTimeSalt(String value) {
        if (value != null) {
            value += System.now().format(ENCRYPTION_DATE_TIME_FORMAT);
        }

        return value;
    }

    @TestVisible
    private static String removeOneTimeSalt(String value) {
        system.debug('value=='+value);
        return value.removeEnd(value.right(SALT_LENGTH));
    }

    @TestVisible
    private class CipherException extends Exception { }


 



}