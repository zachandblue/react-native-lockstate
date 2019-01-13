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

////Include the following in AppDelegate.m

//-(void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
//{
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"DataWillBecomeUnavailable"
//     object:self];
//}
//
//- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
//{
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"DataDidBecomeAvailable"
//     object:self];
//}

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"lockStateDidChange", @"lockComplete"];
}

- (void)startObserving
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(receiveNotification:)
        name:@"DataDidBecomeAvailable"
        object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(receiveNotification:)
        name:@"DataWillBecomeUnavailable"
        object:nil];

}

- (void) receiveNotification:(NSNotification *) notification
{
   
    if ([[notification name] isEqualToString:@"DataDidBecomeAvailable"])
        
//        printf("Data Became Available");
    [self sendEventWithName:@"lockStateDidChange" body:@{@"lockState": @"unlocked"}];
    
    if ([[notification name] isEqualToString:@"DataWillBecomeUnavailable"])
//        printf("Data Will become unavailable");
    [self sendEventWithName:@"lockStateDidChange" body:@{@"lockState": @"locked"}];
    

}


- (void)stopObserving
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
  
