{
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles = {
      default = let
        containers = {
          Work = {
            color = "blue";
            icon = "briefcase";
            id = 1;
          };
          Life = {
            color = "green";
            icon = "tree";
            id = 2;
          };
        };
        spaces = {
          "Rendezvous" = {
            id = "572910e1-4468-4832-a869-0b3a93e2f165";
            icon = "🎭";
            position = 1000;
            container = containers.Life.id;
          };
          "Github" = {
            id = "08be3ada-2398-4e63-bb8e-f8bf9caa8d10";
            icon = "🐙";
            position = 2000;
            theme = {
              type = "gradient";
              colors = [
                {
                  red = 185;
                  green = 200;
                  blue = 215;
                  algorithm = "floating";
                  type = "explicit-lightness";
                }
              ];
              opacity = 0.8;
              texture = 0.5;
            };
          };
          "Nix" = {
            id = "2441acc9-79b1-4afb-b582-ee88ce554ec0";
            icon = "❄️";
            position = 3000;
            theme = {
              type = "gradient";
              colors = [
                {
                  red = 150;
                  green = 190;
                  blue = 230;
                  algorithm = "floating";
                  type = "explicit-lightness";
                }
              ];
              opacity = 0.2;
              texture = 0.5;
            };
          };
        };
        pins = {
          "mail" = {
            id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
            container = containers.Life.id;
            url = "https://outlook.live.com/mail/";
            isEssential = true;
            position = 101;
          };
          "Notion" = {
            id = "8af62707-0722-4049-9801-bedced343333";
            container = containers.Life.id;
            url = "https://notion.com";
            isEssential = true;
            position = 102;
          };
          "Folo" = {
            id = "fb316d70-2b5e-4c46-bf42-f4e82d635153";
            container = containers.Life.id;
            url = "https://app.folo.is/";
            isEssential = true;
            position = 103;
          };
          "Nix awesome" = {
            id = "d85a9026-1458-4db6-b115-346746bcc692";
            workspace = spaces.Nix.id;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
            position = 200;
          };
          "Nix Packages" = {
            id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
            workspace = spaces.Nix.id;
            folderParentId = pins."Nix awesome".id;
            url = "https://search.nixos.org/packages";
            position = 201;
          };
          "Nix Options" = {
            id = "92931d60-fd40-4707-9512-a57b1a6a3919";
            workspace = spaces.Nix.id;
            folderParentId = pins."Nix awesome".id;
            url = "https://search.nixos.org/options";
            position = 202;
          };
          "Home Manager Options" = {
            id = "2eed5614-3896-41a1-9d0a-a3283985359b";
            workspace = spaces.Nix.id;
            folderParentId = pins."Nix awesome".id;
            url = "https://home-manager-options.extranix.com";
            position = 203;
          };
        };
      in {
        id = 0;
        name = "ovo";
        isDefault = true;

        containersForce = true;
        pinsForce = true;
        spacesForce = true;
        inherit containers pins spaces;

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          darkreader
          vimium
          # duckduckgo-privacy-essentials
          sponsorblock
          (enhancer-for-youtube.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
          (youtube-recommended-videos.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
          (languagetool.overrideAttrs (o: {meta = o.meta // {license = lib.licenses.mit;};}))
        ];

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
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/yandex.svg";
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
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/nixos.svg";
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
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/nixos.svg";
              definedAliases = ["@no"];
            };

            "Home Manager - Options Search" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/?query={searchTerms}";
                }
              ];
              keyword = "@nh";
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/nixos.svg";
              definedAliases = ["@nh"];
            };

            "GitHub" = {
              urls = [
                {
                  template = "https://github.com/search?q={searchTerms}";
                }
              ];
              keyword = "@gh";
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/github-light.svg";
              definedAliases = ["@gh"];
            };

            "Searchix Combined" = {
              urls = [
                {
                  template = "https://searchix.ovh/?q={searchTerms}";
                }
              ];
              # No keyword defined in original JSON, so omitted here
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/searx.svg";
            };

            "Noogle" = {
              urls = [
                {
                  template = "https://noogle.dev/?q={searchTerms}";
                }
              ];
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/searxng.svg";
            };

            "MyNixOS" = {
              urls = [
                {
                  template = "https://mynixos.com/search?q={searchTerms}";
                }
              ];
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/nixos.svg";
              # No keyword defined in original JSON
            };

            "ComicK" = {
              urls = [
                {
                  template = "https://comick.io/search?q={searchTerms}";
                }
              ];
              icon = "https://comick.dev/favicon.ico";
              # No keyword defined in original JSON
            };

            "SearXNG" = {
              urls = [
                {
                  template = "https://searx.bndkt.io/search?q={searchTerms}";
                }
              ];
              suggestionsURL = "https://searx.bndkt.io/autocompleter?q={searchTerms}";
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/searxng.svg";
              # No keyword defined in original JSON
            };

            "youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results?search_query={searchTerms}&utm_source=opensearch";
                }
              ];
              keyword = "@y";
              icon = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/youtube.svg";
              definedAliases = ["@y"];
            };
          };
        };
      };
    };
  };
}
