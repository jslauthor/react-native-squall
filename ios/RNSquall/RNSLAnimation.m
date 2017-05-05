#import <Squall/Squall.h>
#import "RNSLAnimation.h"
#import "RCTLog.h"

@implementation RNSLAnimation
{
  
}

@synthesize animation;
@synthesize delegate;

- (id)init {
  if ((self = [super initWithFrame:[[UIScreen mainScreen] applicationFrame]])) {
    animation = [SLSquallAnimation animationFromBundle:@"letters_anim.sqa"];
    
    // Wire animation for events
    __weak typeof(self) weakSelf = self;
    animation.onAnimationEvent = ^(SLAnimationEvent event){
      __strong typeof(self) s = weakSelf;
      if (s) {
        switch (event) {
          case SLAnimationEventStart:
            [s animationStart];
            break;
          case SLAnimationEventEnd:
            [s animationEnd];
            break;
          case SLAnimationEventUpdate:
            [s animationUpdate];
            break;
          case SLAnimationEventRateChange:
            [s animationSpeedChange];
            break;
          default: break;
        }
        
      }
    };
  }
  return self;
}

-(void) setBundlePath:(NSString *)bundlePath {
  // TODO: Instantiate animation here
}

- (void)setPlaybackType:(NSUInteger)type {
  [animation setPlaybackType:type];
}

- (void)setTime:(NSTimeInterval) time {
  [animation setTime:time];
}

- (void)setRate:(CGFloat) rate {
  [animation setRate:rate];
}

- (void)setProgress:(CGFloat) progress {
  [animation setProgress:progress];
}

- (void)setPlay:(BOOL) toggle {
  if (toggle)
    [animation play];
  else
    [animation pause];
}

-(void)layoutSubviews {
  [super layoutSubviews];
  [self.layer addSublayer:animation];
  animation.frame = self.bounds;
  [self animationLoaded];
}

#pragma mark - RCTSLAnimationDelegate Methods

- (void) animationStart {
  [self.delegate animationStart:self];
}

- (void) animationEnd {
  [self.delegate animationEnd:self];
}

- (void) animationUpdate {
  [self.delegate animationUpdate:self];
}

- (void) animationSpeedChange {
  [self.delegate animationSpeedChange:self]; 
}

- (void) animationLoaded {
  [self.delegate animationSpeedChange:self];
}

@end
