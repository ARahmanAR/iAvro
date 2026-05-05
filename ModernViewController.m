//
//  ModernViewController.m
//  AvroKeyboard
//
//  Base view controller implementation with modern styling
//

#import "ModernViewController.h"
#import "ModernUIHelper.h"

@implementation ModernViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupModernAppearance];
}

- (void)setupModernAppearance {
    NSView *view = self.view;
    if (!view) return;
    
    view.wantsLayer = YES;
    view.layer.cornerRadius = 8.0;
    
    // Apply glass background
    [self applyGlassBackground];
}

- (void)applyGlassBackground {
    NSView *view = self.view;
    if (!view) return;
    
    self.backgroundEffectView = [ModernUIHelper createGlassBackgroundView:view.bounds];
    [view insertSubview:self.backgroundEffectView atIndex:0];
    self.backgroundEffectView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
}

- (void)addSeparatorBetweenView:(NSView *)topView andView:(NSView *)bottomView {
    if (!topView || !bottomView) return;
    
    NSView *separator = [ModernUIHelper createSeparatorLine];
    separator.frame = NSMakeRect(0, CGRectGetMaxY(topView.frame), 
                                 self.view.bounds.size.width, 1);
    separator.autoresizingMask = NSViewWidthSizable;
    
    [self.view addSubview:separator];
}

- (void)dealloc {
    [_backgroundEffectView release];
    [super dealloc];
}

@end
