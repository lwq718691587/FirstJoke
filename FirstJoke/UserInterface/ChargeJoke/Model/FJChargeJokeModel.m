//
//  FJChargeJokeModel.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "FJChargeJokeModel.h"

@implementation FJChargeJokeModel

+ (void)getjokeListOfPageNum:(NSUInteger)pageNum Success:(void(^)(NSMutableArray *dataArr))success failure:(void(^)())failure{
    
    [LQNetworkingRequest GET:[NSString stringWithFormat:@"http://japi.juhe.cn/joke/img/text.from?key=%@&page=%ld&pagesize=5",juheAppKey,pageNum] parameters:nil needCache:YES success:^(id operation, id responseObject) {
        NSMutableArray * dataArr = [[NSMutableArray alloc]init];
        
        
        NSString * str = [responseObject objectForKey:@"error_code"];
        int code = [str intValue];
        id result = [responseObject objectForKey:@"result"];
        NSArray *resultData = nil;
        if ([result isKindOfClass:[NSDictionary class]]) {
            id arr = [result objectForKey:@"data"];
            if ([arr isKindOfClass:[NSArray class]]) {
                resultData = arr;
            }
        }
        
        if (str && code == 0 && result && resultData && resultData.count != 0 ) {
            for (NSDictionary * perDic in resultData) {
                FJChargeJokeModel *model = [[FJChargeJokeModel alloc]init];
                model.title = [perDic[@"content"] isKindOfClass:[NSString class]] ? perDic[@"content"] : @"数据出错";
                model.imageUrl = [perDic[@"url"] isKindOfClass:[NSString class]] ? perDic[@"url"] : @"charge2.png";
                model.time = [perDic[@"updatetime"] isKindOfClass:[NSString class]] ? perDic[@"updatetime"] : @"数据出错";
                [dataArr addObject:model];
            }
        }else{
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FJCharge" ofType:@"plist"];
            NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
            
            for (int i = 0; i < 5; i++) {
                NSDictionary * perDic;
                if (pageNum % 2 == 1) {
                    perDic = data[i];
                }else{
                    perDic = data[i + 5];
                }
                FJChargeJokeModel *model = [[FJChargeJokeModel alloc]init];
                model.title = perDic[@"content"];
                model.imageUrl = perDic[@"url"];
                model.time = perDic[@"updatetime"];
                [dataArr addObject:model];
            }
        }
        success(dataArr);
    } failure:^(id operation, NSError *error) {
        failure();
    }];
}

@end
