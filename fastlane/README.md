fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios certificates

```sh
[bundle exec] fastlane ios certificates
```

Get certificates

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

Generate new localized screenshots

### ios update_project_settings

```sh
[bundle exec] fastlane ios update_project_settings
```

Update App Identifier

### ios change_main_host

```sh
[bundle exec] fastlane ios change_main_host
```

Change base url

### ios change_background_color

```sh
[bundle exec] fastlane ios change_background_color
```



### ios change_launch_screen_background

```sh
[bundle exec] fastlane ios change_launch_screen_background
```



### ios set_build_number

```sh
[bundle exec] fastlane ios set_build_number
```

Set the build number to a specific value

### ios upload_app

```sh
[bundle exec] fastlane ios upload_app
```

Change base url + screenshots

### ios update_app

```sh
[bundle exec] fastlane ios update_app
```

Update App

### ios generate_new_certificates

```sh
[bundle exec] fastlane ios generate_new_certificates
```

Generate new certificates

### ios deploy

```sh
[bundle exec] fastlane ios deploy
```

deploy

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
