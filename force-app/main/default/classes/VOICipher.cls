/******************************************************************************************************
 * @Author:      E.J. Nibi <neipe@vlocity.com>
 * @Company:     Vlocity
 * @Date:        21/11/2019
 * @Reviewer:
 * @Review Date:
 * @Description: Class for Encryption / Decryption of data using a custom Key
 *
 *******************************************************************************************************/

global class VOICipher{

    public class methodNotFoundException extends Exception {}
    public class myGenericException extends Exception {}

    //methodNames
    @testVisible private static final String METHOD_GET_ENCRYPTED_VALUE = 'getEncryptedValue';
    @testVisible private static final String METHOD_GET_DECRYPTED_VALUE = 'getDecryptedValue';

    //inputVariables
    @testVisible private static final String INPUT_CHANNEL   = 'channel';
    @testVisible private static final String INPUT_ENCODE    = 'encodeValue';
    @testVisible private static final String INPUT_DECODE    = 'decodeValue';
    @testVisible private static final String INPUT_ARGUMENTS = 'arguments';

    //outputVariables
    @testVisible private static final String OUTPUT_ENCODED = 'result';
    @testVisible private static final String OUTPUT_DECODED = 'result';

    /************************************************************
    * invokeMethod
    * This method is the primary entry point of this class to route it to appropriate method.
    * @param    methodName  : Name of the method to which needs to be routed to.
    * @param    inputMap    : Map of input poarameters
    * @param    outMap      : Map of optional parameters
    * @param    options     : Map of output parameters which consists the result of the method called
    * @return   Boolean     : True defines a successful execution while false define some error has occurred.
    ************************************************************/
    global Boolean invokeMethod(String methodName,
                                 Map<String,Object> inputMap,
                                 Map<String,Object> outMap,
                                 Map<String,Object> options){

        try {
            if (METHOD_GET_ENCRYPTED_VALUE.equalsIgnoreCase(methodName)) {
                routeEncryption(inputMap, outMap, options);
            } else if (METHOD_GET_DECRYPTED_VALUE.equalsIgnoreCase(methodName)) {
                routeDecryption(inputMap, outMap, options);
            } else {
                throw new methodNotFoundException('Method Not Found');
            }

        } catch (Exception thrownException) {
            System.debug(thrownException.getMessage());
            return false;
        }
        return true;
    }

    /************************************************************
    * routeEncryption
    * This method is used to route the encryption based upon the type of innput passed.
    * @param    inputMap    : Map of input poarameters
    * @param    outMap      : Map of optional parameters
    * @param    options     : Map of output parameters which consists the result of the method called
    * @return   void
    ************************************************************/
    @testVisible
    private void routeEncryption(Map<String,Object> inputMap,
                                  Map<String,Object> outMap,
                                  Map<String,Object> options) {

        if(inputMap.containsKey(INPUT_ENCODE)) {
            outMap.put(OUTPUT_ENCODED, encryptValue(String.valueof(inputMap.get(INPUT_CHANNEL)), inputMap.get(INPUT_ENCODE)));
        } else if(inputMap.containsKey(INPUT_ARGUMENTS)) {
            outMap.put(OUTPUT_ENCODED, encryptValue((List<Object>)inputMap.get(INPUT_ARGUMENTS)));
        }

    }

    /************************************************************
    * routeDecryption
    * This method is used to route the encryption based upon the type of innput passed.
    * @param    inputMap    : Map of input poarameters
    * @param    outMap      : Map of optional parameters
    * @param    options     : Map of output parameters which consists the result of the method called
    * @return   void
    ************************************************************/
    @testVisible
    private void routeDecryption(Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        if(inputMap.containsKey(INPUT_DECODE)) {
            outMap.put(OUTPUT_DECODED,decryptValue(String.valueof(inputMap.get(INPUT_CHANNEL)), inputMap.get(INPUT_DECODE)));
        } else if(inputMap.containsKey(INPUT_ARGUMENTS)) {
            outMap.put(OUTPUT_DECODED,decryptValue((List<Object>)inputMap.get(INPUT_ARGUMENTS)));
        }

    }

    /************************************************************
    * encryptValue
    * This method is used to encrypt the passed value when the request triggerred from a DataRaptor formula.
    * @param    args    : List of objects passed from the interface of a DataRaptor formula, whose 1st parameter is the value to be encrypted.
    * @return   String  : Encrypted value.
    ************************************************************/
    private String encryptValue(List<Object> args) {
        if(args == null || args.size() == 0) {
            throw new myGenericException('Entered value is Null');
        } else {
            return encryptValue(null, args.get(0));
        }
    }

    /************************************************************
    * decryptValue
    * This method is used to decrypt the passed value when the request triggerred from a DataRaptor formula.
    * @param    args    : List of objects passed from the interface of a DataRaptor formula, whose 1st parameter is the value to be decrypted.
    * @return   String  : Decrypted value.
    ************************************************************/
    private String decryptValue(List<Object> args) {
        if(args == null || args.size() == 0) {
            throw new myGenericException('Entered value is Null');
        } else {
            return decryptValue(null, args.get(0));
        }
    }

    /************************************************************
    * encryptValue
    * This method is used to encrypt the passed value when the request triggerred through a remote action.
    * @param    value   : Object passed through a remote action that needs to be encrypted.
    * @return   String  : Encrypted value.
    ************************************************************/
    private String encryptValue(String channelString, Object value) {
        if(value == null) {
            throw new myGenericException('Entered value is Null');
        } else {
            VHelperCipher.Channel thisChannel = (channelString == null ? VHelperCipher.Channel.GENERAL : parseChannel(channelString));

            return VHelperCipher.encryptData(thisChannel, String.valueof(value));
        }
    }

    /************************************************************
    * decryptValue
    * This method is used to decrypt the passed value when the request triggerred through a remote action.
    * @param    args    : Object passed through a remote action that needs to be decrypted.
    * @return   String  : Decrypted value.
    ************************************************************/
    private String decryptValue(String channelString, Object value) {
        if(value == null) {
            throw new myGenericException('Entered value is Null');
        } else {
            VHelperCipher.Channel thisChannel = (channelString == null ? VHelperCipher.Channel.GENERAL : parseChannel(channelString));

            return VHelperCipher.decryptData(thisChannel, String.valueof(value));
        }
    }

    public VHelperCipher.Channel parseChannel(String channelString) {
        VHelperCipher.Channel thisChannel;

        for (VHelperCipher.Channel currentChannel : VHelperCipher.Channel.values()) {
            if (currentChannel.name().equalsIgnoreCase(channelString)) {
                thisChannel = currentChannel;

                break;
            }
        }

        if (thisChannel == null) {
            throw new myGenericException('Entered value is Null');
        }

        return thisChannel;
    }

    

}