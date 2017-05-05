#import <Squall/Squall.h>

#import "RCTViewManager.h"
#import "RNSLAnimation.h"

#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"

#import "RCTLog.h"

@interface RNSLAnimationManager : RCTViewManager <RCTSLAnimationDelegate>
@end

@implementation RNSLAnimationManager

RCT_EXPORT_MODULE();

- (UIView *)view
{
  RNSLAnimation* a = [[RNSLAnimation alloc] init];
  a.delegate = self;
  return a;
}

- (NSArray *)customDirectEventTypes
{
  return @[
           @"onAnimationStart",
           @"onAnimationEnd",
           @"onAnimationUpdate",
           @"onAnimationSpeedChange",
           @"onAnimationLoaded"
           ];
}

- (NSDictionary *)constantsToExport
{
  return @{
           @"SLSizingAspectFit": @(SLSizingAspectFit),
           @"SLSizingAspectFill": @(SLSizingAspectFill),
           @"SLSizingOriginal": @(SLSizingOriginal),
           @"SLPlaybackTypeOnce": @(SLPlaybackTypeOnce),
           @"SLPlaybackTypeLoop": @(SLPlaybackTypeLoop),
           @"SLPlaybackTypePingPong": @(SLPlaybackTypePingPong),
           };
}

#pragma mark - View Properties

RCT_EXPORT_VIEW_PROPERTY(playbackType, NSUInteger);
RCT_EXPORT_VIEW_PROPERTY(progress, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(play, BOOL);
RCT_EXPORT_VIEW_PROPERTY(time, NSTimeInterval);
RCT_EXPORT_VIEW_PROPERTY(rate, CGFloat);

#pragma mark - RCTSLAnimationDelegate fulfillment

- (void) animationStart: (RNSLAnimation *) sender {
  NSDictionary *event = @{ @"target": sender.reactTag };
  [self.bridge.eventDispatcher sendInputEventWithName:@"onAnimationStart" body:event];
}

- (void) animationEnd: (RNSLAnimation *) sender {
  NSDictionary *event = @{ @"target": sender.reactTag };
  [self.bridge.eventDispatcher sendInputEventWithName:@"onAnimationEnd" body:event];
}

- (void) animationUpdate: (RNSLAnimation *) sender {
  NSDictionary *event = @{
                          @"target": sender.reactTag,
                          @"progress": [NSString stringWithFormat: @"%.2f", sender.animation.progress]
                          };
  [self.bridge.eventDispatcher sendInputEventWithName:@"onAnimationUpdate" body:event];
}

- (void) animationSpeedChange: (RNSLAnimation *) sender {
  NSDictionary *event = @{
                          @"target": sender.reactTag,
                          @"rate": [NSString stringWithFormat: @"%.2f", sender.animation.rate]
                          };
  [self.bridge.eventDispatcher sendInputEventWithName:@"onAnimationSpeedChange" body:event];
}

- (void) animationLoaded: (RNSLAnimation *) sender {
  NSDictionary *event = @{
                          @"target": sender.reactTag,
                          @"duration": [NSString stringWithFormat: @"%.2f", sender.animation.duration]
                          };
  [self.bridge.eventDispatcher sendInputEventWithName:@"onAnimationLoaded" body:event];
}

@end