/*******************************************
 * @Author:      E.J. Nibi <neipe@vlocity.com>
 * @Company:     Vlocity
 * @Date:        22/11/2019
 * @Reviewer:
 * @Review Date:
 * @Description: Test class for VHelperCipher.
  *
  ********************************************/
@IsTest(SeeAllData=false)
private class VHelperCipher_Test {
    static {
        prepareTestData();
    }

    /*
     * prepareTestData: Test Data Population
     */
    private static void prepareTestData() {
        EncodeDecode__c setting = EncodeDecode__c.getOrgDefaults();
        setting.CRYPTO__c = 'U6M7Ef2g15HeaEHTF0iWBuOGSFgWXAE9Ez+lcoT0lP0=';
        insert setting;
    }


    /*
     * encryptData - without Channel
     */
    @IsTest(SeeAllData=false)
    private static void encryptData_WithoutChannel_NullValue() {
        String value;

        String encryptedValue;
        VHelperCipher.CipherException thisCipherException;

        Test.startTest();
        try {
            encryptedValue = VHelperCipher.encryptData(value);
        } catch (VHelperCipher.CipherException thrownCipherException) {
            thisCipherException = thrownCipherException;
        }

        System.assertEquals(null,                                    encryptedValue);
        System.assertNotEquals(null,                                 thisCipherException);
        System.assertEquals(VHelperCipher.ERRMSG_ENCRYPT_NULL_VALUE, thisCipherException.getMessage());
        Test.stopTest();
    }

    @IsTest(SeeAllData=false)
    private static void encryptData_WithoutChannel_Valid() {
        String value = new OiUuid().getValue();

        String encryptedValue;

        Test.startTest();
        encryptedValue = VHelperCipher.encryptData(value);

        System.assertNotEquals(value, encryptedValue);
        System.assertEquals(value,    VHelperCipher.decryptData(encryptedValue));
        Test.stopTest();
    }


    /*
     * encryptData - with Channel
     */
    @IsTest(SeeAllData=false)
    private static void encryptData_WithChannel_NullValue() {
        String value;

        String encryptedValue;
        VHelperCipher.CipherException thisCipherException;

        Test.startTest();
        try {
            encryptedValue = VHelperCipher.encryptData(VHelperCipher.Channel.GENERAL, value);
        } catch (VHelperCipher.CipherException thrownCipherException) {
            thisCipherException = thrownCipherException;
        }

        System.assertEquals(null,                                    encryptedValue);
        System.assertNotEquals(null,                                 thisCipherException);
        System.assertEquals(VHelperCipher.ERRMSG_ENCRYPT_NULL_VALUE, thisCipherException.getMessage());
        Test.stopTest();
    }

    @IsTest(SeeAllData=false)
    private static void encryptData_WithChannel_Valid() {
        String value = new OiUuid().getValue();

        String encryptedValue;

        Test.startTest();
        encryptedValue = VHelperCipher.encryptData(VHelperCipher.Channel.GENERAL, value);

        System.assertEquals(value, VHelperCipher.decryptData(VHelperCipher.Channel.GENERAL, encryptedValue));
        Test.stopTest();
    }


    /*
     * encryptDataWithKey
     */
    @IsTest(SeeAllData=false)
    private static void encryptDataWithKey_NullValue() {
        VHelperCipher.Channel thisChannel = VHelperCipher.Channel.GENERAL;
        String key                        = new OiUuid().getValue();
        String value;

        String encryptedValue;
        VHelperCipher.CipherException thisCipherException;

        Test.startTest();
        try {
            encryptedValue = VHelperCipher.encryptDataWithKey(thisChannel, key, value);
        } catch (VHelperCipher.CipherException thrownCipherException) {
            thisCipherException = thrownCipherException;
        }

        System.assertEquals(null,                                    encryptedValue);
        System.assertNotEquals(null,                                 thisCipherException);
        System.assertEquals(VHelperCipher.ERRMSG_ENCRYPT_NULL_VALUE, thisCipherException.getMessage());
        Test.stopTest();
    }

    @IsTest(SeeAllData=false)
    private static void encryptDataWithKey() {
        VHelperCipher.Channel thisChannel = VHelperCipher.Channel.GENERAL;
        String key                        = new OiUuid().getValue();
        String value                      = new OiUuid().getValue();

        String encryptedValue;

        Test.startTest();
        encryptedValue = VHelperCipher.encryptDataWithKey(thisChannel, key, value);

        System.assertEquals(value, VHelperCipher.decryptDataWithKey(thisChannel, key, encryptedValue));
        Test.stopTest();
    }


