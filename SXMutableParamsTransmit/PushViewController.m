//
//  PushViewController.m
//  SXMutableParamsTransmit
//
//  Created by Sunny on 2019/5/29.
//  Copyright © 2019 Sunny. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    
    
    UIButton * btnPop = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPop addTarget:self action:@selector(actionClickPop:) forControlEvents:UIControlEventTouchUpInside];
    btnPop.frame = CGRectMake(100, 300, 100, 100);
    [btnPop setTitle:@"pop" forState:UIControlStateNormal];
    [btnPop setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btnPop];
    
}


- (void)actionClick:(UIButton *)btn
{
    [self.navigationController pushViewController:[PushViewController new] animated:YES];
}

- (void)actionClickPop:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)actionClick:(NSString *)strTitle andSubtitle:(NSString *)subTitle andMsg:(NSDictionary *)dict andArys:(NSArray *)arys
{
    NSLog(@"strTitle:%@ , subtitle:%@ , msg:%@ , arys:%@",strTitle , subTitle , dict , arys);
    
}

- (void)actionTest:(id)msg
{
    NSLog(@"msg:%@",msg);
}

- (void)actionTest1
{
    NSLog(@"%@ , func:%s",NSStringFromSelector(_cmd) , __func__);
}

- (id)actionTestReturn:(id)msg
{
    return [NSString stringWithFormat:@"这是:%@.",msg];
}

- (id)actionTestReturn2:(id)msg :(id)msg2
{
    return [NSString stringWithFormat:@"这是:%@.%@。",msg , msg2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%@ , func:%s",NSStringFromSelector(_cmd) , __func__);
}

@end
