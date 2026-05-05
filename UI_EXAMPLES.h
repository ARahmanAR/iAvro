//
//  UIExamples.h
//  AvroKeyboard
//
//  Example code snippets for implementing modern UI components
//  Copy and adapt these examples for your own UI implementations
//

/**
 EXAMPLE 1: Creating a Modern Preferences Window
 
 In PreferencesController.h add:
    IBOutlet NSButton *_okButton;
    IBOutlet NSButton *_cancelButton;
    IBOutlet NSSegmentedControl *_tabControl;
 
 In PreferencesController.m awakeFromNib:
 */

/*
- (void)awakeFromNib {
    NSWindow *window = self.window;
    
    // Apply glass window style
    [ModernUIHelper applyModernWindowStyle:window 
                                 withTitle:@"Preferences"];
    [window setMinSize:NSMakeSize(600, 500)];
    [window setMaxSize:NSMakeSize(900, 800)];
    
    // Style tab control
    [ModernUIHelper styleSegmentedControl:_tabControl];
    
    // Style buttons
    [ModernUIHelper styleButton:_okButton withStyle:@"primary"];
    [ModernUIHelper styleButton:_cancelButton withStyle:@"secondary"];
    
    // Setup views
    [[self window] setContentSize:[_generalView frame].size];
    [[[self window] contentView] addSubview:_generalView];
    [[[self window] contentView] setWantsLayer:YES];
}
*/

/**
 EXAMPLE 2: Creating a Modern Dialog Box
 
 Usage:
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Confirm Action"];
    [alert setInformativeText:@"Are you sure?"];
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert runModal];
 
 To make it modern, style the buttons after creation.
 */

/**
 EXAMPLE 3: Creating Custom Modern Controls
 
 Create a container view with modern styling:
 */

/*
NSView *container = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 400, 300)];
container.wantsLayer = YES;
container.layer.cornerRadius = 8.0;

// Add glass background
NSVisualEffectView *glass = [ModernUIHelper createGlassBackgroundView:container.bounds];
[container insertSubview:glass atIndex:0];
glass.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

// Add separator
NSView *separator = [ModernUIHelper createSeparatorLine];
separator.frame = NSMakeRect(0, 150, 400, 1);
[container addSubview:separator];

// Add buttons
ModernButton *primaryBtn = [[ModernButton alloc] 
    initWithFrame:NSMakeRect(20, 20, 100, 32) 
    style:ModernButtonStylePrimary];
[primaryBtn setTitle:@"Primary"];
[container addSubview:primaryBtn];

ModernButton *secondaryBtn = [[ModernButton alloc] 
    initWithFrame:NSMakeRect(130, 20, 100, 32) 
    style:ModernButtonStyleSecondary];
[secondaryBtn setTitle:@"Secondary"];
[container addSubview:secondaryBtn];

[primaryBtn release];
[secondaryBtn release];
*/

/**
 EXAMPLE 4: Creating a Modern Input Field
 
 */

/*
NSTextField *inputField = [[NSTextField alloc] 
    initWithFrame:NSMakeRect(20, 200, 360, 32)];
[ModernUIHelper styleTextField:inputField];
inputField.font = [NSFont systemFontOfSize:12];
inputField.stringValue = @"Type here...";
[container addSubview:inputField];
[inputField release];
*/

/**
 EXAMPLE 5: Implementing View Transitions
 
 In a view controller that switches between views:
 */

/*
- (IBAction)switchView:(id)sender {
    NSView *oldView = [self.currentContent retain];
    NSView *newView = [self createNewView];
    
    [ModernUIHelper transitionView:oldView toView:newView duration:0.3];
    
    self.currentContent = newView;
    [oldView release];
}
*/

/**
 EXAMPLE 6: Creating a Modern List/Table View
 
 */

/*
NSTableView *tableView = [[NSTableView alloc] 
    initWithFrame:NSMakeRect(0, 0, 400, 300)];
tableView.backgroundColor = [NSColor clearColor];
tableView.gridColor = [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.1];
tableView.headerView = nil;
tableView.rowHeight = 28.0;

NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"main"];
column.width = 400;
[tableView addTableColumn:column];
[column release];

[container addSubview:tableView];
[tableView release];
*/

/**
 EXAMPLE 7: Menu Item Styling
 
 In MainMenuAppDelegate.m awakeFromNib:
 */

/*
- (void)awakeFromNib {
    for (NSMenuItem *item in [_menu itemArray]) {
        if (item.image == nil && item.title.length > 0) {
            item.font = [NSFont systemFontOfSize:13 weight:NSFontWeightMedium];
        }
    }
}
*/

/**
 EXAMPLE 8: Creating Status Text
 
 */

/*
NSTextField *statusLabel = [[NSTextField alloc] 
    initWithFrame:NSMakeRect(20, 250, 360, 20)];
statusLabel.editable = NO;
statusLabel.bordered = NO;
statusLabel.backgroundColor = [NSColor clearColor];
statusLabel.textColor = [ModernUIHelper secondaryTextColor];
statusLabel.font = [NSFont systemFontOfSize:11];
statusLabel.stringValue = @"Status: Ready";
[container addSubview:statusLabel];
[statusLabel release];
*/

/**
 EXAMPLE 9: Creating Hover Effects
 
 For custom controls, use tracking areas:
 */

/*
- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    
    NSTrackingArea *area = [[NSTrackingArea alloc]
        initWithRect:self.bounds
        options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveInKeyWindow)
        owner:self
        userInfo:nil];
    [self addTrackingArea:area];
    [area release];
}

- (void)mouseEntered:(NSEvent *)event {
    // Animate to hover state
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.15];
    [self.layer setBackgroundColor:[ModernUIHelper accentColor].CGColor];
    [NSAnimationContext endGrouping];
}

- (void)mouseExited:(NSEvent *)event {
    // Animate back to normal state
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.15];
    [self.layer setBackgroundColor:[ModernUIHelper secondaryBackgroundColor].CGColor];
    [NSAnimationContext endGrouping];
}
*/

/**
 EXAMPLE 10: Creating a Modern Notification Banner
 
 */

/*
NSView *banner = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 400, 50)];
banner.wantsLayer = YES;
banner.layer.cornerRadius = 6.0;
banner.layer.backgroundColor = [ModernUIHelper accentColor].CGColor;

NSTextField *messageLabel = [[NSTextField alloc] 
    initWithFrame:NSMakeRect(16, 15, 368, 20)];
messageLabel.editable = NO;
messageLabel.bordered = NO;
messageLabel.backgroundColor = [NSColor clearColor];
messageLabel.textColor = [NSColor whiteColor];
messageLabel.font = [NSFont systemFontOfSize:13];
messageLabel.stringValue = @"✓ Changes saved successfully";
[banner addSubview:messageLabel];
[messageLabel release];

[container addSubview:banner];
[banner release];
*/

#endif
