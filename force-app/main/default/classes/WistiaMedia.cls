/**
 * @description Class representing Wistia Media
 *
 */
public with sharing class WistiaMedia {
  public String name;
  public Thumbnail thumbnail;
  public class Thumbnail {
    public String url;
  }

  public static List<WistiaMedia> parse(String json) {
    return (List<WistiaMedia>) System.JSON.deserialize(
      json,
      List<WistiaMedia>.class
    );
  }
}
