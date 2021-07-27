/**
 * @description Helps in the generation of Dynamic Picklist options that can be used in an LWC in the builder
 *
 */
@SuppressWarnings('PMD.AvoidGlobalModifier')
global with sharing class WistiaMediaPicker extends VisualEditor.DynamicPickList {
  private static final VisualEditor.DataRow DEFAULT_ROW = new VisualEditor.DataRow(
    '-- Select a Video --',
    ''
  );

  private static final VisualEditor.DataRow NO_MEDIAS_ROW = new VisualEditor.DataRow(
    '-- No Videos Found --',
    ''
  );

  private static final String NAMESPACE_PREFIX = 'wvc__';

  global override VisualEditor.DataRow getDefaultValue() {
    return DEFAULT_ROW;
  }

  /**
   * @description Returning true always to avoid an error in the builder
   * @return Boolean
   */
  global override Boolean isValid(Object attributeValue) {
    return true;
  }

  /**
   * @description Get a list of dynamic picklist options
   * @return VisualEditor.DynamicPickListRows
   */
  global override VisualEditor.DynamicPickListRows getValues() {
    VisualEditor.DynamicPickListRows rows = new VisualEditor.DynamicPickListRows();
    try {
      String calloutURL = 'callout:' + NAMESPACE_PREFIX + 'WistaMedia';
      HttpRequest request = new HttpRequest();
      request.setEndpoint(calloutURL);
      request.setMethod('GET');
      Http http = new Http();
      HTTPResponse response = http.send(request);
      List<WistiaMedia> medias = WistiaMedia.parse(response.getBody());
      if(medias.size() > 0) {
        for (WistiaMedia media : medias) {
          rows.addRow(new VisualEditor.DataRow((String) media.name, media?.thumbnail?.url));
        }
      } else {
        rows.addRow(NO_MEDIAS_ROW);
      }
    } catch(Exception e) {
      System.debug(e.getMessage());
      rows.addRow(new VisualEditor.DataRow('Error Retrieving Wistia Media', ''));
    }
    return rows;
  }
}
