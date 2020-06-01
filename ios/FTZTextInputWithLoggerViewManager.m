#import "FTZTextInputWithLoggerViewManager.h"
#import "FTZTextInputWithLoggerView.h"
#import <React/RCTSinglelineTextInputView.h>

@implementation FTZTextInputWithLoggerViewManager

RCT_EXPORT_MODULE(FTZTextInputWithLogger)

- (UIView *)view
{
  FTZTextInputWithLoggerView *textInputView = [[FTZTextInputWithLoggerView alloc] initWithBridge:self.bridge];
  //textInputView.delegate = self;
  return textInputView;
}

@end
