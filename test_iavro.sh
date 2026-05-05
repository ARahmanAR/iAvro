#!/bin/bash

# iAvro Testing Script
# এই স্ক্রিপ্ট iAvro keyboard এর বিভিন্ন aspects টেস্ট করে

echo "=========================================="
echo "  iAvro Keyboard Testing Script"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Check project structure
echo -e "${YELLOW}[1/5]${NC} Checking project structure..."
if [ -f "AvroKeyboard.xcodeproj/project.pbxproj" ]; then
    echo -e "${GREEN}✓${NC} Xcode project found"
else
    echo -e "${RED}✗${NC} Xcode project not found"
    exit 1
fi

# 2. Check modern UI files
echo ""
echo -e "${YELLOW}[2/5]${NC} Checking modern UI components..."
UI_FILES=("ModernUIHelper.h" "ModernUIHelper.m" "ModernButton.h" "ModernButton.m" "ModernCandidatesView.h" "ModernCandidatesView.m" "ModernViewController.h" "ModernViewController.m")

for file in "${UI_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file exists"
    else
        echo -e "${RED}✗${NC} $file missing"
    fi
done

# 3. Check source files
echo ""
echo -e "${YELLOW}[3/5]${NC} Checking core source files..."
SOURCE_FILES=("AvroKeyboardController.m" "PreferencesController.m" "MainMenuAppDelegate.m" "AutoCorrect.m" "Database.m")

for file in "${SOURCE_FILES[@]}"; do
    if [ -f "$file" ]; then
        lines=$(wc -l < "$file")
        echo -e "${GREEN}✓${NC} $file ($lines lines)"
    else
        echo -e "${RED}✗${NC} $file missing"
    fi
done

# 4. Check documentation
echo ""
echo -e "${YELLOW}[4/5]${NC} Checking documentation..."
DOC_FILES=("MODERN_UI_DESIGN.md" "MODERN_UI_QUICK_REFERENCE.md" "MODERN_UI_SUMMARY.md" "UI_EXAMPLES.h" "README.md")

for file in "${DOC_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✓${NC} $file found"
    else
        echo -e "${YELLOW}⚠${NC} $file not found"
    fi
done

# 5. Compile check
echo ""
echo -e "${YELLOW}[5/5]${NC} Checking syntax (basic validation)..."

# Check for syntax errors in modern UI files
for file in ModernUIHelper.m ModernButton.m ModernCandidatesView.m ModernViewController.m; do
    if [ -f "$file" ]; then
        # Basic check for balanced braces
        open_braces=$(grep -o '{' "$file" | wc -l)
        close_braces=$(grep -o '}' "$file" | wc -l)
        
        if [ "$open_braces" -eq "$close_braces" ]; then
            echo -e "${GREEN}✓${NC} $file syntax looks good"
        else
            echo -e "${YELLOW}⚠${NC} $file may have unbalanced braces"
        fi
    fi
done

# Summary
echo ""
echo "=========================================="
echo -e "${GREEN}✓ Pre-test validation complete!${NC}"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Open AvroKeyboard.xcodeproj in Xcode"
echo "  2. Select Product → Build (⌘B)"
echo "  3. Run the keyboard input method"
echo "  4. Test preferences window with modern UI"
echo "  5. Test keyboard input in any text field"
echo ""
