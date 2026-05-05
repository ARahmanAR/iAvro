# iAvro Keyboard - Comprehensive Testing Guide

## 🎯 Testing Objectives

This guide covers all aspects of testing the iAvro keyboard with the new modern UI design.

---

## 📋 Pre-Testing Setup

### Requirements
- macOS 10.14+ (Mojave or later)
- Xcode 10.2 or later
- iAvro project (already in /workspaces/iAvro)

### Files to Verify Before Testing
```
✓ AvroKeyboard.xcodeproj/
✓ ModernUIHelper.h/.m
✓ ModernButton.h/.m
✓ ModernCandidatesView.h/.m
✓ ModernViewController.h/.m
✓ PreferencesController.m (updated)
✓ MainMenuAppDelegate.m (updated)
```

---

## 🔧 Build Testing

### Step 1: Open Project
```bash
ls -la /workspaces/iAvro/AvroKeyboard.xcodeproj/
# Should show: project.pbxproj
```

### Step 2: Build in Xcode
1. Open `AvroKeyboard.xcodeproj` in Xcode
2. Select **Product** → **Build** (⌘B)
3. Expected: ✅ Build succeeds
4. Check: No compilation errors
5. Warnings: None critical

### Build Checklist
- [ ] Project opens without errors
- [ ] All files are included in target
- [ ] No missing header files
- [ ] No circular imports
- [ ] Build succeeds (0 errors, 0 warnings)

---

## 🎨 UI Component Testing

### Test 1: Modern UI Helper

**Test Code:**
```objc
#import "ModernUIHelper.h"

// Test color functions
NSColor *accentColor = [ModernUIHelper accentColor];
NSColor *textColor = [ModernUIHelper textColor];
NSColor *bgColor = [ModernUIHelper secondaryBackgroundColor];

// Expected: All colors are valid
assert(accentColor != nil);
assert(textColor != nil);
assert(bgColor != nil);
```

