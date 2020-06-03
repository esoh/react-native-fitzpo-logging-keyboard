#import "FTZTextInputWithLoggerManager.h"
#import "FTZTextInputWithLoggerView.h"
#import <React/RCTSinglelineTextInputView.h>

@implementation FTZTextInputWithLoggerManager

RCT_EXPORT_MODULE(FTZTextInputWithLogger)

RCT_EXPORT_VIEW_PROPERTY(value, NSString)
RCT_EXPORT_VIEW_PROPERTY(autocompleteLabel, NSString)
RCT_EXPORT_VIEW_PROPERTY(autocompleteValue, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(stepValue, NSNumber)
RCT_EXPORT_VIEW_PROPERTY(unit, NSString)

RCT_EXPORT_VIEW_PROPERTY(leftButtonEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(rightButtonEnabled, BOOL)

RCT_EXPORT_VIEW_PROPERTY(onLeftButtonPress, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onRightButtonPress, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onChangeText, RCTBubblingEventBlock)

- (UIView *)view
{
  return [[FTZTextInputWithLoggerView alloc] initWithBridge:self.bridge];
}

@end
