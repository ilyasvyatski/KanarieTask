# CustomizableTabBar
IBDesignable UITabBar with background customisation writen in Swift


## Instalation

	pod 'CustomizableTabBar'

Your podfile must set the deployment target for 13 or above:

    platform :ios, '13.0'

Your podfile must set use_frameworks:

    use_frameworks!

## Usage

The background color must be set in the parameter CustomizableTabBar.customBackgroundColor

You may set the background color or content view to be applied only for the tab buttons, the extra area will be transparent.
	
	buttonsOnly = true

![Alt Text](https://github.com/jonathan-gomes/CustomizableTabBar/blob/main/files/vid01.gif)


You may define radius for the background
	
	radius = 20.0
	
![Alt Text](https://github.com/jonathan-gomes/CustomizableTabBar/blob/main/files/vid02.gif)

If you want to set a view for the background, eg. a VisualEffectView with blur, you have to connect the view to CustomizableTabBar's "contentView" outlet

![Alt Text](https://github.com/jonathan-gomes/CustomizableTabBar/blob/main/files/vid03.gif)

In that case, you won't be able to see the view applied in the Interface Builder, only in runtime
![Alt Text](https://github.com/jonathan-gomes/CustomizableTabBar/blob/main/files/sc01.png)

	
