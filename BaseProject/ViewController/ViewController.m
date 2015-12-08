//
//  ViewController.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "iCarousel.h"
#import "ImageViewController.h"
#import "MyMusicViewController.h"
#import "MyViewController.h"

@interface ViewController ()<iCarouselDataSource,iCarouselDelegate>
@property (nonatomic,strong) NSArray *imageNames;
@property (nonatomic,strong) iCarousel *ic;

@end

@implementation ViewController
- (NSArray *)imageNames{
    if (!_imageNames) {
        _imageNames = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    }
    return _imageNames;
}

- (iCarousel *)ic{
    if (!_ic) {
        _ic = [iCarousel new];
        _ic.delegate = self;
        _ic.dataSource = self;
        _ic.type = 1;
        _ic.scrollSpeed = 1;
        
    }
    return _ic;
}


#pragma mark -- iCarousel
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    if (option == iCarouselOptionWrap) {
        return YES;//type0的默认循环不支持
    }
    //修改缝隙
    if (option == iCarouselOptionSpacing) {
        return value * 1.1;
    }
    //取消后背显示
    if (option == iCarouselOptionShowBackfaces) {
        return NO;
    }
    return value;
    
}

//有多少个cell
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.imageNames.count;
}

//每个cell什么样
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view) {
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW/1.5, kWindowH/1.5)];
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = 2;
        imageView.clipsToBounds = YES;
        imageView.tag = 100;
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    UIImageView *imageView = (UIImageView *)[view viewWithTag:100];
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"HeroSkins" ofType:@"bundle"];
   // path = [path stringByAppendingPathComponent:self.imageNames[index]];
    
    
    
    imageView.image = [UIImage imageNamed:self.imageNames[index]] ;
    
    return view;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *yuanlaidetu = [UIImage imageNamed:@"backImage"];
    UIImage *image = [yuanlaidetu resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    

    [self.view addSubview:self.ic];
    [self.ic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        
    }];
    
    [NSTimer bk_scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
                [self.ic scrollToItemAtIndex:self.ic.currentItemIndex+1 animated:YES];
           } repeats:YES];
    
    
    
    
    
    UILabel *label = [UILabel new];
    label.text = @"立即体验";
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    //建立闪光区域，所有在闪光区域内的控件都会闪
    FBShimmeringView *sv = [FBShimmeringView new];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-28);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    //把label放入闪光区域,必须这么写，不能addsubview
    sv.contentView = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    // 开始闪
    label.textColor = [UIColor whiteColor];
    sv.shimmering = YES;

    
    
    
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake((self.imageNames.count-1)*self.ic.frame.size.width, 0, self.ic.frame.size.width, self.ic.frame.size.height);
    [button addTarget:self action:@selector(gotoMyMusic:)forControlEvents:UIControlEventTouchUpInside];
    [sv addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    
    
    
//    UILabel *label = [UILabel new];
//    label.text = @"立即体验";
//    label.font = [UIFont boldSystemFontOfSize:20];
//    label.textAlignment = UITextAlignmentCenter;
//    //建立闪光区域，所有在闪光区域内的控件都会闪
//    FBShimmeringView *sv = [FBShimmeringView new];
//    [self.view addSubview:sv];
//    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(0);
//        make.bottom.mas_equalTo(-28);
//        make.size.mas_equalTo(CGSizeMake(120, 40));
//    }];
//    //把label放入闪光区域,必须这么写，不能addsubview
//    sv.contentView = label;
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//    // 开始闪
//    label.textColor = [UIColor whiteColor];
//    sv.shimmering = YES;



}
- (void)gotoMyMusic:(UIButton *)sender{
    MyMusicViewController *myVc = [[MyMusicViewController alloc] init];
    ImageViewController *iVC = [[ImageViewController alloc] init];
    MyViewController *mVC = [[MyViewController alloc] init];
    
    UINavigationController *navi0 = [[UINavigationController alloc] initWithRootViewController:myVc];
    UINavigationController *navi1 = [[UINavigationController alloc] initWithRootViewController:iVC];
    UINavigationController *navi2 = [[UINavigationController alloc] initWithRootViewController:mVC];
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tabbar_selected_back"];
    tabBar.tabBar.tintColor = [UIColor whiteColor];
    tabBar.viewControllers = @[navi0,navi1,navi2];
    [self presentViewController:tabBar animated:YES completion:nil];
    
}



//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint p = scrollView.contentOffset;
//    NSInteger index = p.x/self.view.frame.size.width;
//    self.pageControl.currentPage = index;
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
