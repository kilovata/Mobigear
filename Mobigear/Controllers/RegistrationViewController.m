//
//  RegistrationViewController.m
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonAuthorization;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

- (IBAction)authorization;

@end


@implementation RegistrationViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.buttonAuthorization.layer.borderWidth = 1.f;
    self.buttonAuthorization.layer.cornerRadius = 4.f;
    self.buttonAuthorization.layer.borderColor = [UIColor colorWithRed:0 green:122.f/255.f blue:1.f alpha:1.f].CGColor;
}


- (IBAction)authorization {
    
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
