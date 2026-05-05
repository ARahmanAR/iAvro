//
//  ModernButton.h
//  AvroKeyboard
//
//  Modern glass-styled button with smooth animations
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, ModernButtonStyle) {
    ModernButtonStylePrimary,    // Blue accent button
    ModernButtonStyleSecondary,  // Light glass button
    ModernButtonStyleTertiary    // Minimal button
};

@interface ModernButton : NSButton

@property (nonatomic, assign) ModernButtonStyle buttonStyle;
@property (nonatomic, assign) BOOL isHighlighted;

- (instancetype)initWithFrame:(NSRect)frameRect style:(ModernButtonStyle)style;

@end
