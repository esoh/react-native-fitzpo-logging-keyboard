//
//  LoggingKeyboardView.h
//  Pods
//
//  Created by Fitzpo Admin on 5/31/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoggingKeyboardView : UIView

@property id<UITextInput> textView;

- (IBAction)characterPressed:(id)sender;
- (IBAction)hideInputView:(id)sender;
@end

NS_ASSUME_NONNULL_END
