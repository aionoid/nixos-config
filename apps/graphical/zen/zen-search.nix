{
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
}
