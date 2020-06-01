#import "LoggingKeyboard.h"
#import "RCTUIManager.h"
#import <React/RCTSinglelineTextInputView.h>
#import "LoggingKeyboardView.h"

@implementation LoggingKeyboard

@synthesize bridge = _bridge;

// specify main queue
- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
  // TODO: Implement some actually useful functionality
  callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

RCT_EXPORT_METHOD( hijackInput:(nonnull NSNumber *)reactTag callback:(RCTResponseSenderBlock)callback)
{
  // grab textInputField by reactTag
  RCTSinglelineTextInputView *view = (RCTSinglelineTextInputView*)[_bridge.uiManager viewForReactTag:reactTag];
  // init custom keyboard view
  LoggingKeyboardView* inputView = [[LoggingKeyboardView alloc] init];

  // connect custom keyboard view to the textview
  UITextView* textView = (UITextView*)view.backedTextInputView;
  [textView setInputView:inputView];

  // add reference to textview from inputview
  [inputView setTextView:textView];

  callback(@[[NSString stringWithFormat: @"reactTag: %@", reactTag]]);
}

@end
