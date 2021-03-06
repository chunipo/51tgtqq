//
//  ShoppingVc.m
//  51tgtwifi
//
//  Created by TGT on 2017/10/17.
//  Copyright © 2017年 weiyuxiang. All rights reserved.
//

#import "ShoppingVc.h"
#import "NSString+SHA256.h"
#import "ProductMo.h"
#import "PayViewController.h"
#import "ShopTabCell.h"
#import "DetailVc.h"

#define PicHead  @"http://as2.51tgt.com"


@interface ShoppingVc ()<UITableViewDelegate,UITableViewDataSource,PayPalPaymentDelegate>

{
    UITableView        *_tableView;
    
    NSMutableArray     *_arr;

}

//paypal配置
@property(nonatomic, strong) PayPalConfiguration *payPalConfig;

@end

@implementation ShoppingVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [MBProgressHUD showActivityIndicator];
    
    //    背景图片
    UIImageView *backgroud = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, XScreenWidth,XScreenHeight)];
    
    backgroud.image = [UIImage imageNamed:@"2.jpg"];
    
    [self.view addSubview:backgroud];
    
    
//    网络请求测试
    [self httpRequest];
    
    
    
//    创建tableview
    [self HeadTitle];
    
//    [self createTableView];
    

}




-(void)httpRequest{
//    初始化数组
    _arr = [NSMutableArray arrayWithCapacity:0];

//        h5
        NSString *str = @"http://as2.51tgt.com/FyjApp/GetFlowProducts?ssid=TGT23170126536&type=JPY";
    
//          str =  [str SHA256];
    
        [NetWork sendGetNetWorkWithUrl:str parameters:nil hudView:self.view successBlock:^(id data) {
            
            NSDictionary *dic1 = data[@"data"];
            NSArray *arr = dic1[@"products"];
            NSLog(@"data==================%@",arr);
            
            for (NSDictionary *dic in arr) {
                ProductMo *ProModel = [[ ProductMo alloc]init];
                
                [ProModel setValuesForKeysWithDictionary:dic];
                [ProModel setValue:dic[@"id"] forKey:@"ProductId"];
                
                [_arr addObject:ProModel];
            }
            
            
            [self createTableView];
            
        } failureBlock:^(NSString *error) {
    
            NSLog(@"什么鬼？？？？？？");
    
        }];
    
    
    
    ////    预下单
//        NSString *url = @"http://as2.51tgt.com/FyjApp/GetFlowProducts?ssid=TGT23170126536&type=JPY/App/product_info.shtml?pfu_id=1260";
    //
    //
    //
    //    NSString *str = @"busicd=PAUT&charset=utf-8&chcd=WXP&inscd=10130001&mchntid=100000000000203& orderNum=1481008356321&signType=SHA256&terminalid=T01&txamt=000000000 001&txndir=Q&version=2.1zsdfyreuoyamdphhaweyrjbvzkgfdycs";
    //
    //    str = [str SHA256];
    //
    //
    //    NSDictionary *dict =@{
    //                          @"txndir":@"Q",
    //                          @"busicd":@"PAUT",
    //                          @"chcd":@"WXP",
    //                          @"inscd":@"10130001",
    //                          @"charset":@"utf-8",
    //                          @"mchntid":@"100000000000203",
    //                          @"signType":@"SHA256",
    //                          @"terminalid":@"T01",
    //                          @"txamt":@"000000000001",
    //                          @"orderNum":@"1481006881300",
    //                          @"version":@"2.1",
    //                          @"sign":str
    //
    //                          };
    //
    //
    //
    //
//        [NetWork PostNetWorkWithUrl:url parameters:nil hudView:self.view successBlock:^(id data) {
//    
//            NSDictionary *dic = (NSDictionary *)data;
////            NSString *str = dic[@"errorDetail"];
////            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"data====%@",dic);
////            NSLog(@"data2====%@",str);
//            
//        } failureBlock:^(NSString *error) {
//            
//             NSLog(@"什么鬼？？？？？？");
//            
//        }];
    
    
    



}


#pragma mark - 创建标题栏
-(void)HeadTitle{
    UIView *_TitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, XScreenWidth, 60)];
    
    _TitleView.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:84.0/255.0 blue:178.0/255.0 alpha:1];
    
    [self.view addSubview:_TitleView];
    
    UILabel *TitleText = [UILabel new];
    [_TitleView addSubview:TitleText];
    
//    NSArray *langArr2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
//    NSString *language2 = langArr2.firstObject;

   
//    NSString *path = [[NSBundle mainBundle] pathForResource:language2 ofType:@"lproj"];
    
    

    TitleText.text = SetLange(@"title");
