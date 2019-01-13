#import <notify.h>

#import "RNLockState.h"

@implementation RNLockState
{
    int notify_token_lockstate;
    int notify_token_lockcomplete;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"lockStateDidChange", @"lockComplete"];
}

- (void)startObserving
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    
//    notify_register_dispatch("com.apple.springboard.lockstate", &notify_token_lockstate, dispatch_get_main_queue(), ^(int token) {
//        uint64_t state = UINT64_MAX;
//        notify_get_state(token, &state);
//        [self handleLockStateChange:state];
//    });
//
//    notify_register_dispatch("com.apple.springboard.lockcomplete", &notify_token_lockcomplete, dispatch_get_main_queue(), ^(int token) {
//        uint64_t state = UINT64_MAX;
//        notify_get_state(token, &state);
//        [self handleLockComplete:state];
//    });
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
        printf("asdf");
    [self sendEventWithName:@"lockStateDidChange" body:@{@"lockState": @"unlocked"}];
}


- (void)stopObserving
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleLockStateChange:(uint64_t)state
{
    if (state == 0) {
        [self sendEventWithName:@"lockStateDidChange" body:@{@"lockState": @"unlocked"}];
    } else {
        [self sendEventWithName:@"lockStateDidChange" body:@{@"lockState": @"locked"}];
    }
}

- (void)handleLockComplete:(uint64_t)state
{
    [self sendEventWithName:@"lockComplete" body:@{@"lockState": @"lockComplete"}];
}

@end
  
