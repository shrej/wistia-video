@isTest
private class WistiaMediaPicker_Tests {
  @isTest
  private static void testGetDefaultValuesWhenNoResponse() {
    WistiaMediaPicker wistiaMediPicker = new WistiaMediaPicker();
    VisualEditor.DataRow defaultRow = wistiaMediPicker.getDefaultValue();
    System.assertNotEquals(
      null,
      defaultRow,
      'Expected the default row to be not null'
    );
    System.assertEquals(
      '-- Select a Video --',
      defaultRow.getLabel(),
      'Expected the default label to be : "-- Select a Video --"'
    );
    System.assertEquals(
      '',
      defaultRow.getValue(),
      'Expected the default value to be : Empty String'
    );
  }

  @isTest
  private static void testWistiaMediaWhenValidResponse() {
    StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
    mock.setStaticResource('wistiaMediaMock');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    // Associate the callout with a mock response
    Test.setMock(HttpCalloutMock.class, mock);
    WistiaMediaPicker wistiaMediaPicker = new WistiaMediaPicker();
    VisualEditor.DynamicPickListRows picklistValues = wistiaMediaPicker.getValues();
    System.assertNotEquals(null, picklistValues, 'Rows should not be null');
    System.assertEquals(1, picklistValues.size(), 'Expected 1 picklist item');
    System.assertEquals(
      'wistia-api-demo',
      picklistValues.get(0).getLabel(),
      'Expected the first picklist label to be : "wistia-api-demo"'
    );
    System.assertEquals(
      'https://example.com',
      picklistValues.get(0).getValue(),
      'Expected the first picklist value to be : "https://example.com"'
    );
  }

  @isTest
  private static void testWistiaMediaWhenValidEmptyResponse() {
    StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
    mock.setStaticResource('emptyWistiaMediaMock');
    mock.setStatusCode(200);
    mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
    // Associate the callout with a mock response
    Test.setMock(HttpCalloutMock.class, mock);
    WistiaMediaPicker wistiaMediaPicker = new WistiaMediaPicker();
    VisualEditor.DynamicPickListRows picklistValues = wistiaMediaPicker.getValues();
    System.assertNotEquals(null, picklistValues, 'Rows should not be null');
    System.assertEquals(1, picklistValues.size(), 'Expected 1 picklist item');
    System.assertEquals(
      '-- No Videos Found --',
      picklistValues.get(0).getLabel(),
      'Expected the first picklist label to be : "-- No Videos Found --"'
    );
    System.assertEquals(
      '',
      picklistValues.get(0).getValue(),
      'Expected the first picklist value to be : Empty String'
    );
  }

  @isTest
  private static void testWistiaMediaWhenInValidResponse() {
    WistiaMediaPicker wistiaMediaPicker = new WistiaMediaPicker();
    VisualEditor.DynamicPickListRows picklistValues = wistiaMediaPicker.getValues();
    System.assertNotEquals(
      null,
      picklistValues,
      'Expected Picklist Values to be not null'
    );
    System.assertEquals(1, picklistValues.size(), 'Expected 1 picklist value');
    System.assertEquals(
      'Error Retrieving Wistia Media',
      picklistValues.get(0).getLabel(),
      'Expected the picklist label to be : "Error Retrieving Wistia Media"'
    );
    System.assertEquals(
      '',
      picklistValues.get(0).getValue(),
      'Expected the picklist value to be Empty String'
    );
  }

  @isTest
  private static void testWistiaMediaWithException() {
    try {
      StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
      mock.setStaticResource('invalidMock');
      mock.setStatusCode(200);
      mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
      WistiaMediaPicker wistiaMediaPicker = new WistiaMediaPicker();
      VisualEditor.DynamicPickListRows picklistValues = wistiaMediaPicker.getValues();
    } catch (Exception unexpectedException) {
      System.assert(false, 'Exceptions should be handled by the method');
    }
  }

  @isTest
  private static void testIsValid() {
    WistiaMediaPicker wistiaMediaPicker = new WistiaMediaPicker();
    Boolean isValid = wistiaMediaPicker.isValid(null);
    System.assertEquals(
      true,
      isValid,
      'Expected isValid to always return true'
    );
  }
}
