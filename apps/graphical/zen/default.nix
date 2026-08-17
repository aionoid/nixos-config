{
  lib,
  pkgs,
  inputs,
  ...
}: let
  search = import ./zen-search.nix;
in {
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
      HomePage = {
        StartPage = "homepage";
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
          "Fun" = {
            id = "572910e1-4468-4832-a869-0b3a93e2f165";
            icon = "🎭";
            position = 1000;
            container = containers.Life.id;
          };
          "Work" = {
            id = "08be3ada-2398-4e63-bb8e-f8bf9caa8d10";
            icon = "🐙";
            position = 2000;
            container = containers.Work.id;
            theme = {
              type = "gradient";
              colors = [
                {
                  red = 6;
                  green = 56;
                  blue = 168;
                  # isCustom = false;
                  algorithm = "analogous";
                  # isPrimary = true;
                  lightness = 33;
                  position = {
                    x = 131;
                    y = 137;
                  };
                  type = "undefined";
                }
                {
                  red = 85;
                  green = 6;
                  blue = 163;
                  # isCustom = false;
                  algorithm = "analogous";
                  # isPrimary = false;
                  lightness = 33;
                  position = {
                    x = 180;
                    y = 115;
                  };
                  type = "undefined";
                }
                {
                  red = 6;
                  green = 163;
                  blue = 142;
                  # isCustom = false;
                  algorithm = "analogous";
                  # isPrimary = false;
                  lightness = 33;
                  position = {
                    x = 116;
                    y = 189;
                  };
                  type = "undefined";
                }
              ];
              opacity = 0.25;
              texture = 0.9375;
            };
          };
          # "Nix" = {
          #   id = "2441acc9-79b1-4afb-b582-ee88ce554ec0";
          #   icon = "❄️";
          #   position = 3000;
          #   theme = {
          #     type = "gradient";
          #     colors = [
          #       {
          #         red = 150;
          #         green = 190;
          #         blue = 230;
          #         algorithm = "floating";
          #         type = "explicit-lightness";
          #       }
          #     ];
          #     opacity = 0.2;
          #     texture = 0.5;
          #   };
          # };
        };
        pins = {
          # === WORK Container Pins ===
          #============================
          "Gemini" = {
            id = "546bb49f-d82f-4057-9462-55dcb5491b98";
            container = containers.Work.id;
            url = "https://gemini.google.com/app";
            isEssential = true;
            position = 101;
          };
          "ComfyUI" = {
            id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
            container = containers.Work.id;
            url = "http://localhost:8188";
            isEssential = true;
            position = 102;
          };
          "Hermes-WebUI" = {
            id = "8af62707-0722-4049-9801-bedced343333";
            container = containers.Work.id;
            url = "http://localhost:8787";
            isEssential = true;
            position = 103;
          };
          "AI-Toolkit" = {
            id = "fb316d70-2b5e-4c46-bf42-f4e82d635153";
            container = containers.Work.id;
            url = "http://localhost:3000";
            isEssential = true;
            position = 104;
          };
          "Open-Design" = {
            id = "4220b732-cfc4-4d98-b2ef-fcc3dc14252f";
            container = containers.Work.id;
            url = "http://localhost:36037";
            isEssential = true;
            position = 105;
          };
          "Hermes-Dashboard" = {
            id = "c4127e51-d197-48cd-a049-64609c7e7ff5";
            container = containers.Work.id;
            url = "http://localhost:9119";
            isEssential = true;
            position = 106;
          };
          # === Life/Fun Container Pins ===
          #================================
          "MangaBall" = {
            id = "bd1e851a-d4c2-4126-b51a-5e0a6daf7ec0";
            container = containers.Life.id;
            url = "https://mangaball.net/community/notifications/";
            isEssential = true;
            position = 107;
          };
          "NicoManga" = {
            id = "ca3643f0-ae23-4856-b66d-499886888952";
            container = containers.Life.id;
            url = "https://nicomanga.com/account/app=mangaview=manga_bookmark";
            isEssential = true;
            position = 108;
          };
          "Youtube" = {
            id = "ae0996e8-8017-4f97-ab67-293e49e979b2";
            container = containers.Life.id;
            url = "https://www.youtube.com/";
            isEssential = true;
            position = 109;
          };
          #=== Work Space Groups ===
          #=========================
          "Manga Fun" = {
            id = "bfb73fe9-22fc-45d6-87e9-0cf3b6e52044";
            workspace = spaces.Fun.id;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
            position = 200;
          };
          "Helper Apps" = {
            id = "d85a9026-1458-4db6-b115-346746bcc692";
            workspace = spaces.Work.id;
            isGroup = true;
            isFolderCollapsed = false;
            editedTitle = true;
            position = 201;
          };
          "Nix Packages" = {
            id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
            workspace = spaces.Work.id;
            folderParentId = pins."Helper Apps".id;
            url = "https://search.nixos.org/packages";
            position = 201;
          };
          "Nix Options" = {
            id = "92931d60-fd40-4707-9512-a57b1a6a3919";
            workspace = spaces.Work.id;
            folderParentId = pins."Helper Apps".id;
            url = "https://search.nixos.org/options";
            position = 202;
          };
          "Home Manager Options" = {
            id = "2eed5614-3896-41a1-9d0a-a3283985359b";
            workspace = spaces.Work.id;
            folderParentId = pins."Helper Apps".id;
            url = "https://home-manager-options.extranix.com";
            position = 203;
          };
        };
        force = false;
      in {
        id = 0;
        name = "ovo";
        isDefault = true;

        containersForce = force;
        pinsForce = force;
        spacesForce = force;
        inherit containers pins spaces search;

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
      };
    };
  };
}
