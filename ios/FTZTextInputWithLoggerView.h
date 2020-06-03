#import <React/RCTSinglelineTextInputView.h>
#import "LoggingKeyboardView.h"

@interface FTZTextInputWithLoggerView : RCTSinglelineTextInputView
<LoggingKeyboardViewDelegate, UITextFieldDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onLeftButtonPress;
@property (nonatomic, copy) RCTBubblingEventBlock onRightButtonPress;
@property (nonatomic, copy) RCTBubblingEventBlock onChangeText;

@property (nonatomic) NSString *value;
@property (nonatomic) NSString *autocompleteLabel;
@property (nonatomic) NSNumber *autocompleteValue;
@property (nonatomic) NSNumber *stepValue;
@property (nonatomic) NSString *unit;

@end
