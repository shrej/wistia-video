export function getPlayButtonSize(value) {
  if (value === "Small") {
    return "1x";
  }
  return "2x";
}

function purifyUrl(url) {
  if (url && typeof url === "string") {
    return url.split("?")[0];
  }
  return "";
}

export function addQueryParamsToUrl(url, params) {
  const cleanUrl = purifyUrl(url);
  const queryString = Object.keys(params || {})
    .map((key) => {
      return encodeURIComponent(key) + "=" + encodeURIComponent(params[key]);
    })
    .join("&");
  return `${cleanUrl}?${queryString}`;
}

export function addOrAppendWistiaEmailParamToUrl(url) {
  const urlHasQueryParams = (url || "").includes("?");
  if (urlHasQueryParams) {
    return `${url}&wemail={{{Recipient.Email}}}`;
  }
  return `${url}?wemail={{{Recipient.Email}}}`;
}
