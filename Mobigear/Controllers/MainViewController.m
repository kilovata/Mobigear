//
//  MainViewController.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "MainViewController.h"
#import "RegistrationViewController.h"
#import "AuthorizationModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface MainViewController ()<AuthorizationModelDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonAuthorization;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegistration;

@property (strong, nonatomic) AuthorizationModel *authModel;

- (IBAction)authorization;
- (IBAction)registration;


@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.buttonAuthorization.layer.borderWidth = self.buttonRegistration.layer.borderWidth = 1.f;
    self.buttonAuthorization.layer.cornerRadius = self.buttonRegistration.layer.cornerRadius = 4.f;
    self.buttonAuthorization.layer.borderColor = self.buttonRegistration.layer.borderColor = [UIColor colorWithRed:0 green:122.f/255.f blue:1.f alpha:1.f].CGColor;
}


- (IBAction)authorization {

    if (!self.authModel) {
        self.authModel = [AuthorizationModel new];
        self.authModel.delegate = self;
    }
    
    if (self.textFieldEmail.text.length == 0 && self.textFieldPassword.text.length > 0) {
        [SVProgressHUD showErrorWithStatus:@"Введите e-mail"];
    } else if (self.textFieldEmail.text.length > 0 && self.textFieldPassword.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Введите пароль"];
    } else if (self.textFieldEmail.text.length == 0 && self.textFieldPassword.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Введите e-mail и пароль"];
    } else {
        [self.authModel authorizeWithEmail:self.textFieldEmail.text andPassword:self.textFieldPassword.text];
    }
}


- (IBAction)registration {
    
    RegistrationViewController *registrationVC = [RegistrationViewController new];
    [self.navigationController pushViewController:registrationVC animated:YES];
}


#pragma mark - AuthorizationModelDelegate
- (void)authorizationDidComplete {
    
    
}


- (void)authorizationDidFail {
    
    [SVProgressHUD showErrorWithStatus:@"Ошибка авторизация"];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
