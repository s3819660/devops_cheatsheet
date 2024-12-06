########## Download ###########
"curl -L -O https://...  "     - Download file from link  
-L  handle redirect before going to the actual file
-O  save the file with the same name as in the URL
###############################


if ".zip" file  => use "unzip" command
if ".tar.gz / .tar.bz2 / .tar.xz"  => use "tar" command

########### tar ###############
-c : Create an archive file.
-t : List the contents of an archive.
-x : Extract an archive.

# Command general options:
-v : Show the files that are being archived or extracted during the tar operation.
-f : Follow this option with the archive file name to create or open.
-p : Preserve the original file permissions when extracting.
--xattrs : Enable extended attribute support, and store extended file attributes.

# The compression options to select an algorithm:
-a : Use the archives suffix to determine the algorithm to use.
-z : gzip compression algorithm, in .tar.gz suffix.
-j : bzip2 compression algorithm, in .tar.bz2 suffix.
-J : xz compression algorithm, in .tar.xz suffix.
##############################################



############ searching options ###############

# ============= find ==============
find  DIRECTORY  -option  FILENAME
-name    - search file -> return path of files that match FILENAME exactly
-iname   - files with case-insensitive text matched
-user / -group    - search by user / group name
-uid  / -gid      - search by user / group owner
-perm    - by permissions (ex: 764)
-type    - files by type in directory (ex: find /etc -type d)
# =================================

# ============= grep =============
grep -option  SEARCH-PATTERN  FILENAME
-o    - return only part matches the search term, not the whole line
-i    - case insensitive
-e    - can use -e multiple times => multiple patterns
-E    - regular expression search => use with " | " to add patterns
-c    - print only number of matches
-A / -B   - print n lines after / before

use with " | wc -option " for counting search results
# =================================

# =============== wc ==============
-l    - count by lines
-w    - count by words
-m    - count by characters
# =================================
##############################################