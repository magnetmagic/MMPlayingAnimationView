//
//  ViewController.m
//  PlayingAnimationView
//
//  Created by matsubaratomoki on 2016/11/11.
//  Copyright © 2016年 magnet-magic. All rights reserved.
//

#import "ViewController.h"
#import "MMPlayingAnimationView.h"
@interface ViewController ()
@property (assign) IBOutlet MMPlayingAnimationView *playingAnimationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *themeColor1 = [UIColor colorWithRed:158/255.0f
                                           green:92/255.0f
                                            blue:151/255.0f alpha:1.0f];
    UIColor *themeColor2 = [UIColor colorWithRed:118/255.0f
                                           green:42/255.0f
                                            blue:111/255.0f
                                           alpha:1.0f];
    UIColor *keyColor = [UIColor colorWithRed:243/255.0f
                                        green:199/255.0f
                                         blue:35/255.0f alpha:1.0f];
    
    self.playingAnimationView.backgroundColor = themeColor1;
    self.view.backgroundColor = themeColor2;

    [self.playingAnimationView settings:@{kMMPlayingAnimationViewSettingsBarNumber:@(5),
                                          kMMPlayingAnimationViewSettingsBarColorKey:keyColor,
                                          kMMPlayingAnimationViewSettingsBarWidthRateKey:@(0.7f),
                                          kMMPlayingAnimationViewSettingsFrameRate:@(30)}];
    
}

- (IBAction)start:(id)sender{
    [self.playingAnimationView start];
}
- (IBAction)stop:(id)sender{
    [self.playingAnimationView stop];
}
@end
