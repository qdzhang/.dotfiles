# Firefox custom css

## Enable userChrome customization in about:config
Go to `about:config` and set the pref `toolkit.legacyUserProfileCustomizations.stylesheets` to true

## Locate and open your profile folder
Go to `about:support` and find a `Profile Directory`, click on the `Open Directory` button

## Create the folder and its files
Create `userchrome.css` and `userContent.css` file under `<profileFolder>/chrome/`. Copy the above css contents into the two new css files
