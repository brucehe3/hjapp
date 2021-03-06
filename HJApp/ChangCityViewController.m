//
//  ChangCityViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/6.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "ChangCityViewController.h"
#import "HttpEngine.h"

@interface ChangCityViewController ()

@property(nonatomic,strong)NSArray*dataArray;
@end

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

@implementation ChangCityViewController

-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.frame=CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1);

    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    [HttpEngine getCityNameBackcompletion:^(NSArray*array)
     {
         _dataArray=array;
         [self showPage];
    }];
    
    
}
-(void)showPage
{
    UILabel*chooseCityLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, LBVIEW_WIDTH1, 60)];
    
    chooseCityLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CITYNAME"];
    chooseCityLabel.textAlignment=NSTextAlignmentCenter;
    chooseCityLabel.textColor=[UIColor redColor];
    chooseCityLabel.font=[UIFont systemFontOfSize:19];
    chooseCityLabel.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:chooseCityLabel];
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 124, LBVIEW_WIDTH1, 40)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.text=@"热门城市";
    
    [self.view addSubview:titleLabel];
    
    int height=(int)_dataArray.count/3;
    
    UIView*btnView=[[UIView alloc]initWithFrame:CGRectMake(0, 164, LBVIEW_WIDTH1, (height+1)*60)];
    btnView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:btnView];
    
    for (int i=0; i<_dataArray.count; i++)
    {
        int X=i%3;
        int Y=i/3;
        
        NSDictionary*dic=_dataArray[i];
        UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake((LBVIEW_WIDTH1-180)/4+X*((LBVIEW_WIDTH1-180)/4+60), Y*60, 60, 30)];
        
        [btn setTitle:dic[@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.tag=i;
        [btn addTarget:self action:@selector(chooseCity:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
    }


}
-(void)chooseCity:(UIButton*)sender
{

    NSDictionary*dic=_dataArray[sender.tag];
    
    //homeVC.cityNameStr=dic[@"name"];
    //NSLog(@"%@",homeVC.cityNameStr);
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"code"] forKey:@"CODE"];
    [[NSUserDefaults standardUserDefaults]setObject:dic[@"name"] forKey:@"CITYNAME"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


@end
