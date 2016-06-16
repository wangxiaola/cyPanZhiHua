//
//  ZKSceniceAdvertisementView.m
//  cyPZH
//
//  Created by 王小腊 on 16/6/16.
//  Copyright © 2016年 王小腊. All rights reserved.
//

#import "ZKSceniceAdvertisementView.h"


@implementation ZKSceniceAdvertisementView
{
    
    NSInteger page;
    NSArray *dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray*)array;
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        dataArray = array;
        page = 0;
        [self setBackgroundColor:[UIColor whiteColor]];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        [_scrollView setPagingEnabled:YES];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView setDelegate:self];
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        
        //ContentSize 这个属性对于UIScrollView挺关键的，取决于是否滚动。
        [_scrollView setContentSize:CGSizeMake(frame.size.width* array.count, frame.size.height)];
        [self addSubview:_scrollView];
        
        for (int i = 0; i<array.count; i++)
        {
            NSDictionary *list = array[i];
            UIView *contenView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height)];
            contenView.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:contenView];
            
            
            UILabel *inforLabel = [[UILabel alloc] init];
            inforLabel.textColor = [UIColor grayColor];
            inforLabel.numberOfLines = 2;
            inforLabel.font = [UIFont systemFontOfSize:13];
            inforLabel.textAlignment = NSTextAlignmentLeft;
            inforLabel.text = [list valueForKey:@"info"];
            [contenView addSubview:inforLabel];
            
            [inforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(8);
                make.right.mas_equalTo(-8);
                make.bottom.mas_equalTo(contenView.mas_bottom).offset(-20);
                make.height.mas_equalTo(34);
                
            }];
            
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.textColor = [UIColor orangeColor];
            nameLabel.font = [UIFont systemFontOfSize:13];
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.text = [list valueForKey:@"title"];
            [contenView addSubview:nameLabel];
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(8);
                make.right.mas_greaterThanOrEqualTo(-6);
                make.bottom.mas_equalTo(inforLabel.mas_top).offset(-4);
                make.height.mas_equalTo(16);
                
            }];

            
            UIImageView *baeenImageView = [[UIImageView alloc] init];
            baeenImageView.backgroundColor = [UIColor whiteColor];
            [contenView addSubview:baeenImageView];
            [ZKUtil UIimageView:baeenImageView NSSting:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[list valueForKey:@"img"]] duImage:@"guanggo_ default"];
            baeenImageView.userInteractionEnabled = YES;
            
            
            [baeenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.top.mas_equalTo(0);
                make.bottom.mas_equalTo(nameLabel.mas_top).mas_offset(-4);
            }];
            
            UIButton *bty = [UIButton buttonWithType:UIButtonTypeCustom];
            bty.backgroundColor = [UIColor clearColor];
            [bty addTarget:self action:@selector(tochClick:) forControlEvents:UIControlEventTouchUpInside];
            bty.tag = i;
            [contenView addSubview:bty];
            
            [bty mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.right.top.mas_equalTo(0);
                make.bottom.mas_equalTo(nameLabel.mas_top).mas_offset(-4);
            }];
        }
        

        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height - 20, frame.size.width, 20)];
        [_pageControl setBackgroundColor:[UIColor whiteColor]];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = array.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:_pageControl];
        
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollPages) userInfo:nil repeats:YES];
 
    }
    
    return self;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    page = floor((self.scrollView.contentOffset.x -pageWidth/2)/pageWidth) +1;
    self.pageControl.currentPage = page;
    
  
}

- (void)scrollPages
{
    page ++;
    self.pageControl.currentPage = page;;
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:YES];
    if (page == _pageControl.numberOfPages) {

        page = -1;
    }


}
- (void)tochClick:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(sceleAdvertisement:)]) {
        [self.delegate sceleAdvertisement:dataArray[sender.tag]];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
