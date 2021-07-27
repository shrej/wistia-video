@isTest
public class WistiaMedia_Test {
  static testMethod void testParse() {
    String json =
      '[{' +
      '	\"name\": \"wistia-demo\",' +
      '	\"thumbnail\": {' +
      '		\"url\": \"https://example.com\"' +
      '         }' +
      '}]';
    List<WistiaMedia> wistiaMedias = WistiaMedia.parse(json);
    System.assertNotEquals(
      null,
      wistiaMedias,
      'The parsed wistia medias should not be null'
    );
    System.assertEquals(
      1,
      wistiaMedias.size(),
      'Expected exactly one wistia media'
    );
    System.assertEquals(
      'wistia-demo',
      wistiaMedias.get(0).name,
      'Expected the name of the first wistia media to be "wistia-demo"'
    );
    System.assertEquals(
      'https://example.com',
      wistiaMedias.get(0).thumbnail.url,
      'Expected the url of the first wistia media to be "https://example.com"'
    );
  }
}
