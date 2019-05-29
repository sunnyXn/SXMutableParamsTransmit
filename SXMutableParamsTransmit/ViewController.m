//
//  ViewController.m
//  SXMutableParamsTransmit
//
//  Created by Sunny on 2019/5/29.
//  Copyright © 2019 Sunny. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
#import "NSObject+PerformObjects.h"


#define SX_PUSH_TO_VC(_cls)   SX_PUSH_TO_VC_ANIMATED(_cls , YES)
#define SX_PUSH_TO_VC_ANIMATED(_cls , _isAnimated) [self.navigationController pushViewController:_cls animated:_isAnimated];


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
}


- (void)actionClick:(UIButton *)btn
{
    UIViewController * pushVC = [PushViewController new];
    
    NSString * sel = @"actionClick:andSubtitle:andMsg:andArys:";
    NSString * title = @"这是标题";
    NSString * subTitle = @"副标题123";
    NSDictionary * dict = @{@"key":@"msg123"};
    NSArray * ary = @[@"msg123456"];
    
    id _obj = pushVC;
    id result = nil;
    SEL selctor = NSSelectorFromString(sel);
    
    /*
        三种方法调用多参数函数
     */
    
    SX_MsgSend(_obj , selctor , title , subTitle , dict , ary);
    
    SX_OBJECT_FUNC_ARGS(_obj, sel , title , subTitle , dict , ary);
    
    result = [_obj sx_performSelector:selctor withObjects:title , subTitle , dict , ary , nil];
    
    
    SX_PUSH_TO_VC(pushVC)
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
