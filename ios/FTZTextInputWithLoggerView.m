#import "FTZTextInputWithLoggerView.h"
#import "LoggingKeyboardView.h"

@implementation FTZTextInputWithLoggerView
{
  UITextField* textView;
}
@synthesize value;

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
  if(self = [super initWithBridge:bridge]) {
    // initialize custom keyboard input view
    LoggingKeyboardView* customizedInputView= [[LoggingKeyboardView alloc] init];

    // grab textview from textinput view and attach custom keyboard input view to it
    textView = (UITextField*)self.backedTextInputView;
    textView.delegate = self;
    [textView setInputView:customizedInputView];
    [(UITextField*)textView addTarget:self
      action:@selector(textFieldDidChange)
      forControlEvents:UIControlEventEditingChanged
    ];

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
  value=incomingValue;
}

- (void)textFieldDidChange
{
  NSLog(@"A00: text field changed!!! %@", textView.text);

  if([textView.text isEqualToString:self.value] || !self.onChangeText){
    return;
  }
  NSLog(@"A00: Output value %@", textView.text);
  self.onChangeText(@{
    @"text": textView.text
  });
}

#pragma mark LoggingKeyboardViewDelegate
- (void) leftButtonPressed
{
  if(!self.onLeftButtonPress){
    return;
  }
  self.onLeftButtonPress(@{});
}

- (void) rightButtonPressed
{
  if(!self.onRightButtonPress){
    return;
  }
  self.onRightButtonPress(@{});

}

#pragma mark UITextFieldDelegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textView {
  dispatch_async(dispatch_get_main_queue(), ^{
    [textView selectAll:nil];
  });
  return YES;
}

@end
