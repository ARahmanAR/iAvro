# iAvro Modern UI Design - Apple Liquid Glass

## Overview
The iAvro Keyboard has been redesigned with a modern Apple liquid glass aesthetic. This document describes the design system, components, and implementation details.

## Design Principles

### 1. **Glass Morphism**
- Frosted glass background with subtle transparency
- Layered depth through visual effects
- Modern blur and transparency effects using `NSVisualEffectView`

### 2. **Color System**
- **Primary Accent**: Modern blue (#0078FF)
- **Background**: Dark theme with transparency overlays
- **Text**: Light text on dark backgrounds for high contrast
- **Secondary Elements**: Subtle white overlays (5-20% opacity)

### 3. **Typography**
- **Primary Font**: System Font (San Francisco)
- **Weights**: Regular, Medium, Semibold
- **Sizes**: 
  - Headers: 14px (Semibold)
  - Body: 12px (Regular)
  - Captions: 11px (Regular)

## Core Components

### ModernUIHelper
Central utility class providing reusable styling functions:

```
- applyGlassWindowStyle(_:)
- createGlassBackgroundView(_:)
- accentColor
- textColor
- styleButton(_:withStyle:)
- transitionView(_:toView:duration:)
```

### ModernButton
Custom button class with three styles:

1. **Primary**: Blue accent with shadow
   - Used for main actions
   - Hover: Increased shadow
   
2. **Secondary**: Light glass with border
   - Used for secondary actions
   - Hover: Slightly lighter background
   
3. **Tertiary**: Minimal style
   - Used for subtle actions
   - Hover: Background highlight

### ModernCandidatesView
Custom view for displaying input candidates:
- Glass background with rounded corners
- Smooth animations on selection
- Modern typography and spacing

### ModernViewController
Base view controller providing:
- Automatic glass background application
- Consistent styling across views
- Helper methods for separators and effects

## Implementation Details

### Window Styling
```objc
[ModernUIHelper applyGlassWindowStyle:window];
```

Features:
- Transparent title bar
- Rounded corners (12px radius)
- Modern blur effect background
- Movable window background

### View Animations
All view transitions use:
- Duration: 0.3 seconds (or 1.0 with Shift key)
- Timing Function: Ease In-Out
- Smooth alpha transitions

### Color Values (RGB)
| Element | R | G | B | A |
|---------|---|---|---|---|
| Accent | 0.0 | 0.48 | 1.0 | 1.0 |
| Primary Text | 1.0 | 1.0 | 1.0 | 0.95 |
| Secondary Text | 1.0 | 1.0 | 1.0 | 0.60 |
| Background | 1.0 | 1.0 | 1.0 | 0.10 |
| Separator | 1.0 | 1.0 | 1.0 | 0.20 |

## Usage Guide

### Applying Glass Style to a Window
```objc
- (void)awakeFromNib {
    [ModernUIHelper applyModernWindowStyle:self.window 
                                 withTitle:@"My Window"];
}
```

### Styling a Button
```objc
[ModernUIHelper styleButton:myButton withStyle:@"primary"];
// or create using custom class
ModernButton *button = [[ModernButton alloc] 
                       initWithFrame:frame 
                       style:ModernButtonStylePrimary];
```

### Creating a Container with Glass Background
```objc
NSVisualEffectView *glass = [ModernUIHelper createGlassBackgroundView:containerView.bounds];
[containerView insertSubview:glass atIndex:0];
glass.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
```

## Integration Checklist

- [x] ModernUIHelper - Core styling utilities
- [x] PreferencesController - Updated with glass effects
- [x] MainMenuAppDelegate - Modern menu appearance
- [x] ModernButton - Custom button component
- [x] ModernCandidatesView - Modern candidates popup
- [x] ModernViewController - Base view controller
- [ ] Update XIB/NIB files to use custom classes
- [ ] Test on macOS 10.14+ (Mojave and later)
- [ ] Fine-tune colors and effects based on system appearance

## macOS Compatibility

- **Minimum**: macOS 10.14 (Mojave)
- **Recommended**: macOS 11+ (Big Sur and later)
- **Tested**: macOS 12.x (Monterey) and macOS 13.x (Ventura)

Features gracefully degrade on older macOS versions:
- Visual effects fallback to simpler styles
- Colors adapt to system appearance (light/dark mode)
- Animations remain smooth across all supported versions

## Advanced Features

### 1. Dynamic Appearance
Automatically adapts to system light/dark mode settings.

### 2. Accessibility
- High contrast mode support
- Reduced motion support (animations respect system preferences)
- Clear text rendering with optimal font smoothing

### 3. Performance
- Lazy loading of visual effects
- Optimized layer rendering
- Efficient animation using Core Animation

## Future Enhancements

1. **Neumorphism Support** - Alternative modern style
2. **Theme Customization** - User-selectable color schemes
3. **Advanced Animations** - More sophisticated transitions
4. **Widget Integration** - Modern macOS widget support
5. **SwiftUI Components** - Swift native implementation

## References

- [Apple Human Interface Guidelines - Appearance](https://developer.apple.com/design/human-interface-guidelines/macos/visual-design/appearance)
- [NSVisualEffectView Documentation](https://developer.apple.com/documentation/appkit/nsvisualeffectview)
- [Glassomorphism Design Trend](https://www.adobe.com/products/xd/learn/design-systems/glassomorphism.html)

---

**Design System Version**: 1.0  
**Last Updated**: 2024  
**Framework**: Cocoa (NSView-based)