**Verify:**
- [ ] All color functions return valid NSColor objects
- [ ] Accent color is blue (#0078FF)
- [ ] Text colors have proper contrast
- [ ] Background colors are semi-transparent

### Test 2: Modern Button

**Visual Testing:**
```
1. Create ModernButton with style: Primary
   [ ] Button renders with blue background
   [ ] Button has shadow effect
   [ ] Button has rounded corners (6px)

2. Hover over primary button
   [ ] Background brightens slightly
   [ ] Shadow deepens
   [ ] Animation is smooth

3. Create ModernButton with style: Secondary
   [ ] Button has light glass background
   [ ] Button has subtle border
   [ ] Corners are rounded

4. Create ModernButton with style: Tertiary
   [ ] Minimal appearance
   [ ] No background color
   [ ] Text color only
```

**Automation Test:**
```objc
ModernButton *button = [[ModernButton alloc] 
    initWithFrame:NSMakeRect(0, 0, 100, 32) 
    style:ModernButtonStylePrimary];

assert(button.layer.cornerRadius == 6.0);
assert(button.wantsLayer == YES);
```

Checklist:
- [ ] All 3 button styles render correctly
- [ ] Hover effects are smooth
- [ ] Shadows only on primary buttons
- [ ] Border only on secondary buttons
- [ ] Click actions work properly

### Test 3: Modern Candidates View

**Setup:**
```objc
ModernCandidatesView *view = [[ModernCandidatesView alloc] 
    initWithFrame:NSMakeRect(0, 0, 400, 300)];
```

**Test Cases:**
```
1. Load candidates
   [ ] View displays with glass background
   [ ] Rounded corners visible (8px)
   [ ] Table rows visible with correct height

2. Add sample candidates
   NSArray *candidates = @[@"বিকল্প১", @"বিকল্প২", @"বিকল্প३"];
   [view updateWithCandidates:candidates];
   [ ] All candidates displayed
   [ ] Rows are properly styled
   [ ] Text is readable

3. Select candidate
   [view selectCandidate:0];
   [ ] First row highlights
   [ ] Selection handler called
   [ ] Animation smooth

4. Text styling
   [ ] Font is system font (San Francisco)
   [ ] Color is white with 95% opacity
   [ ] Size is 12pt medium
```

Checklist:
- [ ] View renders with glass background
- [ ] Table displays all candidates correctly
- [ ] Selection works and is highlighted
- [ ] Text is properly styled
- [ ] Scroll works if many candidates
- [ ] View closes cleanly

### Test 4: Modern View Controller

**Test:**
```objc
ModernViewController *vc = [[ModernViewController alloc] init];
[vc viewDidLoad];

// Verify glass background
assert(vc.backgroundEffectView != nil);
assert(vc.view.layer != nil);
assert(vc.view.layer.cornerRadius == 8.0);
```

Checklist:
- [ ] Glass background applied automatically
- [ ] Corner radius is 8.0
- [ ] Layer rendering enabled
- [ ] Subviews are properly layered

---

## 🪟 Preferences Window Testing

### Test 1: Window Appearance

**Setup:** Run the keyboard and open Preferences

**Visual Checks:**
```
✓ Title bar transparent
✓ Glass effect visible in background
✓ Window has rounded corners (12px)
✓ Background slightly blurred/frosted
✓ Text readable with good contrast
```

**Window Properties:**
```
✓ Title: "Avro Keyboard Preferences"
✓ Window is movable by background
✓ Close/Minimize/Maximize buttons work
✓ Window resizes correctly
✓ Minimum size enforced (500x400)
```

### Test 2: Tab Switching

**Test Steps:**
1. Open Preferences window
2. Click on "General" tab
3. **Verify:**
   - [ ] Tab switches smoothly
   - [ ] Animation duration ~0.3 seconds
   - [ ] Previous view fades out
   - [ ] New view fades in
   - [ ] Content is fully visible

4. Click on "AutoCorrect" tab
   - [ ] Smooth transition
   - [ ] AutoCorrect list appears
   - [ ] Search field works

5. Click on "About" tab
   - [ ] About content appears
   - [ ] Credits text readable
   - [ ] Scroll works

### Test 3: AutoCorrect Features

**Test Data:**
```
Create few AutoCorrect entries:
asdf → আসলে
test → পরীক্ষা
```

**Test Cases:**
```
1. Add new entry
   [ ] Add button works
   [ ] New row appears in table
   [ ] Can edit immediately

2. Edit existing
   [ ] Double-click to edit
   [ ] Changes saved
   [ ] Tab switches don't lose changes

3. Delete entry
   [ ] Select row
   [ ] Delete button removes it
   [ ] Cannot undo

4. Search filter
   [ ] Type in search field
   [ ] Results filter in real-time
   [ ] Both columns searched
   [ ] Clear search shows all

5. Data persistence
   [ ] Close and reopen Preferences
   [ ] All entries still there
   [ ] Order maintained
```

### Test 4: Button Interactions

**Primary Buttons:**
```
[ ] OK button
    - Hover: shadow increases
    - Click: preferences saved
    - Color: solid blue (#0078FF)

[ ] Cancel button
    - Hover: background lightens
    - Click: closes without saving
    - Color: light glass effect
```

**Checkboxes and Controls:**
```
[ ] Enable/Disable checkboxes
[ ] Text fields editable
[ ] Segmented controls work
[ ] All controls properly styled
```

---

## ⌨️ Keyboard Input Testing

### Test 1: Activation

**Setup:**
1. Go to System Preferences → Keyboard → Input Sources
2. Add "iAvro Keyboard"
3. Select it from input menu

**Verify:**
```
✓ iAvro appears in input menu
✓ Can switch to iAvro keyboard
✓ Status shows iAvro is active
✓ Can switch back to other input methods
```

### Test 2: Bangla Input

**Test Cases:**
```
1. Simple word
   - Type: "dhaka"
   - Expected: ঢাকা
   - [ ] Correct conversion

2. Autocorrect test
   - Have autocorrect entry: "asdf → আসলে"
   - Type: "asdf"
   - [ ] Immediately converts to আসলে

3. Multiple candidates
   - Type: "ami"
   - Expected: Shows candidates popup
   - [ ] Popup displays with glass effect
   - [ ] Can select different options
```

### Test 3: Candidates Popup

**Visual Test:**
```
When multiple candidates available:
✓ Popup appears below input area
✓ Glass background visible
✓ Rounded corners (8px)
✓ Candidates listed clearly
✓ Currently selected highlighted
```

**Interaction Test:**
```
✓ Arrow keys navigate candidates
✓ Numbers/function keys select
✓ Click selects candidate
✓ Popup closes after selection
✓ Selected candidate inserted
```

### Test 4: Text Field Integration

**Test in Different Apps:**

TextEdit:
```
✓ Input works
✓ Candidates appear
✓ Selection inserts text
✓ Cursor advances correctly
```

Web Browsers:
```
✓ Works in search fields
✓ Works in text input fields
✓ Candidates display properly
```

Mail.app:
```
✓ Works in compose window
✓ Works in subject line
✓ Works in body text
```

---

## 🎨 Visual Design Testing

### Color Verification

**Measure RGB values (in any app):**
```
✓ Accent: RGB(0, 122, 255) or #0078FF
✓ Primary text: RGB(255, 255, 255) ~ 95% alpha
✓ Secondary text: RGB(255, 255, 255) ~ 60% alpha
✓ Background: RGB(255, 255, 255) ~ 10% alpha
✓ Separator: RGB(255, 255, 255) ~ 20% alpha
```

### Typography Verification

**Check fonts in interface:**
```
✓ Titles: System font, 14pt, semibold
✓ Body: System font, 12pt, regular
✓ Captions: System font, 11pt, regular
✓ All text clear and readable
```

### Effect Verification

**Visual effects:**
```
✓ Blur effect on glass background
✓ Rounded corners on all windows
✓ Rounded corners on all buttons
✓ Smooth shadows on interactive elements
✓ No visual artifacts or glitches
```

---

## ⚡ Performance Testing

### Animation Performance

**Test smooth animations:**
```
✓ Tab switch animation (0.3s)
  - No stuttering
  - 60fps smooth
  - All elements fade correctly

✓ Button hover effect
  - Immediate response
  - Smooth color transition
  - No lag

✓ Candidates popup animation
  - Appears smoothly
  - Disappears smoothly
  - No jank or flicker
```

### Memory Usage

**Monitor while running:**
```
✓ Preferences window open
  - Check Activity Monitor
  - Memory usage normal
  - No memory leaks

✓ Heavy keyboard input
  - Type for 5 minutes straight
  - Monitor does not spike
  - Application remains responsive

✓ Open/close Preferences repeatedly
  - 10 times in a row
  - No memory growth
  - All resources freed properly
```

---

## 🌓 Appearance Mode Testing

### Light Mode
```
✓ Open in System Preferences (Light mode)
✓ Glass effect still visible
✓ Text still readable
✓ Accent color still distinct
```

### Dark Mode
```
✓ Switch to Dark mode in System Preferences
✓ UI automatically adapts
✓ Background glass effect correct
✓ Text contrast maintained
✓ All colors visible
```

### Auto Switching
```
✓ System set to "Auto" appearance
✓ Switches at sunset
✓ UI updates correctly
✓ No visual glitches during transition
```

---

## 🔍 Accessibility Testing

### Keyboard Navigation

```
✓ Tab through all controls
✓ All buttons focusable
✓ Text fields selectable
✓ All actions accessible via keyboard
✓ Focus indicators visible
```

### High Contrast Mode

```
✓ Enable in System Preferences
✓ Text remains readable
✓ Buttons have clear borders
✓ Focus indicators prominent
✓ All UI elements distinguishable
```

### VoiceOver (Screen Reader)

```
✓ Enable VoiceOver (⌘F5)
✓ All UI elements labeled
✓ Buttons have meaningful names
✓ Window title announced
✓ Content is readable
```

### Reduced Motion

```
✓ Enable Reduce Motion
✓ Animations still occur (just instant)
✓ No spinning/rotating effects
✓ UI remains fully functional
```

---

## ✅ Final Validation Checklist

### Build & Compilation
- [ ] No compilation errors
- [ ] No warnings
- [ ] All files included in target
- [ ] No missing dependencies

### Modern UI Components
- [ ] ModernUIHelper works
- [ ] ModernButton renders correctly
- [ ] ModernCandidatesView displays properly
- [ ] ModernViewController applies effects

### Preferences Window
- [ ] Launches without errors
- [ ] Glass effect visible
- [ ] All tabs functional
- [ ] Settings persist
- [ ] Buttons work

### Keyboard Input
- [ ] iAvro activatable
- [ ] Bangla input works
- [ ] Candidates popup works
- [ ] Autocorrect functions
- [ ] Text inserted correctly

### Visual Design
- [ ] Colors match specification
- [ ] Typography correct
- [ ] Effects smooth and polished
- [ ] No visual artifacts
- [ ] Works in light and dark mode

### Performance
- [ ] Animations smooth (60fps)
- [ ] No memory leaks
- [ ] Responsive to input
- [ ] Efficient resource usage

### Accessibility
- [ ] Keyboard navigation works
- [ ] Screen reader compatible
- [ ] High contrast supported
- [ ] Reduced motion respected

---

## 📝 Test Report Template

When testing, document findings:

```
Date: [Date]
Tester: [Your name]
macOS Version: [Version]
Hardware: [MacBook/iMac, etc.]

PASSED TESTS:
- Test name
- Test name

FAILED TESTS:
- Test name: [Description of failure]
- Test name: [Description of failure]

ISSUES FOUND:
1. [Issue description]
2. [Issue description]

SUGGESTIONS:
- [Suggestion for improvement]
- [Suggestion for improvement]

OVERALL RESULT: ✅ PASS / ⚠️ NEEDS FIX / ❌ FAIL
```

---

## 🔗 Resources for Testers

- [Xcode Testing Documentation](https://developer.apple.com/documentation/xcode/testing)
- [macOS Application Testing](https://developer.apple.com/macos/testing/)
- [Accessibility Testing Guide](https://developer.apple.com/documentation/accessibility/)
- [Performance Testing Tools](https://developer.apple.com/documentation/os/performance)

---

**Test Suite Version**: 1.0  
**Last Updated**: 2024  
**Framework**: Cocoa (Objective-C)

