//
//  YYProductSearchBar.m
//  mocha
//
//  Created by CAT on 14-3-5.
//  Copyright (c) 2014年 yunyao. All rights reserved.
//

#import "YYSearchBar.h"

@implementation YYSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.keyboardType = UIKeyboardTypeEmailAddress;
        [self setImage:[UIImage imageNamed:@"nav_icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        
        self.barTintColor = [UIColor whiteColor];
        self.searchBarStyle = UISearchBarStyleMinimal;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //删除iOS6下的背景
    for(UIView *view in self.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [view removeFromSuperview];
        }
    }
    
    //查找field
    UITextField *searchField = nil;
    for(UIView *view in self.subviews) {
        if([view isKindOfClass:[UITextField class]]){
            searchField = (UITextField *)view;
            break;
        }
    }
    if(searchField == nil){
        //ios7需要再循环一次
        for(UIView *subView in self.subviews){
            for(UIView *subSubView in subView.subviews){
                if([subSubView isKindOfClass:[UITextField class]]){
                    searchField = (UITextField *)subSubView;
                    break;
                }
            }
            if(searchField){
                break;
            }
        }
    }
    
    searchField.background = nil;
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.textColor = [UIColor colorWithWhite:0x55/255.0 alpha:1];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.layer.masksToBounds = YES;
    searchField.layer.cornerRadius = searchField.frame.size.height/2.f;
    searchField.font = [UIFont systemFontOfSize:13];
    //placeholder
    NSMutableAttributedString *attributedPlaceholder;
    if (self.placeString) {
        attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:self.placeString];
    }else{
        attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"输入关键字查询"];
    }
    [attributedPlaceholder addAttribute:(NSString*)NSForegroundColorAttributeName value:YJCorl(180, 180, 180) range:NSMakeRange(0, attributedPlaceholder.length)];
    searchField.attributedPlaceholder = attributedPlaceholder;
}

@end
