//
//  LoggingKeyboardView.m
//  Pods
//
//  Created by Fitzpo Admin on 5/31/20.
//

#import "LoggingKeyboardView.h"

@implementation LoggingKeyboardView

@synthesize textView;
@synthesize delegate;

- (id)init {
  if(self = [super initWithFrame:CGRectMake(0, 0, 500, 400)])
  {
    NSString *resourcePath = [NSBundle.mainBundle pathForResource:@"Resources" ofType:@"bundle"];
    NSBundle *resourcesBundle = [NSBundle bundleWithPath:resourcePath];
    UIView* keyboardView= [[resourcesBundle loadNibNamed:@"LoggingKeyboardView" owner:self options:nil] objectAtIndex:0];
    [self addSubview:keyboardView];
  }
  return self;
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
