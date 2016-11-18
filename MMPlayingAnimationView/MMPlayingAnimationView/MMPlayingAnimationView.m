//
//  MMPlayingAnimationView.m
//  PlayingAnimationView
//
//  Created by matsubaratomoki on 2016/11/11.
//  Copyright © 2016年 magnet-magic. All rights reserved.
//

#import "MMPlayingAnimationView.h"
static CGFloat kBarSpeed = 0.04f;

@interface MMPlayingAnimationView()
@property CADisplayLink *displayLink;
@property NSMutableArray <CAShapeLayer*>* shapeLayers;
@property NSMutableArray <NSNumber*>* randoms;
// settings
@property UIColor *barColor;
@property NSNumber *barWidthRate;
@property NSNumber *barNumber;
@property NSNumber *frameRate;
@end

NSString * const kMMPlayingAnimationViewSettingsBarColorKey = @"MMPlayingAnimationViewBarColorKey";
NSString * const kMMPlayingAnimationViewSettingsBarWidthRateKey = @"MMPlayingAnimationViewBarWidthRateKey";
NSString * const kMMPlayingAnimationViewSettingsBarNumber = @"MMPlayingAnimationViewBarNumber";
NSString * const kMMPlayingAnimationViewSettingsFrameRate = @"MMPlayingAnimationViewSettingsFrameRates";

@implementation MMPlayingAnimationView

- (void)settings:(NSDictionary*)settings{
    self.barColor = settings[kMMPlayingAnimationViewSettingsBarColorKey];
    self.barWidthRate = settings[kMMPlayingAnimationViewSettingsBarWidthRateKey];
    self.barNumber = settings[kMMPlayingAnimationViewSettingsBarNumber];
    self.frameRate = settings[kMMPlayingAnimationViewSettingsFrameRate];
}
- (void)stop{
    self.displayLink.paused = YES;
}
-(void)start{
    if( self.displayLink ){
        self.displayLink.paused = NO;
        return;
    }
    [self setDefaultSetting];
    
    self.shapeLayers = [NSMutableArray arrayWithCapacity:[self.barNumber integerValue]];
    self.randoms = [NSMutableArray arrayWithCapacity:[self.barNumber integerValue]];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(animation)];
    self.displayLink.frameInterval = 100/[self.frameRate integerValue];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    for( int i = 0 ; i < [self.barNumber integerValue] ; i ++ ){
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        CGFloat w = self.bounds.size.width  / [self.barNumber integerValue];
        CGFloat h = self.bounds.size.height;
        CGRect frame = CGRectMake(i * w , 0, h,w );
        shapeLayer.frame = frame;
        shapeLayer.lineCap = @"square";
        shapeLayer.lineWidth = w * [self.barWidthRate doubleValue];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(w/2, h)];
        [path addLineToPoint:CGPointMake(w/2, 0)];
        shapeLayer.path = path.CGPath;
        
        shapeLayer.strokeStart = 0.0f;
        shapeLayer.strokeEnd = 0.0f;
        //    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.strokeColor = self.barColor.CGColor;
        shapeLayer.fillColor = self.barColor.CGColor;
        [self.layer addSublayer:shapeLayer];
        [self.shapeLayers addObject:shapeLayer];

        NSInteger random = [self random];
        [self.randoms addObject:@(random)];
    }
}
- (void)animation{
    for( int i = 0 ; i < [self.barNumber integerValue] ; i ++ ){
        NSNumber *number =  self.randoms[i];
        CAShapeLayer *layer =  self.shapeLayers[i];
        
        CGFloat num = [number integerValue] / 100.0f;
//        NSLog(@"layer.strokeEnd = %f",layer.strokeEnd);
        if( num > 0.0f ){
            layer.strokeEnd += kBarSpeed ;
            if( layer.strokeEnd > num ){
//                NSLog(@"change down %f",num);
                number = @(0);
                self.randoms[i] = number;
            }
        }else{
            layer.strokeEnd -= kBarSpeed ;
            if( layer.strokeEnd <= 0.0f ){
//                NSLog(@"change up %f",num);
                NSInteger random = [self random];
                number = @(random);
                self.randoms[i] = number;
            }
        }
    }
    
}
-(NSInteger)random{
    NSInteger value =  ((NSInteger) arc4random()) % 70;
//    NSLog(@"random = %ld",(long)value+20);
    return value+20;
}
-(void)setDefaultSetting{
    if( !self.barColor ){
        self.barColor = [UIColor blackColor];
    }
    if( !self.barWidthRate || [self.barWidthRate doubleValue]){
        self.barWidthRate =@(0.8f);
    }
    if( !self.barNumber || [self.barNumber integerValue] <= 0 ){
        self.barNumber = @(3);
    }
    if( !self.frameRate || [self.frameRate integerValue] <= 0 ){
        self.frameRate = @(20);
    }
    
}
@end
