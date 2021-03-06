//
//  LoginViewController.m
//  HJApp
//
//  Created by Bruce He on 15/11/2.
//  Copyright © 2015年 shanghai baiwei network technology. All rights reserved.
//

#import "LoginViewController.h"
#import "FlashViewController.h"
#import "HttpEngine.h"
#import "RegisterViewController.h"
#import "MyHJViewController.h"


//宏定义宽高
#define VIEW_WIDTH self.view.bounds.size.width
#define VIEW_HEIGHT self.view.bounds.size.height

#define LBVIEW_WIDTH1 [UIScreen mainScreen].bounds.size.width
#define LBVIEW_HEIGHT1 [UIScreen mainScreen].bounds.size.height

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.navigationController.navigationBarHidden=YES;
    self.view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1)];
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:1 alpha:1];
    
    UIView*titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, LBVIEW_WIDTH1, LBVIEW_HEIGHT1/10)];
    titleView.backgroundColor=[UIColor colorWithRed:0.23 green:0.5 blue:0.84 alpha:0.9];
    [self.view addSubview:titleView];
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake((LBVIEW_WIDTH1-100)/2.0, 25, 100, 30)];
    titleLabel.text=@"登录";
    titleLabel.font=[UIFont systemFontOfSize:19];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    //取消按钮
    UIButton*backBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 40)];
    //[backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //输入框和登陆注册按钮
    NSArray*labelNameArray=[[NSArray alloc]initWithObjects:@"账户名:",@"登陆密码:", nil];
    NSArray*tfNameArray=[[NSArray alloc]initWithObjects:@"请输入帐号",@"请输入密码",nil];
    NSArray*btnNameArray=[[NSArray alloc]initWithObjects:@"登录",@"注册" ,nil];
    for (int i=0; i<2; i++)
    {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, titleView.frame.size.height+20+i*(LBVIEW_HEIGHT1/15.0+10), LBVIEW_WIDTH1/5.0, LBVIEW_HEIGHT1/15.0)];
        //label.backgroundColor=[UIColor redColor];
        label.text=labelNameArray[i];
        label.textAlignment=NSTextAlignmentRight;
        label.textColor=[UIColor blackColor];
        [self.view addSubview:label];
        
        UITextField*field=[[UITextField alloc]initWithFrame:CGRectMake(30+LBVIEW_WIDTH1/5.0, titleView.frame.size.height+20+i*(LBVIEW_HEIGHT1/15.0+10), LBVIEW_WIDTH1-label.frame.size.width-50, LBVIEW_HEIGHT1/15.0)];
        field.placeholder=tfNameArray[i];
        field.clearsOnBeginEditing=YES;
        field.borderStyle=UITextBorderStyleBezel;
        if (i==1)
        {
            field.secureTextEntry=YES;
        }
        if(i==0)
        {
            field.clearButtonMode=UITextFieldViewModeAlways;
        }
        field.tag=i+10;
        [self.view addSubview:field];
        //登陆注册按钮
        UIButton*lgBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, titleView.frame.size.height+2*label.frame.size.height+20+10+50+i*(LBVIEW_HEIGHT1/15.0+10), LBVIEW_WIDTH1-40, LBVIEW_HEIGHT1/15.0)];
        if (i==0)
        {
            [lgBtn setBackgroundColor:[UIColor redColor]];
        }
        else
        {
            [lgBtn setBackgroundColor:[UIColor grayColor]];
        }
        lgBtn.tag=i;
        [lgBtn setTitle:btnNameArray[i] forState:UIControlStateNormal];
        [lgBtn addTarget:self action:@selector(lgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:lgBtn];
        
    }
    //忘记密码按钮
    UIButton*disBtn=[[UIButton alloc]initWithFrame:CGRectMake(LBVIEW_WIDTH1-LBVIEW_WIDTH1/4.0-10, titleView.frame.size.height+2*LBVIEW_HEIGHT1/15.0+20+10+10, LBVIEW_WIDTH1/4.0, LBVIEW_WIDTH1/15.0)];
    [disBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [disBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:disBtn];
    
    
    
}

//取消按钮
-(void)backBtn:(UIButton*)sender
{
    FlashViewController*flashVC=[[FlashViewController alloc]init];
    [self.navigationController pushViewController:flashVC animated:YES];
    
}
//登陆注册按钮
-(void)lgBtnClick:(UIButton*)sender
{
    UITextField*tfName=(UITextField*)[self.view viewWithTag:10];
    UITextField*tfPas=(UITextField*)[self.view viewWithTag:11];
    
    //登陆注册
    if (sender.tag==0)
    {
        //判断是否为空
        if ([tfName.text isEqualToString:@""])
        {
            UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"帐号不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            [alert addAction:cancelAction];
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        if ([tfPas.text isEqualToString:@""])
        {
            UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            
            [alert addAction:cancelAction];
            [alert addAction:otherAction];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }

        //发送登陆请求
        [HttpEngine loginRequest:tfName.text with:tfPas.text complete:^(NSString *fail)
         {
             NSString*str=fail;
             if ([str isEqualToString:@"fail"])
             {
                 UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                     
                 }];
                 UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                     
                 }];
                 [alert addAction:cancelAction];
                 [alert addAction:otherAction];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             else
             {
                 
                 [HttpEngine getConsumerData:^(NSArray *dataArray) {
                     
                 }];
                 
//                 [self.navigationController popToRootViewControllerAnimated:YES];
                 MyHJViewController*myHJ=[[MyHJViewController alloc]init];
                 [self.navigationController pushViewController:myHJ animated:YES];
             }
         }
         ];
        NSLog(@"denglu");
    }
    //注册
    else
    {
        
        
        RegisterViewController*registerVC=[[RegisterViewController alloc]init];
        [self.navigationController pushViewController:registerVC animated:YES];
        
        
//        [HttpEngine getConsumerDetailData:^(NSArray *dataArray) {
//            
//        }];
//        NSLog(@"zhuce");
    }
}



@end
