//
//  MMPlayingAnimationView.h
//  PlayingAnimationView
//
//  Created by matsubaratomoki on 2016/11/11.
//  Copyright © 2016年 magnet-magic. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kMMPlayingAnimationViewSettingsBarColorKey;
extern NSString * const kMMPlayingAnimationViewSettingsBarWidthRateKey;
extern NSString * const kMMPlayingAnimationViewSettingsBarNumber;
extern NSString * const kMMPlayingAnimationViewSettingsFrameRate;
@interface MMPlayingAnimationView : UIView
- (void)settings:(NSDictionary*)settings;
- (void)start;
- (void)stop;
@end
