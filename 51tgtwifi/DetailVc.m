//
//  DetailVc.m
//  51tgtwifi
//
//  Created by TGT on 2017/10/27.
//  Copyright © 2017年 weiyuxiang. All rights reserved.
//

#import "DetailVc.h"
#import "PayViewController.h"

#define url(a) [@"http://as2.51tgt.com" stringByAppendingString:a]

@interface DetailVc ()<UIWebViewDelegate>
{
    UIView *      _TitleView;
    UILabel *       TitleText;

}
@end

@implementation DetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self HeadTitle];
    
    [self webview];
    
    
    
}

-(void)webview{
  

    
    
    UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20+60, XScreenWidth, XScreenHeight-60-20)];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url(_DetailUrl)]];
    
    webV.backgroundColor = [UIColor clearColor];
    
    [webV loadRequest:request];
    
    [self.view addSubview:webV];
    
    webV.delegate = self;
    
//    禁止拖拽
    webV.scrollView.bounces = NO;
   
    
     [MBProgressHUD showActivityIndicator];

}


#pragma mark - 创建标题栏
-(void)HeadTitle{
    //    背景图片
    UIImageView *backgroud = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, XScreenWidth,XScreenHeight)];
    
    backgroud.image = [UIImage imageNamed:@"2.jpg"];
    
    [self.view addSubview:backgroud];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    _TitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, XScreenWidth, 60)];
    
    _TitleView.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:84.0/255.0 blue:178.0/255.0 alpha:1];
    
    [self.view addSubview:_TitleView];
    
    TitleText = [UILabel new];
    [_TitleView addSubview:TitleText];
    
    TitleText.text = @"";
    TitleText.textColor = [UIColor whiteColor];
    
    [TitleText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(_TitleView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    TitleText.textAlignment = NSTextAlignmentCenter;
    
    
    
    //    取消按钮
    UIButton *btn = [UIButton new];
    [_TitleView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_TitleView).offset(0);
        
        make.centerY.equalTo(TitleText);
        
        make.size.mas_equalTo(CGSizeMake(80, 80));
        
        
    }];
    
    btn.tag = 101;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click:(UIButton *)btn{
    if (btn.tag==101) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (btn.tag==102){
            PayViewController *vc = [[PayViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
    
    }
}


#pragma mark 代理

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
   

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    
    [MBProgressHUD hideActivityIndicator];
    
    

    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_TitleView).offset(0);
        
        make.centerY.equalTo(TitleText);
        
        make.size.mas_equalTo(CGSizeMake(100, 100));
        
        
    }];
    
    btn.tag = 102;
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitle:@"购买流量" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 10;

    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
