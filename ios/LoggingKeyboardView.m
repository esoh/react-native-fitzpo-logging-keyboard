//
//  LoggingKeyboardView.m
//  Pods
//
//  Created by Fitzpo Admin on 5/31/20.
//
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

#import "LoggingKeyboardView.h"

@implementation LoggingKeyboardView
{
  LoggingKeyboardView* keyboardView;
}

@synthesize textField;
@synthesize delegate;
@synthesize autocompleteValue;
@synthesize stepValue;

CGFloat const keyboardHeight = 300;

- (id)init {

  // adjust keyboardView within view
  CGFloat safeAreaBottomPadding = 0.0f;
  if (@available(iOS 11.0, *)) {
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    safeAreaBottomPadding = window.safeAreaInsets.top;
  }

  if(self = [super initWithFrame:CGRectMake(0, 0, self.frame.size.width, keyboardHeight + safeAreaBottomPadding)])
  {
    NSString *resourcePath = [NSBundle.mainBundle pathForResource:@"Resources" ofType:@"bundle"];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:resourcePath];
    keyboardView= [[resourcesBundle loadNibNamed:@"LoggingKeyboardView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:keyboardView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  NSLog(@"B00: LAYOUT");
  self.backgroundColor = keyboardView.backgroundColor;
  keyboardView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, keyboardHeight);
  keyboardView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
}

- (IBAction)autocompleteButtonPressed:(id)sender
{
  NSLog(@"E00: AUTOCOMPLETE %@", autocompleteValue);
  textField.text = [autocompleteValue stringValue];
}

- (IBAction)incrementButtonPressed:(id)sender
{
  NSNumber* number = [self getNumberFromString:textField.text];
  if(number == nil){
    if ( [allTrim( textField.text ) length] == 0 ) {
      number = 0;
    } else {
      return;
    }
  }
  number = @(number.doubleValue + stepValue.doubleValue);
  textField.text = [number stringValue];
}

- (IBAction)decrementButtonPressed:(id)sender
{
  NSNumber* number = [self getNumberFromString:textField.text];
  if(number == nil){
    if ( [allTrim( textField.text ) length] == 0 ) {
      number = 0;
    } else {
      return;
    }
  }
  number = @(number.doubleValue - stepValue.doubleValue);
  textField.text = [number stringValue];
}

- (IBAction)characterPressed:(id)sender {
  UIButton *button = (UIButton *)sender;
  NSString *character = [NSString stringWithString:button.titleLabel.text];

  NSLog(@"BUTTON PRESS %@", character);
  [textField replaceRange:textField.selectedTextRange withText:character];
}

- (IBAction)leftButtonPressed:(id)sender {
  NSLog(@"CUSTOM CALLBACK PRESS");
  if([self.delegate respondsToSelector:@selector(leftButtonPressed)]){
    [self.delegate leftButtonPressed];
  }
}

- (IBAction)rightButtonPressed:(id)sender {
  NSLog(@"CUSTOM CALLBACK PRESS");
  if([self.delegate respondsToSelector:@selector(rightButtonPressed)]){
    [self.delegate rightButtonPressed];
  }
}

- (IBAction)deletePressed:(id)sender {
  [textField deleteBackward];
}

- (IBAction)hideInputViewButtonPressed:(id)sender {
  [textField resignFirstResponder];
  //maybe implement callback too?
}

- (IBAction)plusMinusButtonPressed:(id)sender {
  //try to convert to float, plus/minus it, else do nothing (UITextField *)textField.text
  NSNumber* number = [self getNumberFromString:textField.text];
  if(number == nil){
    if ( [allTrim( textField.text ) length] == 0 ) {
      number = 0;
    } else {
      return;
    }
  }
  number = @(- number.doubleValue);
  textField.text = [number stringValue];
}

- (NSNumber *)getNumberFromString:(NSString *)candidateString {
  NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
  [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
  return [numberFormatter numberFromString:candidateString];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
