//
//  HTMLString.swift
//
//  Created by Monstarlab on 01/08/2022.
//

public let htmlString = #"""
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="https://www.google.com/recaptcha/api.js?onload=onLoad&render=explicit" async defer></script>
    <title></title>
    <script type="text/javascript">
      const post = function(message) {
          window.webkit.messageHandlers.recaptcha.postMessage(message);
      };

      var onLoad = function() {
          grecaptcha.render(
            "recaptcha",
            {
              sitekey: "${siteKey}",
              callback: function(message) {
                  post(message);
              },
              size: "normal"
            }
          );
      };
    </script>
  </head>
  <body>
      <div id="recaptcha"></div>
  </body>
</html>
"""#
