//
//  CompartirFacebook.h
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareFacebook : NSObject

+(ShareFacebook *) getInstance;
-(void) postToFacebookText:(NSString *) stringText  foto:(UIImage *) foto urlString:(NSString *) stringURL viewController:(UIViewController *) viewController;

@end
