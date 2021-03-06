//
//  PlayView.h
//  BaseProject
//
//  Created by tarena on 15/11/14.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayView : UIView
+ (PlayView *)sharedInstance;

- (void)playWithURL:(NSURL *)musicURL;

@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) UIButton *playBtn;
@end
