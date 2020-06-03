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
- (void) leftButtonPressed;
- (void) rightButtonPressed;
@end

@interface LoggingKeyboardView : UIView

@property (nonatomic, weak) id <LoggingKeyboardViewDelegate> delegate;
@property UITextField *textView;

@property (weak, nonatomic) IBOutlet UILabel *autocompleteLabel;
- (IBAction)characterPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)hideInputViewButtonPressed:(id)sender;
- (IBAction)leftButtonPressed:(id)sender;
- (IBAction)rightButtonPressed:(id)sender;
- (IBAction)plusMinusButtonPressed:(id)sender;
@end

NS_ASSUME_NONNULL_END
