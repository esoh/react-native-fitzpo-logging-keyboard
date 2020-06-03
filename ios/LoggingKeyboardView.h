//
//  LoggingKeyboardView.h
//  Pods
//
//  Created by Fitzpo Admin on 5/31/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoggingKeyboardViewDelegate <NSObject>
@optional
- (void) customCallbackButtonPressed;
@end

@interface LoggingKeyboardView : UIView

@property (nonatomic, weak) id <LoggingKeyboardViewDelegate> delegate;
@property UITextView *textView;

- (IBAction)characterPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)hideInputViewButtonPressed:(id)sender;
- (IBAction)customCallbackButtonPressed:(id)sender;
- (IBAction)plusMinusButtonPressed:(id)sender;
@end

NS_ASSUME_NONNULL_END
