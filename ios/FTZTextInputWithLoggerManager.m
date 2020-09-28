#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(FTZTextInputWithLoggerManager, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(mostRecentEventCount, NSInteger)
RCT_EXPORT_SHADOW_PROPERTY(text, NSString)
@end


