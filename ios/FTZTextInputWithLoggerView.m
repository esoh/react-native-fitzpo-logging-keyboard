#import "FTZTextInputWithLoggerView.h"
#import "LoggingKeyboardView.h"

@implementation FTZTextInputWithLoggerView

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
  if(self = [super initWithBridge:bridge]) {
    // initialize custom keyboard input view
    LoggingKeyboardView* customizedInputView= [[LoggingKeyboardView alloc] init];

    // grab textview from textinput view and attach custom keyboard input view to it
    UITextView* textView = (UITextView*)self.backedTextInputView;
    [textView setInputView:customizedInputView];

    // add reference to textview from inputview so input knows where to send its actions
    [customizedInputView setTextView:textView];
  }
  return self;
}

@end
