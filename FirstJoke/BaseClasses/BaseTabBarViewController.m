//
//  BaseTabBarViewController.m
//  LOLKit
//
//  Created by 刘伟强 on 16/8/18.
//  Copyright © 2016年 刘伟强. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "LQMacro.h"
#import "FJChargeJokeViewController.h"
#import "FJFreeJokeViewController.h"
@interface BaseTabBarViewController ()
@property(nonatomic,strong)NSMutableArray * btnArr;
@property(nonatomic,strong)UIImageView * bearbarImageView;
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnArr = [[NSMutableArray alloc]init];
    [self addViewController];
    [self systemTabbar];
//    [self customTab1];
    
   
    // Do any additional setup after loading the view.
}

//装载视图 -
- (void)addViewController
{
    
    FJFreeJokeViewController * vc1 = [[FJFreeJokeViewController alloc]init];
    vc1.title = @"免费";
    BaseNavigationViewController * nvc1 = [[BaseNavigationViewController alloc]initWithRootViewController:vc1];
    
    FJChargeJokeViewController * vc2 = [[FJChargeJokeViewController alloc]init];
    vc2.title = @"精选";
    BaseNavigationViewController * nvc2 = [[BaseNavigationViewController alloc]initWithRootViewController:vc2];
    self.viewControllers = @[nvc1,nvc2];
    
}

- (void)systemTabbar{
    
    NSArray * itemImageArr = @[@"leftPage",@"homePage",@"rightPage"];
    
    for (int i = 0; i < 2; i++) {
        UITabBarItem * item = self.tabBar.items[i];
        item.image = [UIImage imageNamed:itemImageArr[i]];
        item.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    }
    self.selectedIndex = 1;
}

#pragma mark 转屏方法重写

- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}



@end
