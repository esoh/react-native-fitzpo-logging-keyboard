#import <React/RCTSinglelineTextInputView.h>
#import "LoggingKeyboardView.h"

@interface FTZTextInputWithLoggerView : RCTSinglelineTextInputView
<LoggingKeyboardViewDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onCustomCallbackButtonPress;
@property (nonatomic) NSString *value;

@end
