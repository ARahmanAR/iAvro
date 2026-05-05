//
//  ModernUIHelper.m
//  AvroKeyboard
//
//  Modern glass morphism UI utilities implementation
//

#import "ModernUIHelper.h"

@implementation ModernUIHelper

#pragma mark - Window Styling

+ (void)applyGlassWindowStyle:(NSWindow *)window {
    if (!window) return;
    
    // Window appearance
    window.titlebarAppearsTransparent = YES;
    window.opaque = NO;
    window.backgroundColor = [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    window.styleMask |= NSWindowStyleMaskFullSizeContentView;
    window.movableByWindowBackground = YES;
    
    // Window appearance style (macOS 10.14+)
    if (@available(macOS 10.14, *)) {
        window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
    }
    
    // Add glass background
    NSView *contentView = window.contentView;
    contentView.wantsLayer = YES;
    contentView.layer.cornerRadius = 12.0;
    contentView.layer.masksToBounds = YES;
    
    // Insert visual effect view at the back
    NSVisualEffectView *backgroundView = [self createGlassBackgroundView:contentView.bounds];
    [contentView insertSubview:backgroundView atIndex:0];
    backgroundView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

+ (void)applyModernWindowStyle:(NSWindow *)window withTitle:(NSString *)title {
    [self applyGlassWindowStyle:window];
    
    // Update window title with modern styling
    if (title) {
        window.title = title;
    }
    
    // Add additional polish
    window.level = NSNormalWindowLevel;
    window.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
}

#pragma mark - Visual Effects

+ (NSVisualEffectView *)createGlassBackgroundView:(NSRect)frame {
    NSVisualEffectView *effectView = [[NSVisualEffectView alloc] initWithFrame:frame];
    
    // Modern glass effect
    if (@available(macOS 10.14, *)) {
        effectView.material = NSVisualEffectMaterialUltraDark;
        effectView.blendingMode = NSVisualEffectBlendingModeWithinWindow;
    } else {
        effectView.material = NSVisualEffectMaterialDark;
        effectView.blendingMode = NSVisualEffectBlendingModeWithinWindow;
    }
    
    effectView.state = NSVisualEffectStateActive;
    
    return [effectView autorelease];
}

+ (NSVisualEffectView *)createVibrancyView:(NSRect)frame {
    NSVisualEffectView *effectView = [[NSVisualEffectView alloc] initWithFrame:frame];
    
    if (@available(macOS 10.14, *)) {
        effectView.material = NSVisualEffectMaterialLight;
    } else {
        effectView.material = NSVisualEffectMaterialLight;
    }
    
    effectView.blendingMode = NSVisualEffectBlendingModeBehindWindow;
    effectView.state = NSVisualEffectStateActive;
    
    return [effectView autorelease];
}

+ (NSView *)createSeparatorLine {
    NSBox *separator = [[NSBox alloc] initWithFrame:NSMakeRect(0, 0, 0, 1)];
    separator.boxType = NSBoxCustom;
    separator.fillColor = [NSColor colorWithSRGBRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    separator.borderColor = [NSColor clearColor];
    separator.borderWidth = 0;
    separator.cornerRadius = 0;
    
    return [separator autorelease];
}

#pragma mark - Colors

+ (NSColor *)accentColor {
    // Modern blue accent color
    return [NSColor colorWithSRGBRed:0.0 green:0.48 blue:1.0 alpha:1.0];
}

+ (NSColor *)secondaryBackgroundColor {
    return [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.1];
}

+ (NSColor *)tertiaryBackgroundColor {
    return [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.05];
}

+ (NSColor *)textColor {
    return [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.95];
}

+ (NSColor *)secondaryTextColor {
    return [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.6];
}

#pragma mark - Button Styling

+ (void)styleButton:(NSButton *)button withStyle:(NSString *)style {
    if (!button) return;
    
    button.wantsLayer = YES;
    button.layer.cornerRadius = 8.0;
    
    if ([style isEqualToString:@"primary"]) {
        button.bezelColor = [self accentColor];
        button.font = [NSFont systemFontOfSize:12 weight:NSFontWeightSemibold];
        button.layer.shadowColor = [NSColor colorWithSRGBRed:0.0 green:0.48 blue:1.0 alpha:0.5].CGColor;
        button.layer.shadowOpacity = 0.3;
        button.layer.shadowRadius = 8.0;
        button.layer.shadowOffset = CGSizeMake(0, 2);
    } else if ([style isEqualToString:@"secondary"]) {
        button.bezelColor = [self secondaryBackgroundColor];
        button.font = [NSFont systemFontOfSize:12 weight:NSFontWeightMedium];
    } else {
        button.bezelColor = [self tertiaryBackgroundColor];
        button.font = [NSFont systemFontOfSize:11 weight:NSFontWeightRegular];
    }
}

+ (void)styleTextField:(NSTextField *)textField {
    if (!textField) return;
    
    textField.wantsLayer = YES;
    textField.layer.cornerRadius = 6.0;
    textField.layer.backgroundColor = [self tertiaryBackgroundColor].CGColor;
    textField.layer.borderWidth = 1.0;
    textField.layer.borderColor = [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    textField.textColor = [self textColor];
}

+ (void)styleSegmentedControl:(NSSegmentedControl *)control {
    if (!control) return;
    
    control.wantsLayer = YES;
    control.layer.cornerRadius = 6.0;
    control.layer.backgroundColor = [self secondaryBackgroundColor].CGColor;
}

#pragma mark - Animations

+ (void)transitionView:(NSView *)fromView toView:(NSView *)toView duration:(NSTimeInterval)duration {
    if (!fromView || !toView) return;
    
    NSView *container = fromView.superview;
    if (!container) return;
    
    // Setup initial state
    toView.frame = fromView.frame;
    toView.alphaValue = 0.0;
    [container addSubview:toView];
    
    // Animate transition
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:duration];
    [[NSAnimationContext currentContext] setTimingFunction:
     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[fromView animator] setAlphaValue:0.0];
    [[toView animator] setAlphaValue:1.0];
    
    [NSAnimationContext endGrouping];
    
    // Cleanup
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        [fromView removeFromSuperview];
    });
}

@end
