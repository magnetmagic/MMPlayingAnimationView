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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MMPlayingAnimationView *v = [[MMPlayingAnimationView alloc]initWithFrame:CGRectMake(50,50,100,100)];
    v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v];
    [v start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
