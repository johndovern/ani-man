# ani-man
Track, play, and browse your locally downloaded anime with this bash script.

## Video demonstration & tl;dr
Don't like to read? Checkout a [this](https://youtu.be/NeF56_JBagM) video where I go over installation, configuration, and use of ani-man.

## Why use ani-man?
Good question.

You've got plenty of ways to watch and track your anime. Popular options are jellyfin or plex. These are great both applications, but for me they are totally overkill.

My needs:

  - [X] 100% offline functionality
  - [X] 100% local tracking
  - [X] Flexible directory structure
  - [X] Track last watched episodes
  - [X] Track last watched shows
  - [X] Full mpv support

I made ani-man to tick all of these boxes and it does just that in a simple way.

## Only for local files?
Not necessarily. You can mount a remote filesystem using NFS, sshfs, or SMB (what I use). I'm sure there are tons of other ways to mount remote file systems so that they are available on your local machine.

The only requirement is that you can cd into the directory that has the files you want to add to your library. If you can do that you can use ani-man to track and watch these videos.

For those looking to stream anime you should checkout [ani-cli](https://github.com/pystardust/ani-cli) which allows you to browse and watch anime from the cli. Pretty neat stuff.

## Only for anime?
Not at all.

I wrote ani-man with this in mind but there is no reason you cannot use it to keep track of any other type of video library.

## 100% local? 100% offline?
Yep. But it doesn't have to be.

Feel free to setup `~/.config/ani-man` as a syncthing share and keep your library and progress synced accross your laptop(s) and desktop(s).

## Installation
### Using make

```bash
git clone "https://github.com/johndovern/ani-man.git"
cd ani-man
make install
```

The Makefile will install the following files to the following directories:

```
ani-man           ->    $HOME/.local/bin
ani-man.conf      ->    $HOME/.config/ani-man
ani-man.filters   ->    $HOME/.config/ani-man
ani-man.lua       ->    $HOME/.config/mpv/scripts
ani-man.conf      ->    $HOME/.config/mpv/script-opts
```

If these directories do not exist they will be created.

Most importantly if `$HOME/.local/bin` is **not** in your `PATH` please change that asap. Or edit the make file to install to a different location.

### Using [MPlug](https://github.com/Nudin/mplug)
Currently the [PR](https://github.com/Nudin/mpv-script-directory/pull/4) to include ani-man is not merged.

These instructions are provided in anticipation of when it will be available via MPlug.

MPlug is plugin manager for mpv lua scripts. If you have mplug installed you can run

```bash
mplug install ani-man
ani-man --setup
```

By default MPlug installs executable files like ani-man to `~/bin`. Please ensure this is in your `PATH` before running `ani-man --setup`.

MPlug will install almost all the necessary files for ani-man. Using `ani-man --setup` will complete the installation process.

### Dependencies
- sed
- dmenu or fzf
- find
- mpv
- bash

**Optional**

- a notification deamon that responds to the `notify-send` command

# Getting started
## Configuration
### BASE_DIR
After installing ani-man you'll want to configure ani-man.conf. The most
important item to add to this file is the location of your `BASE_DIR`. This must
be the full path to wherever you keep your anime.

Example:

```bash
BASE_DIR="/mnt/sdc1/Videos/Anime"
```

Without a `BASE_DIR` ani-man will not work. There are no requirements for the
layout of your `BASE_DIR`. Any directory that contains a file with a
[valid](https://github.com/johndovern/ani-man#Valid-extensions) file extension is
considered a _show_ to ani-man. The directory structure is up to you.

### PROMPT_CMD
You can use dmenu or fzf to repond to ani-man prompts. To use fzf set the `PROMPT_CMD` variable in `ani-man.conf` like so:

```bash
PROMPT_CMD="fzf"
```

If this variable is not set or spelt incorrectly then dmenu is assumed to be the desired prompt.

### FILE_MANAGER
With ani-man you can browse your `BASE_DIR` with your file manager of choice. If you use lf and your terminal emulator is st you would set your the `FILE_MANAGER` variable like this:

```bash
FILE_MANAGER="st -e lf"
```

For GUI file managers you can set them with just the command:

```bash
FILE_MANAGER="pcmanfm"
```

### MAX_HISTORY
ani-man tracks your episode progress of each show, but it also keeps a log of the last `N` number of shows you've watched.

Set the `MAX_HISTORY` variable to some number of shows that you wish to mark as your latest shows.

The default is 10, but you can change this in ani-man.conf like so:

```bash
MAX_HISTORY=5
```

### FILTERS
You may not want ani-man to consider every directory with a [valid](https://github.com/johndovern/ani-man#Valid-extensions) file in it as a show. I know I don't. For that reason you can set a list of filters that ani-man will apply when building your library by adding names to filter in the `ani-man.filters` file.

The included filters file has some filters preset. These were all directories that I found no use to keep track of. You can remove or include whatever directories you like by simply writing the name of the directory in this file. The names will be split on newlines and tabs. Spaces are fine and you do not need to add quotes unless the directory you want to filter contains quotes.

**Please note**: the filters only apply to individual directories themselves and not their subdirectories.

If you have a filter for `Extras` any directory named `Extras` will be filtered. However, if `Extras/More-extras` exists and has valid files inside of it, ani-man will not filter it. In this case ani-man sees `Extras/More-extras` as the last directory `More-extras`. You would need a filter for `More-extras` in order to filter this directory as well.

I may look into optionally filtering subdirectories as well. However, my present attempts are ugly, and I am not confident in their reliability. I am happy to take suggestions for this; as well as, any optimizations or features anyone might have to suggest.

### DEBUG
By default ani-man sends progress notes and errors via notify-send. However, this can be changed by setting `DEBUG=1` in ani-man.conf. Alternatively you can use the `-d, --debug` flag to get this behavior on demand.

## Building your library
Okay, so ani-man is configured with a `BASE_DIR` set and all other options configured to your liking. Congratulations, you're ready to get started building your library.

Open a terminal and run the following command:

```
ani-man -b -d
```

The `-d` flag is suggested as without it your notification daemon may be spammed.

This will automatically build your library and set the title value for your shows. By default ani-man tries to set show titles to something sane. Read about the automatically generated titles [here](https://github.com/johndovern/ani-man#Automatically-generated-titles).

### Setting the title of a show interactively
If you want to set the title yourself can use the `-i, --interactive` flag. If this is supplied you will be prompted via dmenu or a read prompt to set a shows title. You may set the title to almost any value you like.

If the command was run in a terminal you will see the automatically generated name for the show. If you press ESC in dmenu or enter nothing into the read prompt the generated title will be used for that show.

The following characters will never be used for titles even if you supply them in the prompt:

```
!\@#$%^&*{}/<>?'":+`|=
```

If given the character will be replaced with a `-`.

### The library file
Now you have a library file with all the unfiltered shows that ani-man could find. Your library file contains three parts:

  1. The directory of the show (relative to your `BASE_DIR`)
  2. The auto generated or custom title
  3. The last tracked episode (this will be blank when running `-b`)

This file has a very specific structure with a very specific delimiter between the three parts. That delimiter is the less than symbol, `<`. You should not need to manipulate the library file yourself, but if you want to rename a show or something do not use this character or ani-man will not work as intended.

More importantly any shows with directory names that contain a less than symbol will need to be renamed by you as ani-man will ignore these directories and their subdirectories. This filtering is separate from your filters.

Your `BASE_DIR` may contain a less than symbol as all directories listed in your library are relative to your `BASE_DIR`.

## Using ani-man
Now that you've built your library you can start watching and tracking your anime.

As you've just built your library you don't have a log yet. Because of that you are going to want to run this command, either through dmenu, a terminal, or via some hot-key:

```bash
ani-man -w
```

You will be prompted with a list of all the titles in your library. Select one of the show titles and you will be given another prompt displaying all the episodes found for that show. Select an episode and watch some anime.

Please see [this](https://github.com/johndovern/ani-man#Note-on-use-with-hot-keys) section for more info on starting ani-man via a hot-key or dmenu.

### Watching your last watched shows
At this point ani-man is tracking the shows you watch in your library and history log. You can now run following command through dmenu, a terminal, or via a hot-key:

```bash
ani-man -l
```

With this you will see a dmenu or fzf prompt showing you the titles of your last watched shows. These shows are being tracked which means once you select one mpv will open and start playing your last watched episode.

It is advisable that you close mpv on the episode you wish to resume. You can also use `Q` instead of `q` to save and quit (an mpv native feature which has nothing to do with ani-man). Then you'll start off exactly where you left off.

You can always use `ani-man -w` to watch and track any show in your library. If the show has a last watched episode that episode will be started in mpv and you will not be shown a prompt to watch any other episodes of that show.

## ani-man.lua
The secret sauce of ani-man is the ani-man.lua script. This script can work in two ways:

  1. Enable it by default via `script-opts/ani-man.conf` by setting

      `enabled=yes`

  2. Enable it when you run mpv like so

      `mpv --script-opts=ani-man-enabled=yes /path/to/file`

The full path to `script-opts/ani-man.conf` is `~/.config/mpv/script-opts/ani-man.conf`.

If you leave this file alone you must launch mpv with `mpv --script-opts=ani-man-enabled=yes /path/to/file` to enable ani-man.lua.

This is too long to type out. Instead you can use ani-man as an mpv wrapper by running `ani-man -o /path/to/file` which will enable ani-man.lua. Both `ani-man -w` and `-l` launch mpv in this way.

### How ani-man.lua works
When enabled ani-man.lua will get the currently playing file's path and set it to the variable `trackPath`. After that it will run `ani-man -s "$trackPath"`. The `-s, --search` flag takes a file path and searches the shows in your library for the given file. If the file is found it will exit successfully. If it isn't found ani-man will exit with an error code.

If the search was successful ani-man.lua will then run `ani-man -t "$trackPath"`. The `-t, --track` flag takes a file path. It repeats the same search as `-s` just to be safe. If the search is successful your library and history log will be updated appropriately.

### Enabling ani-man.lua by default
If `enabled=yes` is set in `~/.config/mpv/script-opts/ani-man.conf` then ani-man.lua will run `ani-man -s "$trackPath"` for every file you watch with mpv. The benefit of this is that your library and history logs will always be kept up to date as long as you watch your anime in mpv. You will not have to use `ani-man -o /path/to/file` as a wrapper for mpv, but you can if you want.

There is really no downside to making this change, but I think it is better as an opt in setting rather than forcing this on you.

## Updating your library
That's pretty much all there is to ani-man. You've set your `BASE_DIR`, your `PROMPT_CMD`, your `FILE_MANAGER`, your `MAX_HISTORY`, and your `FILTERS`. You've built your library, and started taking advantage of ani-man's 100% local tracking. But of course you're still downloading more anime and saving it to your `BASE_DIR`. You run `ani-man -w` and what the !@$# your freshly downloaded anime isn't listed. What gives? Not to worry you've just got to update your library.

To update your library just run `ani-man -u`. This will backup your current library in case you don't like how the update went. You can use the `-c, --clean` flag if you don't want to keep a backup.

When you update your library ani-man will do it's best to detect any shows that already exist in your library and still exist in your `BASE_DIR`. If a show has not changed locations then any episode progress will be carried over to the updated library along with any title you may have set for the show.

If the shows directory has changed it will be treated as a new show and your show progress will be lost. I do not have any simple way around this and I do not consider this an issue.

Any new shows will be added with an automatically generated title.

### Updating interactively
If you wish to set the title yourself use the `-i, --interactive` flag. You should also use the `-d` flag and be sure to run ani-man in a terminal.

Running `ani-man -d -i -u` will give you a prompt asking you to set a title for the given show. It will also display either the previous title or an automatically generated title if the show is new. If you are using dmenu you can press ESC to accept the previous or automatic title. If you are using fzf this will be a read prompt in which case enter nothing to accept the previous or automatic title.

## Wrapping up
### Valid extensions
I mentioned earlier that only directories with valid file extensions are considered shows and added to your library. So what is a valid file extension? Well, here is a list of all file extensions that ani-man considers valid:

  - mkv
  - mp4
  - mpg
  - mp2
  - mpeg
  - mpe
  - mpv
  - ogg
  - webm
  - m4p
  - m4v
  - avi
  - wmv
  - mov
  - qt
  - flv
  - swf
  - avchd

You might be thinking "Wow, that's a lot of extensions! The find command must be very long." Well, you're half right. That is a lot of extensions but the _find_ command is very short.

#### How ani-man build's your library
This is the command that ani-man uses to build your library:

```bash
  while read -r DIR ; do
    ...
  done < <(find "${BASE_DIR}" -type f -printf '%P\n' | \
    sed '/^.*\.\(mkv\|mp4\|mpg\|mp2\|mpeg\|mpe\|mpv\|ogg\|webm\|m4p\|m4v\|avi\|wmv\|mov\|qt\|flv\|swf\|avchd\)$/!d;s/\(^.*\)\/.*$/\1/g' | \
    sort -u)
```

Maybe it's just my system but when I give `find` a lot of flags it runs very slowly. For that reason I am using sed to filter find's results.

If a file path does not end in one of the given file extensions it is filtered from the results.

Any path that does end in a valid extension is then striped of the file leaving only the directory.

Finally we sort the directory results to ensure they are in alphabetical order and unique.

Pretty simple and most importantly fast. However, you want to make sure your `BASE_DIR` is as close to your videos as possible. Don't set it to `$HOME` if all your videos are in `~/Videos/Anime`.

### Automatically generated titles
I've mentioned these automatically generated titles a few times, but what the heck does that look like? Well, here is an example:

```bash
$ DIR="[Commie] Space Dandy - Volume 6 [BD 720p AAC]"
$ CLEAN_TITLE="$(printf '%s\n' "${DIR//\// - }" | sed 's/\s\+\?\[[^]]*\]\s\+\?//g')"
$ printf '%s\n' "${CLEAN_TITLE//[\!\\@#$%^&*\{\}\/<>?\'\":+\`|=]/-}"
Space Dandy - Volume 6
```

All the info that comes with a torrent is great but it doesn't look great. This it a pretty effective way of cleaning most directories and getting something that looks like a title.

Here is another example. This is a larger torrent with a path that is two directories deep:

```bash
$ DIR="[Anime Time] Little Busters! (S1+S2+S3+OVA) [BD][HEVC 10bit x265][AAC][Eng Sub]/Little Busters! Season 1"
$ CLEAN_TITLE="$(printf '%s\n' "${DIR//\// - }" | sed 's/\s\+\?\[[^]]*\]\s\+\?//g')"
$ printf '%s\n' "${CLEAN_TITLE//[\!\\@#$%^&*\{\}\/<>?\'\":+\`|=]/-}"
Little Busters- (S1-S2-S3-OVA) - Little Busters- Season 1
```

The output isn't perfect, but boy does it happen fast and looks a whole lot better.

When using ani-man if you use the `-i` flag when updating or building your library you will get a chance to see a preview of what the title will look like if you enter nothing. So you can make the call on what you want your anime titles to be.

### Note on use with hot-keys
I use sxhkd to start ani-man for most operations. I also use dmenu as my default prompt. If this is you then ani-man will "just work".

If you use fzf you want to start ani-man with a hot-key you will need to make sure you do this within a terminal. I use st which means I would put this in my sxhkdrc:

```bash
super + a
  st -e ani-man -w
```

This ensures that ani-man is running in a terminal and that you will be able to respond to the fzf or read prompts.

### Browsing your BASE_DIR
If you've set a `FILE_MANAGER` then you can run ani-man with the `-B, --browse` flag. This will open your `BASE_DIR` in your chosen FILE_MANAGER.

## Disclaimer
This project is considered complete. The scope of features I set out to implement has been achieved. If you have a feature suggestion I will gladly hear and consider it. I may add new features but at present I can't think of anything I would add to this project. If anything I would like to strip it down more and make it more portable.

I have done a limited amount of testing relative to the possible directory names and structures that ani-man may encounter. If you run into an error (my guess is that it has to do with sed) then please open an issue with as much relevant information as needed. I will do my best to come up with a solution or review any proposed solutions.
