#import <React/RCTSinglelineTextInputView.h>
#import "LoggingKeyboardView.h"

@interface FTZTextInputWithLoggerView : RCTSinglelineTextInputView
<LoggingKeyboardViewDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onLeftButtonPress;
@property (nonatomic, copy) RCTBubblingEventBlock onRightButtonPress;
@property (nonatomic, copy) RCTBubblingEventBlock onChangeText;

@property (nonatomic) NSString *value;
@property (nonatomic) NSString *autocompleteTitle;
@property (nonatomic) NSNumber *autocompleteValue;
@property (nonatomic) NSNumber *stepValue;

@end
