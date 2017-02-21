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
    
    [LQNetworkingRequest GET:[NSString stringWithFormat:@"http://api.avatardata.cn/Joke/NewstImg?key=1effeeda1958456080de98962e51ecd8&page=%ld&rows=5",pageNum] parameters:nil needCache:YES success:^(id operation, id responseObject) {
        NSMutableArray * dataArr = [[NSMutableArray alloc]init];
        
        
        NSString * str = [responseObject objectForKey:@"error_code"];
        int code = [str intValue];
        
        NSArray * arr = responseObject[@"result"];
        
        if (str && code == 0 && arr.count != 0 ) {
            
            for (NSDictionary * perDic in arr) {
                FJChargeJokeModel *model = [[FJChargeJokeModel alloc]init];
                model.title = perDic[@"content"];
                model.imageUrl = perDic[@"url"];
                model.time = perDic[@"updatetime"];
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
