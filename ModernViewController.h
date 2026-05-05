//
//  ModernViewController.h
//  AvroKeyboard
//
//  Base view controller with modern glass morphism styling
//

#import <Cocoa/Cocoa.h>

@interface ModernViewController : NSViewController

@property (nonatomic, retain) NSVisualEffectView *backgroundEffectView;

- (void)setupModernAppearance;
- (void)applyGlassBackground;
- (void)addSeparatorBetweenView:(NSView *)topView andView:(NSView *)bottomView;

@end
