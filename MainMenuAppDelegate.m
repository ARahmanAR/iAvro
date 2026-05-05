//
//  AvroKeyboard
//
//  Created by Rifat Nabi on 6/24/12.
//  Copyright (c) 2012 OmicronLab. All rights reserved.
//

#import "MainMenuAppDelegate.h"
#import "AutoCorrect.h"
#import "CacheManager.h"
#import "Database.h"
#import "RegexParser.h"
#import "ModernUIHelper.h"

@implementation MainMenuAppDelegate

@synthesize imPref;

//this method is added so that our controllers can access the shared NSMenu.
-(NSMenu*)menu {
	return _menu;
}

//add an awakeFromNib item so that we can set the action method.  Note that any menuItems without an action will be disabled when
//displayed in the Text Input Menu.
-(void)awakeFromNib {
    // Setup menu appearance
    [self setupModernMenuAppearance];
    
	NSMenuItem* preferences = [_menu itemWithTag:1];
	
	if (preferences) {
		[preferences setAction:@selector(showPreferences:)];
        [preferences setImage:[self createMenuItemIcon]];
	}
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"IncludeDictionary"]) {
        NSLog(@"Loading Dictionary...");
        [Database sharedInstance];
        [RegexParser sharedInstance];
        [CacheManager sharedInstance];
    }
    [AutoCorrect sharedInstance];
    
    // Apply modern application appearance
    [self applyModernAppearance];
}

- (void)setupModernMenuAppearance {
    // Enhance menu items with modern styling
    for (NSMenuItem *item in [_menu itemArray]) {
        if (item.image == nil && item.title.length > 0) {
            // Add visual styling to menu items
            item.font = [NSFont systemFontOfSize:13 weight:NSFontWeightMedium];
        }
    }
}

- (void)applyModernAppearance {
    // Apply modern appearance to the application
    if (@available(macOS 10.14, *)) {
        // Set appearance to dark mode for modern look
        NSApplication *app = [NSApplication sharedApplication];
        app.appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
    }
}

- (NSImage *)createMenuItemIcon {
    // Create a simple modern icon for preferences
    NSImage *icon = [[NSImage alloc] initWithSize:NSMakeSize(16, 16)];
    [icon lockFocus];
    
    [[NSColor colorWithSRGBRed:0.0 green:0.48 blue:1.0 alpha:1.0] set];
    NSRect rect = NSMakeRect(2, 2, 12, 12);
    NSBezierPath *circle = [NSBezierPath bezierPathWithOvalInRect:rect];
    circle.lineWidth = 1.5;
    [circle stroke];
    
    [icon unlockFocus];
    
    return [icon autorelease];
}

// Currently doesn't work
- (void)applicationWillTerminate:(NSNotification *)notification {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"IncludeDictionary"]) {
        [[CacheManager sharedInstance] persist];
    }
}

@end
