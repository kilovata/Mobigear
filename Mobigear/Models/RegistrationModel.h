//
//  RegistrationModel.h
//  Mobigear
//
//  Created by Sveta Kilovata on 06/04/15.
//  Copyright (c) 2015 kilovata. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RegistrationModelDelegate <NSObject>

- (void)registrationDidComplete;
- (void)registrationDidFail;

@end

@interface RegistrationModel : NSObject

@property (weak, nonatomic) id<RegistrationModelDelegate> delegate;

- (void)registrationWithFio:(NSString*)strFio andEmail:(NSString*)strEmail andPhone:(NSString*)strPhone andPassword:(NSString*)strPassword;

@end
