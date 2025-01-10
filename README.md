## Yor-Slideshow. TUI for Linux Gnome and KDE.

Make and Set Wallpaper Slideshows in 1 action. The practicality for this TUI is the easibility of having an xml file that you don't need to manually edit, adjusting date and time, adding/removing pictures whenever you update your collection, editting the order of the pictures which gnome extensions especially don't do, they typically transition the wallpapers in random order. This script does it all automatically for you.

## Preview
> For the purpose of this demonstration the slideshow duration is set to 5 seconds.

https://github.com/user-attachments/assets/e242ba1b-ba13-4150-950b-2cc65dcf994f

## Usage

To download & run:
```
git clone https://github.com/soulhotel/yor-slideshow.git
cd yor-slideshow
chmod +x yor-slideshow.sh      # to make it executable
./yor-slideshow.sh             # to run yor-slideshow
```
To use it like any other application:
1. Included is a .desktop file.
2. First, directory for the .desktop file is set to `/home/j/` which is Me.. so lets set it to You.
3. Then move it to your application folder
4. Then open your APPs and Enjoy.
```
sed -i "s|/home/j/|/home/$USER/|" slideshow.sh  # set the User to You
mv slideshow.sh ~/.local/share/applications/    # move it to app folder
```


## Modification
- You can modify `yor-slideshow.sh` by opening it in a text editor
    - line 4 ~ The slideshow is created based on folders found in `image_base_folder`, the default is `/Pictures`.
    - line 5 ~ Is the duration for each slide, by default each slide is a 30 second `duration_seconds` transition.
- When picking a folder a new `slideshow_foldername.xml` will be created in the `image_base_folder` location.
- ^ This means that, yes, you can create xml files for each/all folders, without having to manually rename them.
- If the slideshow.xml already exist, it will erase/update/rewrite it.
