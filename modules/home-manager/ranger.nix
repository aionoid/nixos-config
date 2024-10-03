{pkgs, ...}: {
  programs.ranger = {
    enable = true;
    settings = {
      use_preview_script = true;
      preview_files = true;
      preview_images = true;
      # preview_images_method = "ueberzug";
      preview_images_method = "kitty";
      collapse_preview = true;
      column_ratios = "1,2,3";
      draw_borders = "outline";
      bidi_support = true;
    };
  };
  home.packages = with pkgs; [
    #CORE
    file
    python3Packages.python-bidi
    python3Packages.chardet
    # for previews with scope.sh
    # img2txt (from caca-utils) for ASCII-art image previews
    # w3mimgdisplay, ueberzug, mpv, iTerm2, kitty, terminology or urxvt for image previews
    ueberzug
    # convert (from imagemagick) to auto-rotate images and for image previews
    imagemagick
    # rsvg-convert (from librsvg) for SVG previews
    librsvg
    # ffmpeg, or ffmpegthumbnailer for video thumbnails
    ffmpeg
    ffmpegthumbnailer
    # highlight, bat or pygmentize for syntax highlighting of code
    #bat # from programs.bat.enable
    # atool, bsdtar, unrar and/or 7z to preview archives
    # bsdtar, tar, unrar, unzip and/or zipinfo (and sed) to preview archives as their first image
    atool
    unrar
    unzip
    # p7zip
    p7zip-rar
    # lynx, w3m or elinks to preview html pages
    w3m
    # pdftotext or mutool (and fmt) for textual pdf previews, pdftoppm to preview as image
    poppler_utils
    # djvutxt for textual DjVu previews, ddjvu to preview as image
    djvulibre
    # calibre or epub-thumbnailer for image previews of ebooks
    epub-thumbnailer
    # transmission-show for viewing BitTorrent information
    libtransmission_4
    # mediainfo or exiftool for viewing information about media files
    mediainfo
    # odt2txt for OpenDocument text files (odt, ods, odp and sxw)
    odt2txt
    # python or jq for JSON files
    jq
    # sqlite3 for listing tables in SQLite database (and optionally sqlite-utils for fancier box drawing.)
    sqlite-utils
    # jupyter nbconvert for Jupyter Notebooks
    # fontimage for font previews
    fontforge
    # openscad for 3D model previews (stl, off, dxf, scad, csg)
    # openscad
    # draw.io for draw.io diagram previews (drawio extension)
  ];
}
