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
  // text input view to hook up custom keyboard view to
  RCTSinglelineTextInputView *view = (RCTSinglelineTextInputView*)[_bridge.uiManager viewForReactTag:reactTag];
  // custom keyboard view
  LoggingKeyboardView* inputView = [[LoggingKeyboardView alloc] init];
  // so somehow I need this inputView to pass to call view's events
  //
  // onButotnClick
  // UITextView *view = (UITextView*)[_bridge.uiManager viewForReactTag:reactTag];
  // [view replaceRange:view.selectedTextRange withText:@"A"];

  UITextView* textView = (UITextView*)view.backedTextInputView;
  [textView setInputView:inputView];
  [inputView doSomething];
  [textView reloadInputViews];

  callback(@[[NSString stringWithFormat: @"reactTag: %@", reactTag]]);
}

@end
