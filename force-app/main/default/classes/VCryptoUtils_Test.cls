/******************************************************************************************************
 * @Author:      E.J. Nibi <neipe@vlocity.com>
 * @Company:     Vlocity
 * @Date:        22/11/2019
 * @Reviewer:    
 * @Review Date: 
 * @Description: Test class for VHelperCipher.
 *
 *******************************************************************************************************/

@IsTest(SeeAllData=false)
global class VCryptoUtils_Test {
    
    /************************************************************
    * invokeMethod_DoEncryption: Test method for - doEncryption 
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_DoEncryption_Test() { 
        String data = 'EncryptThis';
        EncodeDecode__c setting = insertSetting();
        
        Test.startTest();
        VCryptoUtils.doEncryption('AES256',setting,data);
        Test.stopTest();
    }
    
    /************************************************************
    * invokeMethod_DoEncryption: Test method for - doEncryption 
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_DoEncryption_NullData_Test() { 
        String data;
        EncodeDecode__c setting = insertSetting();
        
        Test.startTest();
        VCryptoUtils.doEncryption('AES256',setting,data);
        Test.stopTest();
    }
    
    /************************************************************
    * invokeMethod_DoDecryptData_Test: Test method for - doDecryptData
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_DoDecryptData_Test() { 
        String data = '31c0a79a78f63eb2db814e44902a4a14defc5294a3ee37d933949c1f4ca00cfe';
        EncodeDecode__c setting = insertSetting();
        
        Test.startTest();
        VCryptoUtils.doDecryption('AES256',setting,data);
        Test.stopTest();
    }
    
    /************************************************************
    * invokeMethod_DoDecryptData_NullData_Test: Test method for - doDecryptData
    ************************************************************/
    @IsTest(SeeAllData=false)
    static void invokeMethod_DoDecryptData_NullData_Test() { 
        String data;
        EncodeDecode__c setting = insertSetting();
        
        Test.startTest();
        VCryptoUtils.doDecryption('AES256',setting,data);
        Test.stopTest();
    }
    
    /************************************************************
    * insertSetting: Test Data Population
    ************************************************************/
    private static EncodeDecode__c insertSetting() {
        EncodeDecode__c setting = EncodeDecode__c.getOrgDefaults();
        setting.CRYPTO__c = 'U6M7Ef2g15HeaEHTF0iWBuOGSFgWXAE9Ez+lcoT0lP0=';
        insert setting;
        return setting;
    }
}