//
//  ModernButton.m
//  AvroKeyboard
//
//  Modern glass-styled button implementation
//

#import "ModernButton.h"
#import "ModernUIHelper.h"

@implementation ModernButton

- (instancetype)initWithFrame:(NSRect)frameRect style:(ModernButtonStyle)style {
    self = [super initWithFrame:frameRect];
    if (self) {
        _buttonStyle = style;
        [self setupButton];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    return [self initWithFrame:frameRect style:ModernButtonStyleSecondary];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton {
    self.wantsLayer = YES;
    self.layer.cornerRadius = 6.0;
    self.layer.masksToBounds = YES;
    
    // Font styling
    self.font = [NSFont systemFontOfSize:12 weight:NSFontWeightMedium];
    
    // Apply style
    [self applyStyle];
    
    // Enable tracking
    [self updateTrackingAreas];
}

- (void)applyStyle {
    switch (_buttonStyle) {
        case ModernButtonStylePrimary:
            self.layer.backgroundColor = [ModernUIHelper accentColor].CGColor;
            self.layer.shadowColor = [NSColor colorWithSRGBRed:0.0 green:0.48 blue:1.0 alpha:0.5].CGColor;
            self.layer.shadowOpacity = 0.3;
            self.layer.shadowRadius = 8.0;
            self.layer.shadowOffset = CGSizeMake(0, 2);
            [self setTitleColor:[NSColor whiteColor]];
            break;
            
        case ModernButtonStyleSecondary:
            self.layer.backgroundColor = [ModernUIHelper secondaryBackgroundColor].CGColor;
            self.layer.borderColor = [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.2].CGColor;
            self.layer.borderWidth = 1.0;
            [self setTitleColor:[ModernUIHelper textColor]];
            break;
            
        case ModernButtonStyleTertiary:
            self.layer.backgroundColor = [NSColor clearColor].CGColor;
            [self setTitleColor:[ModernUIHelper secondaryTextColor]];
            break;
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Add hover effect if needed
    if (_isHighlighted) {
        [[NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.1] setFill];
        NSRectFill(dirtyRect);
    }
}

- (void)mouseEntered:(NSEvent *)event {
    _isHighlighted = YES;
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.2];
    
    if (_buttonStyle == ModernButtonStylePrimary) {
        self.layer.shadowOpacity = 0.5;
    } else {
        self.layer.backgroundColor = [ModernUIHelper tertiaryBackgroundColor].CGColor;
    }
    
    [NSAnimationContext endGrouping];
    [self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)event {
    _isHighlighted = NO;
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.2];
    
    [self applyStyle];
    
    [NSAnimationContext endGrouping];
    [self setNeedsDisplay:YES];
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc]
                                   initWithRect:self.bounds
                                   options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow)
                                   owner:self
                                   userInfo:nil];
    [self addTrackingArea:trackingArea];
    [trackingArea release];
}

@end
