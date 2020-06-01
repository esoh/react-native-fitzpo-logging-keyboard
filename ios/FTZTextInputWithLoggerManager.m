#import "FTZTextInputWithLoggerManager.h"
#import "FTZTextInputWithLoggerView.h"
#import <React/RCTSinglelineTextInputView.h>

@implementation FTZTextInputWithLoggerManager

RCT_EXPORT_MODULE(FTZTextInputWithLogger)
RCT_EXPORT_VIEW_PROPERTY(onCustomCallbackButtonPress, RCTBubblingEventBlock)

- (UIView *)view
{
  FTZTextInputWithLoggerView *textInputView = [[FTZTextInputWithLoggerView alloc] initWithBridge:self.bridge];
  return textInputView;
}

@end
