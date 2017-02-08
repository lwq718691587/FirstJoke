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
        for (NSDictionary * perDic in responseObject[@"result"]) {
            FJChargeJokeModel *model = [[FJChargeJokeModel alloc]init];
            model.title = perDic[@"content"];
            model.imageUrl = perDic[@"url"];
            model.time = perDic[@"updatetime"];
            [dataArr addObject:model];
        }
        
        success(dataArr);
    } failure:^(id operation, NSError *error) {
        
    }];
}

@end
