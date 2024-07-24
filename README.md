# Garble Git Repo

## Short description

Read the whole history of a given Git repo commit by commit and write the content to a given folder adding random commits to the history

## A slightly longer description

* Input
  * A folder that contains the _original_ Git repository
  * A name of a folder where the out put is written to.
    This should be a _new_ folder or at least an empty one.
    It's **STRONGLY** advised **AGAINST** using the same folder name for both.
* Output
  * The commits of the _original_ repository are 'replayed' into the new one and 'decorated' with random commits that add random files & changes (but don't change whatever is read from the original repo).

