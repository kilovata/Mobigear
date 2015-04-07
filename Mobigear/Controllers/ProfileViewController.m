//
//  ProfileViewController.m
//  Mobigear
//
//  Created by kilovata-iMac on 07/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "User.h"

@interface ProfileViewController ()<ProfileModelDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAvatarTop;
@property (weak, nonatomic) IBOutlet UIButton *buttonAvatar;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFio;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpdateProfile;

@property (strong, nonatomic) ProfileModel *profileModel;

- (IBAction)actionUpdateProfile;
- (IBAction)updateAvatar;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.profileModel = [ProfileModel new];
    self.profileModel.delegate = self;
    
    self.buttonUpdateProfile.layer.borderWidth = 1.f;
    self.buttonUpdateProfile.layer.cornerRadius = 4.f;
    self.buttonUpdateProfile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self initProfile];
    [self.profileModel getProfile];
}


- (void)initProfile {
    
    self.textFieldFio.text = [self.profileModel currentUser].fio;
    self.textFieldEmail.text = [self.profileModel currentUser].email;
    self.textFieldPhone.text = [self.profileModel currentUser].phone;
    if ([self.profileModel currentUser].avatar) {
        [self.buttonAvatar sd_setBackgroundImageWithURL:[NSURL URLWithString:[self.profileModel currentUser].avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"avatar"] options:SDWebImageRefreshCached];
    }
}


- (IBAction)actionUpdateProfile {
    
    if (self.textFieldFio.text.length > 0 && self.textFieldEmail.text.length > 0 && self.textFieldPhone.text.length > 0) {
        
        UIImage *originalImage = self.buttonAvatar.imageView.image;
        NSData *dataImage = UIImageJPEGRepresentation (originalImage, 1.f);
        NSString *strBase64 = [dataImage base64EncodedStringWithOptions:0];
        [self.profileModel updateProfileWithFio:self.textFieldFio.text andEmail:self.textFieldEmail.text andPhone:self.textFieldPhone.text andAvatar:strBase64];
    } else {
        [SVProgressHUD showErrorWithStatus:@"Заполните все поля"];
    }
}


- (IBAction)updateAvatar {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *pickerVC = [UIImagePickerController new];
        pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerVC.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        pickerVC.allowsEditing = NO;
        pickerVC.delegate = self;
        [self presentViewController:pickerVC animated:YES completion:nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.buttonAvatar setImage:[info objectForKey:UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
        self.buttonUpdateProfile.enabled = YES;
        self.buttonUpdateProfile.layer.borderColor = [UIColor colorWithRed:0 green:122.f/255.f blue:1.f alpha:1.f].CGColor;
    }];
}


- (BOOL)isChangedTextFields {
    
    if ([self.textFieldFio.text isEqualToString:[self.profileModel currentUser].fio] &&
        [self.textFieldEmail.text isEqualToString:[self.profileModel currentUser].email] &&
        [self.textFieldPhone.text isEqualToString:[self.profileModel currentUser].phone]) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self animationWithConstant:0];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self animationWithConstant:94.f];
    self.buttonUpdateProfile.enabled = [self isChangedTextFields];
    if (self.buttonUpdateProfile.enabled) {
        self.buttonUpdateProfile.layer.borderColor = [UIColor colorWithRed:0 green:122.f/255.f blue:1.f alpha:1.f].CGColor;
    } else {
        self.buttonUpdateProfile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    for (UITextField *curTextField in self.view.subviews) {
        [curTextField resignFirstResponder];
    }
    return YES;
}


#pragma mark -
- (void)animationWithConstant:(CGFloat)value {
    
    [self.textFieldFio.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        self.constraintAvatarTop.constant = value;
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - ProfileModelDelegate
- (void)profileLoadFromServer {
    
    [self initProfile];
}


- (void)profileDidUpdateComplete {
    
    self.buttonUpdateProfile.enabled = NO;
    self.buttonUpdateProfile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [SVProgressHUD showSuccessWithStatus:@"Профиль обновлен"];
}


- (void)profileDidUpdateFail {
    
    [SVProgressHUD showErrorWithStatus:@"Ошибка при обновлении профиля"];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
