# Flutter Basic Training March 2023

This repository contains the required tools, packages and files to assist you during the flutter basic training.

## Folders

> Do not change code outside of the `app` and `assignments` folders

- `assigment_solutions`: Where the trainer puts the solutions of the assignments or 'labs'
- `demos`: The code shown during the demos
- `story_gen`: Package you can use to create an interactive story generating app.
- `basic_flutter_backend`: A backend with which the app can communicate through http calls.
- `assignments`: The folder in which the student can make their own assignments, is not tracked.
- `app`: The folder in which you make the app during the course.

## Setting up

First, install [git](https://git-scm.com/downloads).

Then, clone this repository. Open your terminal in a folder where you want to have the files.
For example:
```sh
cd ~/Documents
mkdir training
cd training
git clone https://github.com/FlutterJoey/flutter_basic_june_2023.git
cd flutter_basic_june_2023
```

### Updating

whenever a demo has ended or assignments have been discussed, the code will update with the new demo and/or assignment. 
You can retrieve this code by doing:
`git pull` in the terminal within the folder named `flutter_basic_june_2023`

### Changing code outside of assignments and app
Any changes outside the assignments and app folders may result in you not being able to retrieve the code. You can remove those changes with `git fetch && git reset HEAD --hard`.