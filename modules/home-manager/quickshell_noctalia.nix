{lib, ...}: {
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        usb-drive-manager = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        mpd = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        mawaqit = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        workspace-overview = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screen-recorder = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        # latency-monitor = {
        #   enabled = true;
        #   sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        # };
      };
      version = 2;
    };
    # this may also be a string or a path to a JSON file.

    pluginSettings = {
      mawaqit = {
        "city" = "Adrar";
        "country" = "Algeria";
        "method" = 3;
        "school" = 0;
        "showCountdown" = true;
        "showElapsed" = false;
        "hidePrayerName" = false;
        "showNotifications" = true;
        "playAzan" = false;
        "azanFile" = "azan1.mp3";
        "hijriDayOffset" = 0;
        "tune" = false;
        "tuneFajr" = 0;
        "tuneDhuhr" = 0;
        "tuneAsr" = 0;
        "tuneMaghrib" = 0;
        "tuneIsha" = 0;
        "widgetIcon" = "building-mosque";
        "dynamicIcon" = false;
        "textColor" = "none";
        "iconColor" = "none";
        "activeColor" = "primary";
      };
      catwalk = {
        minimumThreshold = 25;
        hideBackground = true;
      };
      mpd = {
        leftButton = "next";
        rightButton = "toggle";
        middleButton = "shuffle";
        shuffleStopsPlayback = true;
      };
      # this may also be a string or a path to a JSON file.
    };
    settings = lib.mkForce {
      settingsVersion = 59;
      bar = {
        position = "top";
        monitors = [];
        density = "default";
        showOutline = false;
        showCapsule = true;
        capsuleOpacity = 0.2;
        backgroundOpacity = 0.50;
        useSeparateOpacity = false;
        floating = false;
        marginVertical = 0.25;
        marginHorizontal = 0.25;
        outerCorners = true;
        exclusive = true;
        widgets = {
          left = [
            {
              id = "Launcher";
              usePrimaryColor = true;
              icon = "3d-cube-sphere";
            }
            {
              id = "Workspace";
            }
            {
              id = "ActiveWindow";
              colorizeIcons = true;
            }
          ];
          center = [
            {
              id = "plugin:mawaqit";
            }
            {
              id = "plugin:mpd";
            }
            {
              id = "MediaMini";
            }
            {
              id = "SystemMonitor";
              compactMode = false;
            }
            # {
            #   id = "plugin:latency-monitor";
            # }
          ];
          right = [
            {
              id = "plugin:screen-recorder";
            }
            {
              id = "KeyboardLayout";
              showIcon = true;
              displayMode = "forceOpen";
            }
            {
              id = "LockKeys";
              "showCapsLock" = true;
              "showNumLock" = true;
              "showScrollLock" = false;
              "capsLockIcon" = "square-rounded-letter-c";
              "numLockIcon" = "square-rounded-letter-n";
              "scrollLockIcon" = "square-rounded-letter-s";
            }
            {
              id = "plugin:usb-drive-manager";
            }
            {
              id = "Tray";
              colorizeIcons = true;
              drawerEnabled = true;
              hidePassive = false;
              pinned = [
                "nm-applet"
                "udiskie"
              ];
              blacklist = [
              ];
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Volume";
            }
            # {
            #   id = "Brightness";
            # }
            {
              id = "Clock";
              clockColor = "none";
              customFont = "";
              formatHorizontal = "hh:mm AP ddd, MMM dd";
              formatVertical = "hh mm AP - dd MM";
              tooltipFormat = "hh:mm pm ddd, MMM dd";
              useCustomFont = false;
            }
            {
              id = "ControlCenter";
              icon = "settings";
              enableColorization = true;
              colorizeSystemIcon = "error";
            }
          ];
        };
      };
      general = {
        avatarImage = "~/.face";
        dimmerOpacity = 0.2;
        showScreenCorners = true;
        forceBlackScreenCorners = true;
        scaleRatio = 1;
        radiusRatio = 1;
        iRadiusRatio = 1;
        boxRadiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = true;
        showHibernateOnLockScreen = false;
        enableShadows = true;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        language = "";
        allowPanelsOnScreenWithoutBar = true;

        allowPasswordWithFprintd = false;
        autoStartAuth = false;
        clockFormat = "hh\\nmm";
        clockStyle = "custom";
        enableBlurBehind = true;
        enableLockScreenCountdown = true;
        enableLockScreenMediaControls = false;
        keybinds = {
          keyDown = [
            "Down"
          ];
          keyEnter = [
            "Return"
            "Enter"
          ];
          keyEscape = [
            "Esc"
          ];
          keyLeft = [
            "Left"
          ];
          keyRemove = [
            "Del"
          ];
          keyRight = [
            "Right"
          ];
          keyUp = [
            "Up"
          ];
        };
        lockScreenAnimations = false;
        lockScreenBlur = 0;
        lockScreenCountdownDuration = 10000;
        lockScreenMonitors = [
        ];
        lockScreenTint = 0;
        passwordChars = false;
        reverseScroll = false;
        showChangelogOnStartup = true;
        smoothScrollEnabled = true;
        telemetryEnabled = false;
      };
      ui = {
        fontDefault = "Roboto";
        fontFixed = "Roboto Mono";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelBackgroundOpacity = 0.93;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        boxBorderEnabled = false;
        scrollbarAlwaysVisible = true;
        settingsPanelSideBarCardStyle = false;
        translucentWidgets = false;
      };
      location = {
        name = "Adrar, Algeria";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = true;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "timer-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "~/Pictures/wallpaper/";
        monitorDirectories = [];
        enableMultiMonitorDirectories = true;
        automationEnabled = true;
        favorites = [
        ];
        linkLightAndDarkWallpapers = true;
        overviewBlur = 0.4;
        overviewTint = 0.6;
        showHiddenFiles = false;
        skipStartupTransition = false;
        sortOrder = "name";
        useOriginalImages = false;
        viewMode = "single";
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        useSolidColor = false;
        solidColor = "#1a1a2e";
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = [
          "fade"
          "disc"
          "stripes"
          "wipe"
          "pixelate"
          "honeycomb"
        ];
        transitionEdgeSmoothness = 0.05;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = true;
        useWallhaven = false;
        wallhavenQuery = "";
        wallhavenSorting = "relevance";
        wallhavenOrder = "desc";
        wallhavenCategories = "111";
        wallhavenPurity = "100";
        wallhavenRatios = "";
        wallhavenApiKey = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenResolutionHeight = "";
      };
      appLauncher = {
        enableClipboardHistory = true;
        enableClipPreview = true;
        position = "center";
        pinnedExecs = [];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        viewMode = "list";
        showCategories = true;
        iconMode = "tabler";
        showIconBackground = true;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
      };
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "PowerProfile";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        batteryCriticalThreshold = 5;
        batteryWarningThreshold = 20;
        diskAvailCriticalThreshold = 10;
        diskAvailWarningThreshold = 20;
        swapCriticalThreshold = 90;
        swapWarningThreshold = 80;
        enableDgpuMonitoring = false;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };
      dock = {
        enabled = true;
        displayMode = "auto_hide";
        backgroundOpacity = 1;
        floatingRatio = 1;
        size = 1;
        onlySameOutput = true;
        monitors = [];
        pinnedApps = [];
        colorizeIcons = false;
        pinnedStatic = false;
        inactiveIndicators = false;
        deadOpacity = 0.6;
        animationSpeed = 1;
      };
      network = {
        bluetoothAutoConnect = true;
        disableDiscoverability = false;
        networkPanelView = "wifi";
        bluetoothRssiPollingEnabled = false;
        bluetoothRssiPollIntervalMs = 10000;
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
      };
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        showKeybinds = true;
        largeButtonsStyle = false;
        largeButtonsLayout = "grid";
        powerOptions = [
          {
            action = "lock";
            enabled = true;
          }
          {
            action = "suspend";
            enabled = true;
          }
          {
            action = "hibernate";
            enabled = true;
          }
          {
            action = "reboot";
            enabled = true;
          }
          {
            action = "logout";
            enabled = true;
          }
          {
            action = "shutdown";
            enabled = true;
          }
        ];
      };
      notifications = {
        enabled = true;
        monitors = [];
        clearDismissed = true;
        density = "default";
        enableBatteryToast = true;
        enableMarkdown = false;
        enableMediaToast = false;
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = false;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "discord,firefox,chrome,chromium,edge";
        };
      };
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        backgroundOpacity = 1;
        enabledTypes = [
          0
          1
          2
          4
        ];
        monitors = [];
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 30;
        visualizerType = "linear";
        mprisBlacklist = [];
        preferredPlayer = "";
        externalMixer = "pwvucontrol || pavucontrol";
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = false;
      };
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Noctalia (default)";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        generationMethod = "tonal-spot";
        monitorForColors = "";
        syncGsettings = true;
      };
      templates = {
        activeTemplates = [
        ];
        enableUserTemplates = false;
      };
      nightLight = {
        enabled = true;
        forced = false;
        autoSchedule = true;
        nightTemp = "5600";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      hooks = {
        enabled = false;
        wallpaperChange = "";
        darkModeChange = "";
        screenLock = "";
        screenUnlock = "";
        performanceModeEnabled = "";
        performanceModeDisabled = "";
      };
      desktopWidgets = {
        enabled = true;
        gridSnap = false;
        monitorWidgets = [];
      };
    };
  };
}
