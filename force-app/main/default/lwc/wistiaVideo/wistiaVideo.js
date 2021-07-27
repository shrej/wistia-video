import { LightningElement, api } from "lwc";
import {
  getPlayButtonSize,
  addQueryParamsToUrl,
  addOrAppendWistiaEmailParamToUrl
} from "./utils";

export default class WistiaVideo extends LightningElement {
  @api
  wistiaThumbnailUrl = "";

  @api
  thumbnailAltText = "Play Video";

  @api
  imageWidth = "450";

  @api
  imageHeight = "auto";

  @api
  destinationUrl = "";

  @api
  playButtonColor = "#2d42e9";

  @api
  get playButtonSize() {
    return this._playButtonSize;
  }
  set playButtonSize(value) {
    this._playButtonSize = value;
    this.computedPlayButtonSize = getPlayButtonSize(value);
  }

  get computedDestinationUrl() {
    return addOrAppendWistiaEmailParamToUrl(this.destinationUrl);
  }

  get thumbnailUrl() {
    return addQueryParamsToUrl(this.wistiaThumbnailUrl, {
      image_play_button: true,
      image_play_button_size: this.computedPlayButtonSize,
      image_play_button_color: this.playButtonColor
    });
  }

  get hasDestinationUrl() {
    return !!this.destinationUrl;
  }

  noSelectionMessage =
    "Please select a Wistia video and enter a destination url.";

  computedPlayButtonSize = "2x";

  _playButtonSize = "Large";
}
