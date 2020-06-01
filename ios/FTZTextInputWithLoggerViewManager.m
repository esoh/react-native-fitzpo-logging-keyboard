#import "FTZTextInputWithLoggerViewManager.h"
#import "LoggingKeyboardView.h"
#import <React/RCTSinglelineTextInputView.h>

@implementation FTZTextInputWithLoggerViewManager

RCT_EXPORT_MODULE(FTZTextInputWithLogger)

- (UIView *)view
{
  // initialize textinput view that we are going to customize
  RCTSinglelineTextInputView *textInputView = [[RCTSinglelineTextInputView alloc] initWithBridge:self.bridge];
  // initialize custom keyboard input view
  LoggingKeyboardView* customizedInputView= [[LoggingKeyboardView alloc] init];

  // grab textview from textinput view and attach custom keyboard input view to it
  UITextView* textView = (UITextView*)textInputView.backedTextInputView;
  [textView setInputView:customizedInputView];

  // add reference to textview from inputview so input knows where to send its actions
  [customizedInputView setTextView:textView];

  return textInputView;
}

@end