    /*
     * decryptData - without Channel
     */
    @IsTest(SeeAllData=false)
    private static void decryptData_WithoutChannel_NullValue() {
        String encryptedValue;

        String resultValue;
        VHelperCipher.CipherException thisCipherException;

        Test.startTest();
        try {
            resultValue = VHelperCipher.decryptData(encryptedValue);
        } catch (VHelperCipher.CipherException thrownCipherException) {
            thisCipherException = thrownCipherException;
        }

        System.assertEquals(null,                                              encryptedValue);
        System.assertNotEquals(null,                                           thisCipherException);
        System.assertEquals(VHelperCipher.ERRMSG_DECRYPT_NULL_ENCRYPTED_VALUE, thisCipherException.getMessage());
        Test.stopTest();
    }

    @IsTest(SeeAllData=false)
    private static void decryptData_WithoutChannel() {
        String value          = new OiUuid().getValue();
        String encryptedValue = VHelperCipher.encryptData(value);

        Test.startTest();
        System.assertEquals(value, VHelperCipher.decryptData(encryptedValue));
        Test.stopTest();
    }


    /*
     * decryptData - with Channel
     */
    @IsTest(SeeAllData=false)
    private static void decryptData_WithChannel_NullValue() {
        String encryptedValue;

        String resultValue;
        VHelperCipher.CipherException thisCipherException;

        Test.startTest();
        try {
            resultValue = VHelperCipher.decryptData(VHelperCipher.Channel.GENERAL, encryptedValue);
        } catch (VHelperCipher.CipherException thrownCipherException) {
            thisCipherException = thrownCipherException;
        }

        System.assertEquals(null,                                              encryptedValue);
        System.assertNotEquals(null,                                           thisCipherException);
        System.assertEquals(VHelperCipher.ERRMSG_DECRYPT_NULL_ENCRYPTED_VALUE, thisCipherException.getMessage());
        Test.stopTest();
    }

    @IsTest(SeeAllData=false)
    private static void decryptData_WithChannel() {
        String value          = new OiUuid().getValue();
        String encryptedValue = VHelperCipher.encryptData(VHelperCipher.Channel.GENERAL, value);

        Test.startTest();
        System.assertEquals(value, VHelperCipher.decryptData(VHelperCipher.Channel.GENERAL, encryptedValue));
        Test.stopTest();
    }


    /*
     * decryptDataWithKey
     */
    @IsTest(SeeAllData=false)
    private static void decryptDataWithKey_NullValue() {
        VHelperCipher.Channel thisChannel = VHelperCipher.Channel.GENERAL;
        String key                        = new OiUuid().getValue();
        String encryptedValue;

        String resultValue;
        VHelperCipher.CipherException thisCipherException;

        Test.startTest();
        try {
            resultValue = VHelperCipher.decryptDataWithKey(thisChannel, key, encryptedValue);
        } catch (VHelperCipher.CipherException thrownCipherException) {
            thisCipherException = thrownCipherException;
        }

        System.assertEquals(null,                                              encryptedValue);
        System.assertNotEquals(null,                                           thisCipherException);
        System.assertEquals(VHelperCipher.ERRMSG_DECRYPT_NULL_ENCRYPTED_VALUE, thisCipherException.getMessage());
        Test.stopTest();
    }

    @IsTest(SeeAllData=false)
    private static void decryptDataWithKey() {
        VHelperCipher.Channel thisChannel = VHelperCipher.Channel.GENERAL;
        String key                        = new OiUuid().getValue();
        String value                      = new OiUuid().getValue();
        String encryptedValue             = VHelperCipher.encryptDataWithKey(thisChannel, key, value);

        Test.startTest();
        System.assertEquals(value, VHelperCipher.decryptDataWithKey(thisChannel, key, encryptedValue));
        Test.stopTest();
    }

    /*
     * applyOneTimeSalt
     */
    @IsTest(SeeAllData=false)
    private static void applyOneTimeSalt_Valid() {
        VHelperCipher.Channel thisChannel = VHelperCipher.Channel.GENERAL;
        String key                        = new OiUuid().getValue();
        String valueBeforeSalt            = new OiUuid().getValue();

        String resultValue;

        Test.startTest();
        resultValue = VHelperCipher.applyOneTimeSalt(valueBeforeSalt);

        System.assertEquals(valueBeforeSalt, resultValue.removeEnd(resultValue.right(VHelperCipher.SALT_LENGTH)));
        Test.stopTest();
    }


    /*
     * removeOneTimeSalt
     */
    @IsTest(SeeAllData=false)
    private static void removeOneTimeSalt_Valid() {
        String valueBeforeSalt            = new OiUuid().getValue();
        String valueAfterSalt             = VHelperCipher.applyOneTimeSalt(valueBeforeSalt);

        String resultValue;

        Test.startTest();
        resultValue = VHelperCipher.removeOneTimeSalt(valueAfterSalt);

        System.assertEquals(valueBeforeSalt, resultValue);
        Test.stopTest();
    }
}