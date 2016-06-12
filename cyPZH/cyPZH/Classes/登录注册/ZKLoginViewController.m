//
//  ZKLoginViewController.m
//  yjPingTai
//
//  Created by 王小腊 on 16/4/7.
//  Copyright © 2016年 WangXiaoLa. All rights reserved.
//

#import "ZKLoginViewController.h"


@interface ZKLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextFleld;
@property (weak, nonatomic) IBOutlet UITextField *passwordFleld;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *submitClick;

@property (strong, nonatomic)  NSCharacterSet *nameCharacters;
@property (weak, nonatomic) IBOutlet UIButton *accButton;
@property (weak, nonatomic) IBOutlet UIButton *passButton;


@end

static NSString *account_H = @"people_1";
static NSString *account_D = @"people_0";

static NSString *password_H = @"password_1";
static NSString *password_D = @"password_0";


@implementation ZKLoginViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.backView.layer.borderColor = RGB(204, 204, 204).CGColor;
    self.backView.layer.borderWidth = 0.5;
    self.passwordFleld.delegate = self;
    self.accountTextFleld.delegate = self;
    
    _submitClick.userInteractionEnabled = NO;
    
    self.accountTextFleld.returnKeyType =UIReturnKeyDone;
    
    //输入框中叉号编辑时出现
    self.accountTextFleld.clearButtonMode =UITextFieldViewModeWhileEditing;
    
    //输入框中叉号编辑时出现
    self.passwordFleld.clearButtonMode =UITextFieldViewModeWhileEditing;
    //再次编辑就清空
    self.passwordFleld.clearsOnBeginEditing =YES;
    self.passwordFleld.returnKeyType =UIReturnKeyDone;
    
    /* 添加通知  */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passtextFieldChanged:) name:UITextFieldTextDidChangeNotification object:_passwordFleld];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accttextFieldChanged:) name:UITextFieldTextDidChangeNotification object:_accountTextFleld];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


        

        

    
    
    
}

- (IBAction)submitClick:(id)sender {
    
    
    
    if ([[_accountTextFleld.text lowercaseString] isEqualToString:@"slyj"]) {
        
        if ([_passwordFleld.text isEqualToString:@"86702950"]) {
            
            
            [self tap];
            [self sender];
            //判断上架没

            
            
            
        }else{
            
            if (_passwordFleld.text.length ==0) {
                

                [SVProgressHUD showInfoWithStatus:@"请输入密码"];
                
            }else{
                
                [SVProgressHUD showInfoWithStatus:@"您输入的密码错误"];
                _passwordFleld.text = @"";
                [self modifyThe:_passwordFleld];
                
            }
            
            
        }
        
        
    }else{
        
        if (_accountTextFleld.text.length ==0) {
            
             [SVProgressHUD showInfoWithStatus:@"请输入账号"];

        }else{
            
             [SVProgressHUD showInfoWithStatus:@"您输入的密码错误"];

            _passwordFleld.text = @"";
            [self modifyThe:_passwordFleld];
            
        }
        
        
    }
    
    
}
#pragma mark --textFiledDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


//键盘下去
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.view.center = CGPointMake(_SCREEN_WIDTH/2, _SCREEN_HEIGHT/2);
    }];
    
    
}
//键盘起来
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self modifyThe:_passwordFleld];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        
        self.view.center = CGPointMake(_SCREEN_WIDTH/2, _SCREEN_HEIGHT/2-90);
        
    }];
    
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;
{
    
    [self modifyThe:textField];
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self tap];
}

/**
 *  取消键盘
 */
-(void)tap
{
    [_accountTextFleld   resignFirstResponder];
    [_passwordFleld   resignFirstResponder];
    
}

- (void)passtextFieldChanged:(id)sender
{
    [self modifyThe:_passwordFleld];
}
- (void)accttextFieldChanged:(id)sender
{
    [self modifyThe:_accountTextFleld];
    
}

/**
 *  修改界面
 *
 *  @param textField
 */
- (void)modifyThe:(UITextField*)textField
{
    
    if (textField.tag == 1000) {
        
        _accButton.imageView.image = _accountTextFleld.text.length> 0 ? [UIImage imageNamed:account_H]:[UIImage imageNamed:account_D];
        
    }
    else
    {
        
        _passButton.imageView.image = _passwordFleld.text.length > 0 ? [UIImage imageNamed:password_H]:[UIImage imageNamed:password_D];
        
        
    }
    
    _submitClick.backgroundColor = _passwordFleld.text.length> 0 &&_accountTextFleld.text.length> 0
    ?CYBColorGreen :RGB(93, 183, 126);
    _submitClick.userInteractionEnabled = _passwordFleld.text.length > 0 &&_accountTextFleld.text.length > 0 ? YES : NO ;
    
}
/**
 *  创建视图
 */
- (void)initController
{
    [self successful];


 
}
/**
 *  正在登录
 */
- (void)sender{
    
    _submitClick.backgroundColor = RGB(93, 183, 126);
    _submitClick.userInteractionEnabled = NO;
    [SVProgressHUD showWithStatus:@"正在登录..."];
}
/**
 *  已经登陆成功
 */
- (void)successful
{
    
    _submitClick.backgroundColor = CYBColorGreen ;
    _submitClick.userInteractionEnabled = YES  ;
    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

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
