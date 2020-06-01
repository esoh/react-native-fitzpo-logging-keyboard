#import "FTZTextInputWithLoggerView.h"
#import "LoggingKeyboardView.h"

@implementation FTZTextInputWithLoggerView
{
  UITextView* textView;
}

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
  if(self = [super initWithBridge:bridge]) {
    // initialize custom keyboard input view
    LoggingKeyboardView* customizedInputView= [[LoggingKeyboardView alloc] init];

    // grab textview from textinput view and attach custom keyboard input view to it
    textView = (UITextView*)self.backedTextInputView;
    [textView setInputView:customizedInputView];

    // add reference to textview from inputview so input knows where to send its actions
    [customizedInputView setTextView:textView];
    customizedInputView.delegate = self;
  }
  return self;
}

- (void)setValue:(NSString *)incomingValue
{
  NSLog(@"A00: Received value %@", incomingValue);
  NSLog(@"A00: textView value: %@", textView.text);
  if([incomingValue isEqualToString:textView.text]){
    return;
  }

  NSLog(@"A00: overriding");
  textView.text = incomingValue;
}

#pragma mark LoggingKeyboardViewDelegate
- (void) customCallbackButtonPressed {
  NSLog(@"CUSTOM CALLBACK WAS BUBBLED UP");
  if(!self.onCustomCallbackButtonPress){
    NSLog(@"NO onCustomCallbackButtonPress");
    return;
  }
  NSLog(@"YES onCustomCallbackButtonPress");

  self.onCustomCallbackButtonPress(@{});
}

@end
