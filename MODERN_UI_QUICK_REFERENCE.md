# Modern UI Implementation Quick Reference

## Quick Start

### 1. Update Window in Interface Builder (XIB/NIB)

For Preferences.xib:
1. Select the Window
2. In Identity Inspector:
   - Set Class: `NSWindow`
3. In Attributes Inspector:
   - Title: "Avro Keyboard Preferences"
   - Full Size Content View: Enabled
   - Unified Title and Toolbar: Disabled
   - Titlebar Transparent: Enabled
   - Movable by Background: Enabled

### 2. Set Custom Classes in IB

For Views:
- General View → `ModernViewController`
- AutoCorrect View → `ModernViewController`
- About View → `ModernViewController`

For Buttons:
- Use `ModernButton` custom class
- Set button style using user-defined runtime attributes:
  - `buttonStyle` (Number): 0 (Primary), 1 (Secondary), 2 (Tertiary)

For Candidates Popup:
- Use `ModernCandidatesView` custom class

### 3. Code Integration

**In PreferencesController.m awakeFromNib:**
```objc
- (void)awakeFromNib {
    [ModernUIHelper applyModernWindowStyle:self.window 
                                 withTitle:@"Avro Keyboard Preferences"];
}
```

**In MainMenuAppDelegate.m awakeFromNib:**
```objc
- (void)awakeFromNib {
    [self setupModernMenuAppearance];
    // ... rest of initialization
}
```

## Component API Reference

### ModernButton

**Initialization:**
```objc
ModernButton *btn = [[ModernButton alloc] 
    initWithFrame:frame 
    style:ModernButtonStylePrimary];
```

**Styles:**
- `ModernButtonStylePrimary` - Blue accent button
- `ModernButtonStyleSecondary` - Light glass button  
- `ModernButtonStyleTertiary` - Minimal button

### ModernCandidatesView

**Methods:**
```objc
- (void)updateWithCandidates:(NSArray *)candidates;
- (void)selectCandidate:(NSInteger)index;
- (NSString *)selectedCandidate;
```

**Properties:**
```objc
@property (nonatomic, copy) void(^selectionHandler)(NSString *);
```

### ModernUIHelper

**Static Methods:**
```objc
+ (void)applyGlassWindowStyle:(NSWindow *)window;
+ (NSVisualEffectView *)createGlassBackgroundView:(NSRect)frame;
+ (NSColor *)accentColor;
+ (NSColor *)textColor;
+ (void)styleButton:(NSButton *)button withStyle:(NSString *)style;
```

## Styling Guidelines

### Colors to Use

```objc
// Accent
[ModernUIHelper accentColor] // Modern blue

// Text
[ModernUIHelper textColor] // Primary text
[ModernUIHelper secondaryTextColor] // Secondary text

// Backgrounds
[ModernUIHelper secondaryBackgroundColor] // 10% white
[ModernUIHelper tertiaryBackgroundColor] // 5% white
```

### Border Radius

- Windows: 12px
- Views: 8px
- Buttons: 6px

### Shadows

Only on primary buttons:
- Radius: 8px
- Opacity: 0.3 (hover: 0.5)
- Offset: (0, 2)

### Animations

Standard duration: 0.3 seconds
Timing function: Ease In-Out (kCAMediaTimingFunctionEaseInEaseOut)

## Common Implementation Patterns

### Pattern 1: Glass Window
```objc
- (void)setupWindow {
    [ModernUIHelper applyGlassWindowStyle:self.window];
    [[self window] setMinSize:NSMakeSize(500, 400)];
    [[self window] setTitle:@"My Window"];
}
```

### Pattern 2: View with Separator
```objc
NSView *separator = [ModernUIHelper createSeparatorLine];
separator.frame = NSMakeRect(0, 100, view.width, 1);
[view addSubview:separator];
```

### Pattern 3: Smooth Transition
```objc
[ModernUIHelper transitionView:currentView 
                       toView:newView 
                     duration:0.3];
```

### Pattern 4: Custom Button
```objc
ModernButton *button = [[ModernButton alloc] 
    initWithFrame:NSMakeRect(10, 10, 100, 32) 
    style:ModernButtonStylePrimary];
[button setTitle:@"Click me"];
[button setTarget:self action:@selector(handleClick:)];
[view addSubview:button];
[button release];
```

## Testing Checklist

- [ ] Windows have glass background
- [ ] Buttons respond to hover
- [ ] Text is readable with good contrast
- [ ] Animations are smooth (30fps+)
- [ ] Colors match design system
- [ ] Components work in Light and Dark mode
- [ ] No visual artifacts or flicker
- [ ] Shadows render correctly

## Troubleshooting

**Glass effect not showing:**
- Ensure `wantsLayer = YES` on contentView
- Check that NSVisualEffectView is inserted as subview
- Verify material type matches OS version

**Buttons not responding to hover:**
- Ensure `wantsLayer = YES` on button
- Check tracking areas are set up
- Verify mouse events are being received

**Text not visible:**
- Use `[ModernUIHelper textColor]` for proper contrast
- Check font size (minimum 11pt)
- Ensure background is set correctly

## Files to Modify

Essential files for full UI redesign:
1. PreferencesController.m - ✓ Updated
2. MainMenuAppDelegate.m - ✓ Updated
3. AvroKeyboardController.m - Needs update
4. English.lproj/preferences.nib - Interface Builder
5. English.lproj/MainMenu.nib - Interface Builder

## Resources

- [Modern UI Components Reference](/MODERN_UI_DESIGN.md)
- Apple Design Resources: https://developer.apple.com/design/
- macOS Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/macos/

