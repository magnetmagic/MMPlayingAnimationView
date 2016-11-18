//
//  MMPlayingAnimationView.m
//  PlayingAnimationView
//
//  Created by matsubaratomoki on 2016/11/11.
//  Copyright © 2016年 magnet-magic. All rights reserved.
//

#import "MMPlayingAnimationView.h"

@interface MMPlayingAnimationView(){
    
}
@property CADisplayLink *displayLink;
@property NSMutableArray <CAShapeLayer*>* shapeLayers;
@property NSMutableArray <NSNumber*>* randoms;

@end

@implementation MMPlayingAnimationView

-(void)start{
    if( self.displayLink ){
        self.displayLink = nil;
        for( CALayer *layer in self.shapeLayers){
            [layer removeFromSuperlayer];
        }
        [self.shapeLayers removeAllObjects];
        [self.randoms removeAllObjects];
        
    }
    self.shapeLayers = [NSMutableArray array];
    self.randoms = [NSMutableArray array];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self
                                                   selector:@selector(animation)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    for( int i = 0 ; i < 3 ; i ++ ){
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        CGFloat w = self.bounds.size.width  / 3;
        CGFloat h = self.bounds.size.height;
        CGRect frame = CGRectMake(i * w , 0, h,w );
        shapeLayer.frame = frame;
        shapeLayer.lineCap = @"square";
        shapeLayer.lineWidth = w * 0.8f;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(w/2, h)];
        [path addLineToPoint:CGPointMake(w/2, 0)];
        shapeLayer.path = path.CGPath;
        
        shapeLayer.strokeStart = 0.0f;
        shapeLayer.strokeEnd = 0.0f;
        //    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:shapeLayer];
        [self.shapeLayers addObject:shapeLayer];

        NSInteger random = [self random];
        [self.randoms addObject:@(random)];
    }
}
- (void)animation{
    for( int i = 0 ; i < 3 ; i ++ ){
        NSNumber *number =  self.randoms[i];
        CAShapeLayer *layer =  self.shapeLayers[i];
        
        CGFloat num = [number integerValue] / 100.0f;
        if( num > 0.0f ){
            layer.strokeEnd += 0.03f ;
            if( layer.strokeEnd > num ){
                number = @(0);
                self.randoms[i] = number;
            }
        }else{
            layer.strokeEnd -= 0.03f ;
            if( layer.strokeEnd <= 0.0f ){
                NSInteger random = [self random];
                number = @(random);
                self.randoms[i] = number;
            }
        }
    }
    
}
-(NSInteger)random{
    NSInteger value =  ((NSInteger) arc4random()) % 60;
    NSLog(@"random = %ld",value);
    return value+40;
}
@end
