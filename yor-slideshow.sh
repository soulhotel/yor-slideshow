#!/bin/bash

# Variables
image_base_folder="/home/$USER/Pictures/walls"
duration_seconds="30.0"

while true; do
    clear
    
    echo -e "
┓┏┏┓┳┓  ┏┓┓ ┳┳┓┏┓┏┓┓┏┏┓┓ ┏
┗┫┃┃┣┫  ┗┓┃ ┃┃┃┣ ┗┓┣┫┃┃┃┃┃
┗┛┗┛┛┗  ┗┛┗┛┻┻┛┗┛┗┛┛┗┗┛┗┻┛        
                
This script will Make & Set Wallpaper Slideshows for Desktop's by creating an XML file that rotates through images sourced from a designated location. The XML file format for slideshow wallpapers is supported by both Gnome and KDE, and possibly other DE's. This script can also be used to update your slideshow's with current/changed/deleted images in your chosen directory, so without further ado..     
    
Make a Wallpaper Slideshow from folders found in $image_base_folder...
"
    
    # List available folders
    slideshow_sources=()
    index=1

    # Populate the list of folders
    for folder in "$image_base_folder"/*; do
        if [[ -d "$folder" ]]; then
            slideshow_sources+=("$folder")
            folder_name=$(basename "$folder")
            echo "$index) $folder_name"
            ((index++))
        fi
    done

    # Check if any folders were found
    if [[ ${#slideshow_sources[@]} -eq 0 ]]; then
        echo -e "\n No folders found in $image_base_folder. Exiting."
        exit 1
    fi

    # Prompt user to pick a folder
    echo
    read -p "Pick a folder: " user_choice
    if ! [[ "$user_choice" =~ ^[0-9]+$ ]] || [[ "$user_choice" -lt 1 ]] || [[ "$user_choice" -gt ${#slideshow_sources[@]} ]]; then
        echo -e "\n Invalid choice. Please try again."
        continue
    fi

    # Set the selected folder
    slideshow_source="${slideshow_sources[$((user_choice - 1))]}"
    folder_name=$(basename "$slideshow_source")
    xml_file="${image_base_folder}/slideshow_${folder_name}.xml"

    # Create or overwrite the XML file
    > "$xml_file"
    echo "<background>" > "$xml_file"
    echo "  <starttime>" >> "$xml_file"
    echo "    <year>$(date +%Y)</year>" >> "$xml_file"
    echo "    <month>$(date +%m)</month>" >> "$xml_file"
    echo "    <day>$(date +%d)</day>" >> "$xml_file"
    echo "    <hour>$(date +%H)</hour>" >> "$xml_file"
    echo "    <minute>$(date +%M)</minute>" >> "$xml_file"
    echo "    <second>$(date +%S)</second>" >> "$xml_file"
    echo "  </starttime>" >> "$xml_file"

    # Add each image to the XML file
    for image in "$slideshow_source"/*.png; do
        echo "  <static>" >> "$xml_file"
        echo "    <duration>$duration_seconds</duration>" >> "$xml_file"
        echo "    <file>$image</file>" >> "$xml_file"
        echo "  </static>" >> "$xml_file"
    done

    # Close the XML structure
    echo "</background>" >> "$xml_file"

    # Inform the user
    echo -e "\nA new XML file \e[32m$xml_file\e[0m has been created based on all images found in \e[32m$slideshow_source\e[0m..."

    # Set the wallpaper
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$xml_file"
    gsettings set org.gnome.desktop.background picture-uri "file://$xml_file"
    gsettings set org.gnome.desktop.background picture-options "zoom"

    echo -e "\nSlideshow is now in use!"

    # Repeat or exit
    echo
    read -p "Press Enter to EXIT, or press s to do it again: " repeat_choice
    if [[ "$repeat_choice" != "s" ]]; then
        break
    fi
done

