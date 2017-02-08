//
//  FJChargeJokeViewController.m
//  FirstJoke
//
//  Created by 刘伟强 on 2017/2/8.
//  Copyright © 2017年 刘伟强. All rights reserved.
//

#import "FJChargeJokeViewController.h"
#import "FJChargeJokeModel.h"
#import "FJChargeJokeTableViewCell.h"
#import "LQFullscreenImageViewController.h"

#define chargeJokeTotalPageNumber @"chargeJokeTotalPageNumber"

@interface FJChargeJokeViewController ()<UITableViewDelegate,UITableViewDataSource,FJChargeJokeTableViewCellDelegate>
@property (strong, nonatomic) UITableView *chargeJokeTableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (nonatomic) NSInteger pageNumber;
@end

@implementation FJChargeJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNumber = 1;
    [self update:self.pageNumber];
    [self createTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemFun)];
    
    // Do any additional setup after loading the view.
}

- (void)update:(NSInteger )pagenumber{


    [FJChargeJokeModel getjokeListOfPageNum:pagenumber Success:^(NSMutableArray *dataArr) {
        self.dataArr = dataArr;
        [self.chargeJokeTableView reloadData];
        [self.chargeJokeTableView.mj_header endRefreshing];
        [self.chargeJokeTableView.mj_footer endRefreshing];
    } failure:^{
        
    }];
}

//创建tableView
-(void)createTableView
{
    self.chargeJokeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.view.bounds.size.width, self.view.bounds.size.height - 64 - 44) style:UITableViewStylePlain];
    self.chargeJokeTableView.delegate = self;
    self.chargeJokeTableView.dataSource =self;
    self.chargeJokeTableView.backgroundColor=[UIColor clearColor];
    
    self.chargeJokeTableView.rowHeight = SFhy(260);
    [self.view addSubview:self.chargeJokeTableView];
}

//设置row的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
//设置cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *PickViewCell=@"PickViewCell";
    FJChargeJokeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:PickViewCell];
    if (cell==nil) {
        cell = [[FJChargeJokeTableViewCell  alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PickViewCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.delegate = self;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"一元5条笑话，购买立即获得更多快乐";
}

-(void)tapFunDelegate:(UIImageView *)iv{
    UIImageView * cell = iv;
    LQFullscreenImageViewController * vc = [[LQFullscreenImageViewController alloc]init];
    vc.liftedImageView = cell;
    [self presentViewController:vc animated:YES completion:nil];
}
//cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)rightBarButtonItemFun{
    [self update:++self.pageNumber];
}

@end
