//
//  LoggingKeyboardView.m
//  Pods
//
//  Created by Fitzpo Admin on 5/31/20.
//

#import "LoggingKeyboardView.h"

@implementation LoggingKeyboardView

- (id)init {
  //self = [super initWithFrame:CGRectMake(0, 0, 100, 200)];
  NSString *resourcePath = [NSBundle.mainBundle pathForResource:@"Resources" ofType:@"bundle"];
  NSBundle *resourcesBundle = [NSBundle bundleWithPath:resourcePath];
  self = [[resourcesBundle loadNibNamed:@"LoggingKeyboardView" owner:self options:nil] lastObject];
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
