//
//  ModernUIHelper.h
//  AvroKeyboard
//
//  Modern glass morphism UI utilities
//  Created for liquid glass design system
//

#import <Cocoa/Cocoa.h>

@interface ModernUIHelper : NSObject

// Window styling
+ (void)applyGlassWindowStyle:(NSWindow *)window;
+ (void)applyModernWindowStyle:(NSWindow *)window withTitle:(NSString *)title;

// Visual effects
+ (NSVisualEffectView *)createGlassBackgroundView:(NSRect)frame;
+ (NSVisualEffectView *)createVibrancyView:(NSRect)frame;
+ (NSView *)createSeparatorLine;

// Color utilities
+ (NSColor *)accentColor;
+ (NSColor *)secondaryBackgroundColor;
+ (NSColor *)tertiaryBackgroundColor;
+ (NSColor *)textColor;
+ (NSColor *)secondaryTextColor;

// Button styling
+ (void)styleButton:(NSButton *)button withStyle:(NSString *)style;
+ (void)styleTextField:(NSTextField *)textField;
+ (void)styleSegmentedControl:(NSSegmentedControl *)control;

// View animations
+ (void)transitionView:(NSView *)fromView toView:(NSView *)toView duration:(NSTimeInterval)duration;

@end
