/******************************************************************************************************
 * @Author:      E.J. Nibi <neipe@vlocity.com>
 * @Company:     Vlocity
 * @Date:        21/11/2019
 * @Reviewer:
 * @Review Date:
 * @Description: Test class for VOICipher, which also covers VHelperCipher
 *
 *******************************************************************************************************/

@IsTest(SeeAllData=false)
global class VOICipher_Test {

    static {
        prepareTestData();
    }

    //Method Name
    private static final String METHOD_INVALID_NAME = 'InvalidMethodName';

    /************************************************************
    * invokeMethod_InvalidMethodName: Test method for - InvokeMethod
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_InvalidMethodName() {

        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        String methodName = METHOD_INVALID_NAME;
        Boolean result;
        VOICipher thisCipher = new VOICipher();

        Test.startTest();

        result = (Boolean)thisCipher.invokeMethod(methodName, inputMap, outMap, options);
        System.assertEquals(false, result);

        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteEncryption_Test: Test method for - RouteEncryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteEncryption_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        inputMap.put(VOICipher.INPUT_ENCODE,'EncryptThis');

        Test.startTest();
        System.assertEquals(true, new VOICipher().invokeMethod(VOICipher.METHOD_GET_ENCRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteDecryption_Test: Test method for - routeDecryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteDecryption_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        inputMap.put(VOICipher.INPUT_DECODE, '31c0a79a78f63eb2db814e44902a4a14defc5294a3ee37d933949c1f4ca00cfe');

        Test.startTest();
        System.assertEquals(true, new VOICipher().invokeMethod(VOICipher.METHOD_GET_DECRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteEncryption_Test: Test method for - RouteEncryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteEncryption_NullValue_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        inputMap.put(VOICipher.INPUT_ENCODE, null);

        Test.startTest();
        System.assertEquals(false, new VOICipher().invokeMethod(VOICipher.METHOD_GET_ENCRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteDecryption_Test: Test method for - routeDecryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteDecryption_NullValue_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        inputMap.put(VOICipher.INPUT_DECODE, null);

        Test.startTest();
        System.assertEquals(false, new VOICipher().invokeMethod(VOICipher.METHOD_GET_DECRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteEncryption_Test: Test method for - RouteEncryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteEncryption_Formula_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<Object> argList = new List<Object>();
        argList.add('EncryptThis');

        inputMap.put(VOICipher.INPUT_ARGUMENTS, argList);

        Test.startTest();
        System.assertEquals(true, new VOICipher().invokeMethod(VOICipher.METHOD_GET_ENCRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteDecryption_Test: Test method for - routeDecryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteDecryption_Formula_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<Object> argList = new List<Object>();
        argList.add('31c0a79a78f63eb2db814e44902a4a14defc5294a3ee37d933949c1f4ca00cfe');

        inputMap.put(VOICipher.INPUT_ARGUMENTS, argList);

        Test.startTest();
        System.assertEquals(true, new VOICipher().invokeMethod(VOICipher.METHOD_GET_DECRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteEncryption_Test: Test method for - RouteEncryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteEncryption_Formula_EmptyList_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<Object> argList = new List<Object>();

        inputMap.put(VOICipher.INPUT_ARGUMENTS, argList);

        Test.startTest();
        System.assertEquals(false, new VOICipher().invokeMethod(VOICipher.METHOD_GET_ENCRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * invokeMethod_RouteDecryption_Test: Test method for - routeDecryption
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_RouteDecryption_Formula_EmptyList_Test() {

        String methodName = 'encodeValue';
        Map<String, Object> inputMap = new Map<String, Object>();
        Map<String, Object> outMap = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<Object> argList = new List<Object>();

        inputMap.put(VOICipher.INPUT_ARGUMENTS, argList);

        Test.startTest();
        System.assertEquals(false, new VOICipher().invokeMethod(VOICipher.METHOD_GET_DECRYPTED_VALUE, inputMap, outMap, options));
        Test.stopTest();
    }

    /************************************************************
    * prepareTestData: Test Data Population
    ************************************************************/
    private static void prepareTestData() {
        EncodeDecode__c setting = EncodeDecode__c.getOrgDefaults();
        setting.CRYPTO__c = 'U6M7Ef2g15HeaEHTF0iWBuOGSFgWXAE9Ez+lcoT0lP0=';
        insert setting;
    }
}