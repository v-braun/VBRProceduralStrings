# VBRProceduralStrings
> UIImageView extension for procedural generation of beautiful svg shapes

By [v-braun - viktor-braun.de](https://viktor-braun.de).

[![](https://img.shields.io/github/license/v-braun/VBRProceduralStrings.svg?style=flat-square)](https://github.com/v-braun/VBRProceduralStrings/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/v-braun/VBRProceduralStrings.svg?branch=master)](https://travis-ci.org/v-braun/VBRProceduralStrings)
![Cocoapods](https://img.shields.io/cocoapods/v//VBRProceduralStrings.svg?style=flat-square)

<p align="center">
<img width="40%" src="https://github.com/v-braun/VBRProceduralStrings/blob/master/.assets/Screenshot.png" />
</p>


## Description


## Installation
### CocoaPods
VBRProceduralStrings is available on [CocoaPods](http://cocoapods.org). Just add the following to your project Podfile:

```ruby
pod 'VBRProceduralStrings'
```

Or from GitHub:

```ruby
pod 'VBRProceduralStrings', :git => 'https://github.com/v-braun/VBRProceduralStrings.git'
```

*VBRProceduralStrings* use [Macaw](https://github.com/exyte/Macaw) to parse the generated SVG content and render it on an CALayer. You should add it also to your Podfile

### Manually
1. Download and drop ```VBRProceduralStrings.swift``` in your project.  
2. Add Macaw to your project
3. Congratulations!  


## Usage

### Create an UIView
``` swift
    
    let settings = ProcStringsSettings()
    // _svgView is a placeholder that was setup on the main view via interfacebuilder
    // see the example project for that
    // you should do that in viewDidAppear that guarantee that width and hight has correct values
    settings.width = Float(_svgView.bounds.width) 
    settings.height = Float(_svgView.bounds.height)
    settings.lines = 100
    settings.points = 8
    // horizontal gradients
    settings.gradients.append(GradientStep(offset: 0, color: "#03a9f4")) 
    settings.gradients.append(GradientStep(offset: 70, color: "#e91e63"))
    
    let subView = ProceduralStringGenerator.generateSVGUIView(settings: settings)
    self.addSubView(subView)

```

### Create an UIImage
``` swift
    
    let settings = ProcStringsSettings()
    settings.width = 420 
    settings.height = 240
    settings.lines = 100
    settings.points = 8
    // horizontal gradients
    settings.gradients.append(GradientStep(offset: 0, color: "#03a9f4")) 
    settings.gradients.append(GradientStep(offset: 70, color: "#e91e63"))
    
    let image = ProceduralStringGenerator.generateSVGImage(settings: settings)

```

### Create a SVG String
``` swift
    
    let settings = ProcStringsSettings()
    settings.width = 420 
    settings.height = 240
    settings.lines = 100
    settings.points = 8
    // horizontal gradients
    settings.gradients.append(GradientStep(offset: 0, color: "#03a9f4")) 
    settings.gradients.append(GradientStep(offset: 70, color: "#e91e63"))
    
    let svgString = ProceduralStringGenerator.generateSVGString(settings: settings)

```


### Use UIImageView extension
``` swift
    
    let settings = ProcStringsSettings()
    settings.width = 420 
    settings.height = 240
    settings.lines = 100
    settings.points = 8
    // horizontal gradients
    settings.gradients.append(GradientStep(offset: 0, color: "#03a9f4")) 
    settings.gradients.append(GradientStep(offset: 70, color: "#e91e63"))
    
    myUIImageView.generate(settings: settings)

```

## Related Projects
- [Cocoa Rocks](https://cocoa.rocks/): this and other awesome Cocoa Controls
- [awesome-cocoa](https://github.com/v-braun/awesome-cocoa): an awesome list of cocoa controls
- [procedural-strings-js](https://github.com/v-braun/procedural-strings-js): js version of this project


## Authors

![image](https://avatars3.githubusercontent.com/u/4738210?v=3&amp;s=50)  
[v-braun](https://github.com/v-braun/)



## Contributing

Make sure to read these guides before getting started:
- [Contribution Guidelines](https://github.com/v-braun/VBRProceduralStrings/blob/master/CONTRIBUTING.md)
- [Code of Conduct](https://github.com/v-braun/VBRProceduralStrings/blob/master/CODE_OF_CONDUCT.md)

## License
**VBRProceduralStrings** is available under the MIT License. See [LICENSE](https://github.com/v-braun/VBRProceduralStrings/blob/master/LICENSE) for details.
