//
//  ModernCandidatesView.h
//  AvroKeyboard
//
//  Modern glass-styled candidates popup view
//

#import <Cocoa/Cocoa.h>

@interface ModernCandidatesView : NSView

@property (nonatomic, retain) NSArray *candidates;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void(^selectionHandler)(NSString *);

- (void)updateWithCandidates:(NSArray *)candidates;
- (void)selectCandidate:(NSInteger)index;
- (NSString *)selectedCandidate;

@end
