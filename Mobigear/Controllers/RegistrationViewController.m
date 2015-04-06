//
//  RegistrationViewController.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "RegistrationViewController.h"
#import "RegistrationModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ArticlesViewController.h"

@interface RegistrationViewController ()<RegistrationModelDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldFio;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegistration;

@property (strong, nonatomic) RegistrationModel *registrationModel;

- (IBAction)registration;

@end


@implementation RegistrationViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.buttonRegistration.layer.borderWidth = 1.f;
    self.buttonRegistration.layer.cornerRadius = 4.f;
    self.buttonRegistration.layer.borderColor = [UIColor colorWithRed:0 green:122.f/255.f blue:1.f alpha:1.f].CGColor;
}


- (IBAction)registration {
    
    if (!self.registrationModel) {
        self.registrationModel = [RegistrationModel new];
        self.registrationModel.delegate = self;
    }
    
    if (self.textFieldFio.text.length > 0 && self.textFieldEmail.text.length > 0 &&
        self.textFieldPhone.text.length > 0 && self.textFieldPassword.text.length > 0) {
        [self.registrationModel registrationWithFio:self.textFieldFio.text andEmail:self.textFieldEmail.text andPhone:self.textFieldPhone.text andPassword:self.textFieldPassword.text];
    } else {
        [SVProgressHUD showErrorWithStatus:@"Заполните все поля"];
    }
}


#pragma mark - RegistrationModelDelegate
- (void)registrationDidComplete {
    
    [self.navigationController setViewControllers:@[[ArticlesViewController new]]];
}


- (void)registrationDidFail {
    
    [SVProgressHUD showErrorWithStatus:@"Ошибка регистрации"];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