//    TitleText.text = NSLocalizedString(@"title", nil);
    
    
    TitleText.textColor = [UIColor whiteColor];
    
    [TitleText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(_TitleView);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    TitleText.textAlignment = 1;
}


#pragma mark - 创建tablewview
-(void)createTableView{
    [MBProgressHUD hideActivityIndicator];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20+60, XScreenWidth, XScreenHeight-40-64-25) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.rowHeight = 270;
    
    [self.view addSubview:_tableView];
    
//    _arr = @[@"100M/天",@"200M/天",@"100M/时",@"200M/时"];
    
    


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTabCell *cell = [ShopTabCell CellWithtable:tableView];
    
    
//    cell.textLabel.text = _arr[indexPath.row];
    cell.model = _arr[indexPath.row];
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopTabCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //   点击闪一闪
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

  
     DetailVc *vc = [[DetailVc alloc]init];
    
    vc.DetailUrl =  ((ProductMo *)_arr[indexPath.row]).url;
    vc.DetailTitle =  ((ProductMo *)_arr[indexPath.row]).title;
    vc.type =  ((ProductMo *)_arr[indexPath.row]).price_type;
    vc.price = [NSString stringWithFormat:@"%@",[NSNumber numberWithInteger:cell.model.price]];
    
    [self.navigationController pushViewController:vc animated:YES];

    
}


-(void)payPal{
//    配置支付环境
    
    
    /// 真实交易环境-也就是上架之后的环境
    extern NSString * _Nonnull const PayPalEnvironmentProduction;
    /// 模拟环境-也就是沙盒环境
    extern NSString * _Nonnull const PayPalEnvironmentSandbox;
    /// 无网络连接环境-具体用处，咳咳，自行摸索
    extern NSString * _Nonnull const PayPalEnvironmentNoNetwork;
    

    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
    
    
    
    
    //是否接受信用卡
    _payPalConfig.acceptCreditCards = YES;
    
    //商家名称
    _payPalConfig.merchantName = @"商家名";
    
    //商家隐私协议网址和用户授权网址-说实话这个没用到
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    //设置地址选项-在支付页面可选择账户地址信息
    typedef NS_ENUM(NSInteger, PayPalShippingAddressOption) {
        //不展示地址信息 选这个好像支付不成功
        PayPalShippingAddressOptionNone = 0,
        //这个没试过，自行查阅
        PayPalShippingAddressOptionProvided = 1,
        //paypal账号下的地址信息
        PayPalShippingAddressOptionPayPal = 2,
        //全选
        PayPalShippingAddressOptionBoth = 3,
    };
    
    //paypal账号下的地址信息
    _payPalConfig.payPalShippingAddressOption = 2;
    
    //配置语言环境
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
//    配置支付相关信息
    
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    
    //订单总额
    payment.amount = [NSDecimalNumber decimalNumberWithString:@"100"];
    
    //货币类型-RMB是没用的
    payment.currencyCode = @"USD";
    
    //订单描述
    payment.shortDescription = @"100M流量";
    
    
    
  
    
//    第四步：提交订单-最重要也是最简单的一步
 
    
    //生成paypal控制器，并模态出来(push也行)
    //将之前生成的订单信息和paypal配置传进来，并设置订单VC为代理
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment                                                                                            configuration:self.payPalConfig                                                                                                  delegate:self];
    
    //模态展示
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
//    [self.navigationController pushViewController:paymentViewController animated:YES];
    
  
    

}

//监测订单状态

//订单支付完成后回调此方法
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    
//    给你的服务器发送支付成功、支付失败等信息请求。
    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                           options:0
                                                             error:nil];
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];

    
}

//用户取消支付回调此方法
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
}

//向服务器发送一些东西，让服务器验证本次订单有效性
//回调的 PayPalPayment 的 confirmation 属性包含此次订单的状态信息包括校验码，服务器可已通过该校验码验证交易真实性。
//返回数据 - id所对应的就是校验码。
//{
//    client =     {
//        environment = sandbox;
//        "paypal_sdk_version" = "2.14.2";
//        platform = iOS;
//        "product_name" = "PayPal iOS SDK";
//    };
//    response =     {
//        "create_time" = "2016-05-12T03:25:49Z";
//        id = "PAY-6BG56850AF923584SK4Z7PNQ";
//        intent = sale;
//        state = approved;
//    };
//    "response_type" = payment;
//}





- (void)didReceiveMemoryWarning {
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
