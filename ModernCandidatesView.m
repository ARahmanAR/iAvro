//
//  ModernCandidatesView.m
//  AvroKeyboard
//
//  Modern glass-styled candidates popup view implementation
//

#import "ModernCandidatesView.h"
#import "ModernUIHelper.h"

@interface ModernCandidatesView ()

@property (nonatomic, retain) NSVisualEffectView *backgroundView;
@property (nonatomic, retain) NSTableView *tableView;
@property (nonatomic, retain) NSArrayController *arrayController;

@end

@implementation ModernCandidatesView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupModernView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupModernView];
    }
    return self;
}

- (void)setupModernView {
    self.wantsLayer = YES;
    self.layer.cornerRadius = 8.0;
    self.layer.masksToBounds = YES;
    
    // Add glass background
    self.backgroundView = [ModernUIHelper createGlassBackgroundView:self.bounds];
    [self addSubview:self.backgroundView];
    self.backgroundView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    // Setup table view
    NSRect tableFrame = NSMakeRect(4, 4, self.bounds.size.width - 8, self.bounds.size.height - 8);
    self.tableView = [[NSTableView alloc] initWithFrame:tableFrame];
    self.tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;
    self.tableView.backgroundColor = [NSColor clearColor];
    self.tableView.gridColor = [NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    self.tableView.headerView = nil;
    self.tableView.rowHeight = 24.0;
    
    // Add column
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"candidate"];
    column.width = tableFrame.size.width - 8;
    [column setMinWidth:40];
    [self.tableView addTableColumn:column];
    [column release];
    
    [self addSubview:self.tableView];
    self.tableView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    
    // Setup array controller
    self.arrayController = [[NSArrayController alloc] init];
    self.arrayController.content = [NSMutableArray array];
    
    self.tableView.dataSource = self.arrayController;
    self.tableView.delegate = self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Add subtle border
    NSBezierPath *borderPath = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:8.0 yRadius:8.0];
    [[NSColor colorWithSRGBRed:1.0 green:1.0 blue:1.0 alpha:0.2] set];
    borderPath.lineWidth = 1.0;
    [borderPath stroke];
}

- (void)updateWithCandidates:(NSArray *)candidates {
    self.candidates = candidates;
    self.arrayController.content = [NSMutableArray arrayWithArray:candidates];
    [self.tableView reloadData];
    
    // Auto-select first item
    if ([candidates count] > 0) {
        self.selectedIndex = 0;
        [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    }
}

- (void)selectCandidate:(NSInteger)index {
    if (index >= 0 && index < [self.candidates count]) {
        self.selectedIndex = index;
        [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
        [self.tableView scrollRowToVisible:index];
    }
}

- (NSString *)selectedCandidate {
    if (self.selectedIndex >= 0 && self.selectedIndex < [self.candidates count]) {
        return [self.candidates objectAtIndex:self.selectedIndex];
    }
    return nil;
}

- (void)dealloc {
    self.selectionHandler = nil;
    [_backgroundView release];
    [_tableView release];
    [_arrayController release];
    [_candidates release];
    [super dealloc];
}

#pragma mark - NSTableViewDelegate

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTextField *cell = [tableView makeViewWithIdentifier:@"CandidateCell" owner:self];
    
    if (!cell) {
        cell = [[NSTextField alloc] init];
        cell.identifier = @"CandidateCell";
        cell.editable = NO;
        cell.selectable = NO;
        cell.bordered = NO;
        cell.backgroundColor = [NSColor clearColor];
        cell.textColor = [ModernUIHelper textColor];
        cell.font = [NSFont systemFontOfSize:12 weight:NSFontWeightMedium];
    }
    
    if (row >= 0 && row < [self.candidates count]) {
        cell.stringValue = [self.candidates objectAtIndex:row];
    }
    
    return cell;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    NSInteger selectedRow = self.tableView.selectedRow;
    if (selectedRow >= 0) {
        self.selectedIndex = selectedRow;
        if (self.selectionHandler) {
            self.selectionHandler([self selectedCandidate]);
        }
    }
}

@end
