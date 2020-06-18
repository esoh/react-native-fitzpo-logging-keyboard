#import "FTZTextInputWithLoggerView.h"
#import "LoggingKeyboardView.h"

@implementation FTZTextInputWithLoggerView
{
  UITextField* textField;
  LoggingKeyboardView* customizedInputView;
}
@synthesize value;

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
  if(self = [super initWithBridge:bridge]) {
    // initialize custom keyboard input view
    customizedInputView= [[LoggingKeyboardView alloc] init];

    // grab textview from textinput view and attach custom keyboard input view to it
    textField = (UITextField*)self.backedTextInputView;
    textField.delegate = self;
    [textField setInputView:customizedInputView];
    [(UITextField*)textField addTarget:self
      action:@selector(textFieldDidChange)
      forControlEvents:UIControlEventEditingChanged
    ];

    // add reference to textview from inputview so input knows where to send its actions
    [customizedInputView setTextField:textField];
    customizedInputView.delegate = self;
  }
  return self;
}

- (void)setAutocompleteLabel:(NSString *)incomingValue
{
  NSLog(@"C00: set auto complete");
  customizedInputView.autocompleteLabel.text = incomingValue;
}

- (void)setAutocompleteValue:(NSNumber *)incomingValue
{
  NSLog(@"G00: set autcomplete value");
  [customizedInputView.autocompleteButton setTitle:[incomingValue stringValue] forState:UIControlStateNormal];
  [customizedInputView.autocompleteButton setEnabled:YES];
  customizedInputView.autocompleteValue = incomingValue;
}

- (void)setUnit:(NSString *)unit
{
  customizedInputView.unitLabel.text = unit;
}

- (void)setStepValue:(NSNumber *)value
{
  [customizedInputView.incrementButton setTitle:[NSString stringWithFormat:@"+%@",[value stringValue]] forState:UIControlStateNormal];
  [customizedInputView.decrementButton setTitle:[NSString stringWithFormat:@"-%@",[value stringValue]] forState:UIControlStateNormal];
  customizedInputView.stepValue = value;
}

- (void)setValue:(NSString *)incomingValue
{
  NSLog(@"A00: Received value %@", incomingValue);
  NSLog(@"A00: textField value: %@", textField.text);
  if([incomingValue isEqualToString:textField.text]){
    return;
  }

  NSLog(@"A00: overriding");
  textField.text = incomingValue;
  value=incomingValue;
  [textField sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldDidChange
{
  NSLog(@"A00: text field changed!!! %@", textField.text);

  if([textField.text isEqualToString:self.value] || !self.onChangeText){
    return;
  }
  NSLog(@"A00: Output value %@", textField.text);
  self.onChangeText(@{
    @"text": textField.text
  });
}

-(void) setLeftButtonEnabled:(BOOL)enabled
{
  if(enabled){
    [customizedInputView.leftButton setEnabled:YES];
  } else {
    [customizedInputView.leftButton setEnabled:NO];
  }
}

-(void) setRightButtonEnabled:(BOOL)enabled
{
  if(enabled){
    [customizedInputView.rightButton setEnabled:YES];
  } else {
    [customizedInputView.rightButton setEnabled:NO];
  }
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
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
  dispatch_async(dispatch_get_main_queue(), ^{
    [textField selectAll:nil];
  });
  return YES;
}

- (BOOL) textFieldDidBeginEditing:(UITextField *)textField {
  if(self.onFocus){
    self.onFocus(@{});
  }
  return YES;
}

- (BOOL) textFieldDidEndEditing:(UITextField *)textField {
  if(self.onBlur){
    self.onBlur(@{});
  }
  return YES;
}

@end
