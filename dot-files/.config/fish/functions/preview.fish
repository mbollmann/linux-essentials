function preview --description "Preview file content"
    for arg in $argv
        set -l extname (path extension $arg | string replace "." "")
        set -l type (file --brief $arg)
        set -l type_name (string split --fields 1 -- , $type | string replace --all " " _)
        set -l mime (file --brief --mime-type $arg)
        set -l mime_base (string split --fields 1 / $mime[1])

        set -l 7z_mime_types "application/x-7z-compressed" "application/x-bzip2" \
            "application/x-lzh-compressed" "application/x-lzip" "application/x-lzma" \
            "application/x-rar" "application/zlib"

        if test "$mime_base" = "text"
            bat -p --color always --line-range :500 $arg
        else if test "$mime" = "application/json"
            bat -p --color always --line-range :500 -l json $arg
        else if test "$mime_base" = "image"; and command -q timg
            timg -g (math $FZF_PREVIEW_COLUMNS - 2)x{$FZF_PREVIEW_LINES} \
                --title="$mime[1] (%wx%h)" $arg
        else if test "$mime_base" = "video"; and command -q timg
            timg -g (math $FZF_PREVIEW_COLUMNS - 2)x{$FZF_PREVIEW_LINES} --frames 1 \
                --title="$mime[1] (%wx%h)" $arg
        else if test "$mime" = "application/pdf"; and command -q pdftotext
            pdftotext $arg - | head -n 500
        else if contains "$mime" "$7z_mime_types"; and command -q 7z
            7z -l $arg | tail -n +12
        else if test "$mime" = "application/gzip" ; and command -q gzip
            gzip --list $arg
        else if test "$mime" = "application/zip" ; and command -q unzip
            unzip -l $arg
        else
            echo $type
            echo "($mime[1])"
        end
    end
end
