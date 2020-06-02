//
//  LoggingKeyboardView.m
//  Pods
//
//  Created by Fitzpo Admin on 5/31/20.
//
#import "LoggingKeyboardView.h"

@implementation LoggingKeyboardView
{
  UIView* keyboardView;
}

@synthesize textView;
@synthesize delegate;

CGFloat const keyboardHeight = 100;

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

- (IBAction)characterPressed:(id)sender {
  UIButton *button = (UIButton *)sender;
  NSString *character = [NSString stringWithString:button.titleLabel.text];

  NSLog(@"BUTTON PRESS %@", character);
  [(UITextView *)textView replaceRange:textView.selectedTextRange withText:character];
}

- (IBAction)customCallbackButtonPressed:(id)sender {
  NSLog(@"CUSTOM CALLBACK PRESS");
  if([self.delegate respondsToSelector:@selector(customCallbackButtonPressed)]){
    [self.delegate customCallbackButtonPressed];
  }
}

- (IBAction)hideInputViewButtonPressed:(id)sender {
  [(UITextView *)textView resignFirstResponder];
  //maybe implement callback too?
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
