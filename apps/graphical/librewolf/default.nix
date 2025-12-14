{
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.file = {
    ".librewolf/default/chrome" = {
      source = ./chrome;
      recursive = true;
      executable = false;
    };
    ".librewolf/default/user.js" = {
      text = builtins.readFile ./user.js;
      executable = false;
    };
    ".librewolf/private/chrome" = {
      source = ./chrome;
      recursive = true;
      executable = false;
    };
    ".librewolf/private/user.js" = {
      text = builtins.readFile ./user.js;
      executable = false;
    };
  };
  programs.librewolf = {
    enable = true;
    # package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    package = pkgs.wrapFirefox pkgs.librewolf-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Search = true;
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };

    profiles = {
      default = {
        id = 0;
        name = "ovo";
        isDefault = true;

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          # bitwarden
          darkreader
          vimium
          duckduckgo-privacy-essentials
          sidebery
          sponsorblock
          i-dont-care-about-cookies
          adaptive-tab-bar-colour
          userchrome-toggle-extended
          #(enhancer-for-youtube.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
          (youtube-recommended-videos.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
          (languagetool.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
        ];

        # http://kb.mozillazine.org/Category:Preferences
        settings = {
          "browser.search.defaultenginename" = "duckduckgo";
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.improvesearch.handoffToAwesomebar" = false;
          # "widget.use-xdg-desktop-portal.file-picker" = 1;
          # "widget.use-xdg-desktop-portal.mime-handler" = 1;
          "browser.search.suggest.enabled" = false;
          "browser.search.suggest.enabled.private" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "browser.sessionstore.enabled" = true;
          "browser.sessionstore.resume_from_crash" = true;
          "browser.sessionstore.resume_session_once" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.tabs.drawInTitlebar" = true;
          "svg.context-properties.content.enabled" = true;
          "general.smoothScroll" = true;
          "uc.tweak.hide-tabs-bar" = true;
          "uc.tweak.hide-forward-button" = true;
          "uc.tweak.rounded-corners" = true;
          "uc.tweak.floating-tabs" = true;
          "layout.css.color-mix.enabled" = true;
          "layout.css.light-dark.enabled" = true;
          "layout.css.has-selector.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-vpx.enabled" = true;
          "browser.tabs.tabmanager.enabled" = false;
          "full-screen-api.ignore-widgets" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.addons" = false;
          "browser.urlbar.suggest.pocket" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.newtabpage.pinned" = [
            {
              title = "youtube";
              url = "https://www.youtube.com/";
            }
            {
              title = "search.nixos";
              url = "https://search.nixos.org/";
            }
            {
              title = "fosstodon";
              url = "https://fosstodon.org/";
            }
            {
              title = "gitlab";
              url = "http://www.gitlab.com/";
            }
            {
              title = "github";
              url = "https://www.github.com/";
            }
          ];
          "network.proxy.type" = true;
          "network.proxy.http" = "127.0.0.1";
          "network.proxy.http_port" = 4444;
          "network.proxy.ssl" = "127.0.0.1";
          "network.proxy.ssl_port" = 4444;
          "network.proxy.socks" = "127.0.0.1";
          "network.proxy.socks_port" = 4447;
          "dom.security.https_only_mode" = false;
          "keyword.enabled" = false;
        };

        search = {
          force = true;
          default = "google"; # Set your default search engine here
          order = [
            "Yandex"
            "NixOS packages"
            "NixOS options"
            "Home Manager - Options Search"
            "GitHub"
            "Searchix Combined"
            "Noogle"
            "MyNixOS"
            "ComicK"
            "SearXNG"
            "youtube"
          ];
          engines = {
            "Yandex" = {
              urls = [
                {
                  template = "https://yandex.com/search/?text={searchTerms}&from=os&clid=1836587";
                }
              ];
              keyword = "@yd";
              definedAliases = ["@yd"];
              suggestionsURL = "https://suggest.yandex.com/suggest-ff.cgi?part={searchTerms}&uil=en&v=3&sn=5&lr=20828&yu=1454733301756039542";
            };

            "NixOS packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              keyword = "@np";
              definedAliases = ["@np"];
            };

            "NixOS options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              keyword = "@no";
              definedAliases = ["@no"];
            };

            "Home Manager - Options Search" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/?query={searchTerms}";
                }
              ];
              keyword = "@nh";
              definedAliases = ["@nh"];
            };

            "GitHub" = {
              urls = [
                {
                  template = "https://github.com/search?q={searchTerms}";
                }
              ];
              keyword = "@gh";
              definedAliases = ["@gh"];
            };

            "Searchix Combined" = {
              urls = [
                {
                  template = "https://searchix.ovh/?q={searchTerms}";
                }
              ];
              # No keyword defined in original JSON, so omitted here
            };

            "Noogle" = {
              urls = [
                {
                  template = "https://noogle.dev/?q={searchTerms}";
                }
              ];
              # No keyword defined in original JSON
            };

            "MyNixOS" = {
              urls = [
                {
                  template = "https://mynixos.com/search?q={searchTerms}";
                }
              ];
              # No keyword defined in original JSON
            };

            "ComicK" = {
              urls = [
                {
                  template = "https://comick.io/search?q={searchTerms}";
                }
              ];
              # No keyword defined in original JSON
            };

            "SearXNG" = {
              urls = [
                {
                  template = "https://searx.bndkt.io/search?q={searchTerms}";
                }
              ];
              suggestionsURL = "https://searx.bndkt.io/autocompleter?q={searchTerms}";
              # No keyword defined in original JSON
            };

            "youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results?search_query={searchTerms}&utm_source=opensearch";
                }
              ];
              keyword = "@y";
              definedAliases = ["@y"];
            };
          };
        };

        # userChrome = builtins.readFile ./userChrome.css;
        # userContent = builtins.readFile ./userContent.css;
      };

      private = {
        id = 1;
        name = "I2P";
        isDefault = false;

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          # ublock-origin
          # bitwarden
          darkreader
          vimium
          # duckduckgo-privacy-essentials
          sidebery
          sponsorblock
          # i-dont-care-about-cookies
          adaptive-tab-bar-colour
          userchrome-toggle-extended
          #(enhancer-for-youtube.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
          # (youtube-recommended-videos.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
          # (languagetool.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
        ];

        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "identity.fxaccounts.enabled" = false;
          "browser.search.defaultenginename" = "duckduckgo";
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          # "widget.use-xdg-desktop-portal.file-picker" = 1;
          # "widget.use-xdg-desktop-portal.mime-handler" = 1;
          "browser.search.suggest.enabled" = false;
          "browser.search.suggest.enabled.private" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "browser.sessionstore.enabled" = true;
          "browser.sessionstore.resume_from_crash" = true;
          "browser.sessionstore.resume_session_once" = true;
          "browser.tabs.drawInTitlebar" = true;
          "svg.context-properties.content.enabled" = true;
          "general.smoothScroll" = true;
          "uc.tweak.hide-tabs-bar" = true;
          "uc.tweak.hide-forward-button" = true;
          "uc.tweak.rounded-corners" = true;
          "uc.tweak.floating-tabs" = true;
          "layout.css.color-mix.enabled" = true;
          "layout.css.light-dark.enabled" = true;
          "layout.css.has-selector.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-vpx.enabled" = true;
          "browser.tabs.tabmanager.enabled" = false;
          "full-screen-api.ignore-widgets" = false;
          #network.proxy.type", 1); (for manual configuration)
          #network.proxy.http", "wwwproxy.example.com");
          #network.proxy.http_port", 3128);
          #network.proxy.ssl", "wwwproxy.example.com");
          #network.proxy.ssl_port", 3128);
          "network.proxy.type" = true;
          "network.proxy.http" = "127.0.0.1";
          "network.proxy.http_port" = 4444;
          "network.proxy.ssl" = "127.0.0.1";
          "network.proxy.ssl_port" = 4444;
          "network.proxy.socks" = "127.0.0.1";
          "network.proxy.socks_port" = 4447;
          "dom.security.https_only_mode" = false;
          "keyword.enabled" = false;
        };

        # userChrome = builtins.readFile ./userChrome.css;
        # userContent = builtins.readFile ./userContent.css;
      };
    };
  };
}
