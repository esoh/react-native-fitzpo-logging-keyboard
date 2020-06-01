#import "FTZTextInputWithLoggerManager.h"
#import "FTZTextInputWithLoggerView.h"
#import <React/RCTSinglelineTextInputView.h>

@implementation FTZTextInputWithLoggerManager

RCT_EXPORT_MODULE(FTZTextInputWithLogger)

RCT_EXPORT_VIEW_PROPERTY(value, NSString)

RCT_EXPORT_VIEW_PROPERTY(onCustomCallbackButtonPress, RCTBubblingEventBlock)

- (UIView *)view
{
  return [[FTZTextInputWithLoggerView alloc] initWithBridge:self.bridge];
}

@end
