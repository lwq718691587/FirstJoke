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
    
    if (!ValueNSUserDefaults(chargeJokeTotalPageNumber)) {
        SetNSUserDefaults([NSNumber numberWithInteger:1], chargeJokeTotalPageNumber);
    }
    
    self.pageNumber = 1;
    self.title = [NSString stringWithFormat:@"精选(%ld)", [ValueNSUserDefaults(chargeJokeTotalPageNumber) integerValue]* 5];
    [self update:self.pageNumber];
    [self createTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemFun)];
    
    // Do any additional setup after loading the view.
}

- (void)update:(NSInteger )pagenumber{
    

    NSInteger  totalPageNumber = [ValueNSUserDefaults(chargeJokeTotalPageNumber) integerValue];
    if (self.pageNumber > totalPageNumber) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"您最多可看%ld条笑话，如需更多请购买！",totalPageNumber * 5]];
        [self.chargeJokeTableView.mj_header endRefreshing];
        [self.chargeJokeTableView.mj_footer endRefreshing];
        self.pageNumber --;
        return;
    }

    [FJChargeJokeModel getjokeListOfPageNum:pagenumber Success:^(NSMutableArray *dataArr) {
        if (pagenumber == 1) {
            self.dataArr = dataArr;
        }else{
            [self.dataArr addObjectsFromArray:dataArr];
        }
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
    
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self update:self.pageNumber];
    }];
    [header setTitle:@"下拉开始刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开以进行刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"刷新中 ..." forState:MJRefreshStateRefreshing];
    self.chargeJokeTableView.mj_header = header;
    
    self.chargeJokeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self update:self.pageNumber];
    }];
    
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
    }
    cell.delegate = self;
    cell.model = self.dataArr[indexPath.row];
    return cell;
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
    NSInteger pageNumber = [ValueNSUserDefaults(chargeJokeTotalPageNumber) integerValue];
    pageNumber ++;
    SetNSUserDefaults([NSNumber numberWithInteger:pageNumber], chargeJokeTotalPageNumber);
    self.title = [NSString stringWithFormat:@"精选(%ld)",pageNumber * 5];
}

@end
