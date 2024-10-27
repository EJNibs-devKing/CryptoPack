@IsTest(SeeAllData=false)
private class OiUuidTest {
    @IsTest(SeeAllData=false)
    private static void getShortValue() {
        Test.startTest();
        System.assertNotEquals(null, new OiUuid().getShortValue());
        Test.stopTest();
    }

    @IsTest(SeeAllData=false)
    private static void it_should_create_several_valid_uuids() {
        String generatedUuid = new OiUuid().getValue();
        System.assertEquals(36, generatedUuid.length());

        Pattern pattern = Pattern.compile('[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}');

        for(Integer i = 0; i < 10; i++) {
            OiUuid uuid = new OiUuid();
            Matcher matcher = pattern.matcher(uuid.getValue());
            System.assert(matcher.matches(), 'Generated UUID=' + uuid.getValue());
        }
    }

    @IsTest(SeeAllData=false)
    private static void it_should_reuse_a_uuid_on_subsequent_calls() {
        OiUuid uuid = new OiUuid();
        String originalValue = uuid.getValue();

        for(Integer i = 0; i < 5; i++) {
            System.assertEquals(originalValue, uuid.getValue());
        }
    }

    @IsTest(SeeAllData=false)
    private static void it_should_verify_that_a_uuid_is_a_uuid() {
        String generatedUuid = new OiUuid().getValue();
        System.assert(OiUuid.isValid(generatedUuid));
    }

    @IsTest(SeeAllData=false)
    private static void it_should_not_consider_a_blank_string_a_uuid() {
        System.assertEquals(false, OiUuid.isValid(''));
    }

    @IsTest(SeeAllData=false)
    private static void it_should_not_consider_null_a_uuid() {
        System.assertEquals(false, OiUuid.isValid(null));
    }

    @IsTest(SeeAllData=false)
    private static void it_should_validate_a_uuid_in_upper_case() {
        String exampleUuid = 'f3665813-1a60-4924-ad9b-23a9cef17d80'.toUpperCase();
        System.assertEquals(true, OiUuid.isValid(exampleUuid));
    }

    @IsTest(SeeAllData=false)
    private static void it_should_validate_a_uuid_in_lower_case() {
        String exampleUuid = 'f3665813-1a60-4924-ad9b-23a9cef17d80'.toLowerCase();
        System.assertEquals(true, OiUuid.isValid(exampleUuid));
    }

    @IsTest(SeeAllData=false)
    private static void it_should_convert_a_valid_string_to_a_uuid() {
        String uuidValue = new OiUuid().getValue();

        Test.startTest();
        OiUuid convertedUuid = OiUuid.valueOf(uuidValue);
        Test.stopTest();

        System.assertEquals(uuidValue, convertedUuid.getValue());
    }

    @IsTest(SeeAllData=false)
    private static void it_should_not_convert_an_invalid_string_to_a_uuid() {
        String invalidUuidValue = 'this-is-not-a-valid-uuid';

        Test.startTest();
        try {
            OiUuid convertedUuid = OiUuid.valueOf(invalidUuidValue);
            System.assert(false, 'Error expected here');
        } catch(Exception ex) {
            String expectedError = invalidUuidValue + ' is not a valid UUID';
            System.assert(ex.getMessage().contains(expectedError));
        }
        Test.stopTest();
    }
}