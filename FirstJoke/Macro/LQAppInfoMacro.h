//
//  LQAppInfoMacro.h
//  LQBaseProject
//
//  Created by 刘伟强 on 16/8/18.
//  Copyright © 2016年 刘伟强. All rights reserved.

//app信息宏定义

#ifndef LQAppInfoMacro_h
#define LQAppInfoMacro_h


//聚合网址 ： https://www.juhe.cn/myData 账号：17600802935 密码：lwq521xf1314
#define juheAppKey  @"1b276db92deba10fa14b00035ad110a7"

//uMeng 账号 ： lwqdeveloper@163.com 密码 ： lwq521xf1314@dev
#define uMengAppkey @"58acef47bbea836e10000926"

#define product1_ID @"com.LCTechnology.FirstJoke1"

//沙盒测试环境验证
//#ifdef DEBUG
//    #define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//#else
    #define SANDBOX @"https://buy.itunes.apple.com/verifyReceipt"
//#endif

//appID
#define AppStoreID                      @"100709015711" //线上的appID

#define AppFontOfSize(s)                [UIFont fontWithName:AppFontName size:SFhy(s)]
//app字体
#define AppFontName                     [NSString stringWithFormat:@"%@",[[UIFont systemFontOfSize:1] fontName]]
//app一级标题字体大小
#define AppFirstTitleFontSize           14
//app二级标题字体大小
#define AppSecondTitleFontSize          14
//app三级标题字体大小
#define AppThirdTitleFontSize           14

//app一级正文字体大小
#define AppFirstTextFontSize            14
//app二级正文字体大小
#define AppSecondTextFontSize           14
//app三级三级正文字体大小
#define AppThirdTextFontSize            14

//app主色调
#define AppColor                        HexColor(@"75a7ef")
//app标题颜色
#define AppTitleColor                   HexColor(@"2f3b4a")
//app正文颜色
#define AppTextColor                    HexColor(@"2f3b4a")
//是否是第一次使用
#define App_HasBeenOpened_Count         @"App_HasBeenOpened"

#endif /* LQAppInfoMacro_h */
