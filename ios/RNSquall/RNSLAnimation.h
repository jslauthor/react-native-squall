#import <Squall/Squall.h>

#import "RCTView.h"
#import "RCTBridge.h"

@class RNSLAnimation;
@protocol RCTSLAnimationDelegate<NSObject>
  - (void) animationLoaded: (RNSLAnimation*) sender;
  - (void) animationStart: (RNSLAnimation*) sender;
  - (void) animationEnd: (RNSLAnimation*) sender;
  - (void) animationUpdate: (RNSLAnimation*) sender;
  - (void) animationSpeedChange: (RNSLAnimation*) sender;
@end

@interface RNSLAnimation : UIView
{
}

@property (readonly, nonatomic, copy) SLSquallAnimation* animation;
@property (nonatomic, weak) id <RCTSLAnimationDelegate> delegate;

- (id)init;

- (void)setBundlePath:(NSString*) bundlePath;
- (void)setTime:(NSTimeInterval) time;
- (void)setRate:(CGFloat) rate;
- (void)setProgress:(CGFloat) progress;
- (void)setPlay:(BOOL) toggle;
- (void)setPlaybackType:(NSUInteger) type;

@end
