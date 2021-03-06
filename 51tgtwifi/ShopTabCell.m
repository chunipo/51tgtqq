//
//  ShopTabCell.m
//  51tgtwifi
//
//  Created by TGT on 2017/10/27.
//  Copyright © 2017年 weiyuxiang. All rights reserved.
//

#import "ShopTabCell.h"
#import "ProductMo.h"

#define PicHead  @"http://as2.51tgt.com"

@interface ShopTabCell ()
{
    UIImageView  *_imageView;
    UILabel      *_title;
    UILabel      *_type;
    UILabel      *_price;
}
@end

@implementation ShopTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(instancetype)CellWithtable:(UITableView *)table{
    static NSString *ID = @"id";
    
    ShopTabCell *cell = [table dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ShopTabCell alloc]initWithStyle:0 reuseIdentifier:ID];
        
        [cell addsubviews];
    }
    
    return cell;
    
    
}

-(void)addsubviews{
    _imageView = [[UIImageView alloc]init];
    
    _title = [[UILabel alloc]init];
    _type = [[UILabel alloc]init];
    _price = [[UILabel alloc]init];
    

    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_type];
    [self.contentView addSubview:_price];
    
    
    
 
    
}



-(void)setModel:(ProductMo *)model{
    _model = model;
    
    NSString *str = [PicHead stringByAppendingString:model.cover_image_url];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"#我在shopcell里#商城的图片加载完成思密达");
    }];
    
    _title.text = [model.title stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    _type.text = model.price_type;
//
    _price.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:model.price]];
    
    
    
    _imageView.frame = CGRectMake(0, 0, XScreenWidth, 200);
    
    _title.frame = CGRectMake(10,_imageView.maxY+ 10, XScreenWidth/2, 50);
    _title.numberOfLines = 0;
    
    
   
//
    _type.frame = CGRectMake(XScreenWidth-120, _title.y, 40, 30);
    _price.frame = CGRectMake(_type.maxX+2, _type.y, 60, 30);
    
    
    
    _title.textColor = [UIColor blackColor];
    _type.textColor = [UIColor blueColor];
    _price.textColor = [UIColor blueColor];
    
    _title.font = [UIFont systemFontOfSize:19];
    _price.font = [UIFont systemFontOfSize:22];
}





@end
