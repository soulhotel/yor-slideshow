Make and Set Wallpaper Slideshows in 1 action. TUI for Linux Gnome and KDE.

### <ins>Preview
> For the purpose of this demonstration the slideshow duration is set to 5 seconds.

https://github.com/user-attachments/assets/e242ba1b-ba13-4150-950b-2cc65dcf994f

### <ins>Usage

To download & run:
```
git clone https://github.com/soulhotel/yor-slideshow.git
cd yor-slideshow
chmod +x yor-slideshow.sh      # to make it executable
./yor-slideshow.sh             # to run yor-slideshow
```
To use it like any other application:
1. Included is a .desktop file.
2. The directory for the .desktop file is set to `/home/j/` which is Me.. so lets set it to You.
```
sed -i "s|/home/j/|/home/$USER/|" slideshow.sh
```
3. Now lets move it to your application folder
```
mv slideshow.sh ~/.local/share/applications/
```
4. Open your APPs and Enjoy.

### <ins>Modification
- You can modify `yor-slideshow.sh` by opening it in a text editor
    - line 4 ~ The slideshow is created based on folders found in `image_base_folder`, the default is `/Pictures`.
    - line 5 ~ Is the duration for each slide, by default each slide is a 30 second `duration_seconds` transition.
- When picking a folder a new `slideshow_foldername.xml` will be created in the `image_base_folder` location.
- If the slideshow.xml already exist, it will erase/update/rewrite it.
