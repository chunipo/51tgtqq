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
    

    
    [self.contentView addSubview:_imageView];
 
    
}



-(void)setModel:(ProductMo *)model{
    _model = model;
    
    NSString *str = [PicHead stringByAppendingString:model.cover_image_url];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"#我在shopcell里#商城的图片加载完成思密达");
    }];
    
    
    _imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width*4/7, 100);
    
    
    
    

}





@end
