//
//  FJFreeJokeModel.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
// http://avatardata.cn/Docs/Api/4b49361c-e858-4a69-845e-0c8c3b24cb5f
// 账号 ： 17600802935 密码 lwq521xf1314

#import "FJFreeJokeModel.h"

@implementation FJFreeJokeModel

+ (void)getjokeListOfPageNum:(NSUInteger)pageNum Success:(void(^)(NSMutableArray *dataArr))success failure:(void(^)())failure{

    [LQNetworkingRequest GET:[NSString stringWithFormat:@"http://api.avatardata.cn/Joke/NewstJoke?key=ce030797ef7d4620a1ec2f4a0becb013&page=%ld&rows=10",pageNum] parameters:nil needCache:YES success:^(id operation, id responseObject) {
        NSMutableArray * dataArr = [[NSMutableArray alloc]init];
        
        NSString * str = [responseObject objectForKey:@"error_code"];
        int code = [str intValue];
        
        NSArray * arr = responseObject[@"result"];
        
        if (str && code == 0 && arr.count != 0 ) {
       
            for (NSDictionary * perDic in arr) {
                FJFreeJokeModel *model = [[FJFreeJokeModel alloc]init];
                model.content = perDic[@"content"];
                model.content = [model.content stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
                model.time = perDic[@"updatetime"];
                [dataArr addObject:model];
            }
        }else{
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FJFree" ofType:@"plist"];
            NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
            for (NSDictionary * perDic in data) {
                FJFreeJokeModel *model = [[FJFreeJokeModel alloc]init];
                model.content = perDic[@"content"];
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
