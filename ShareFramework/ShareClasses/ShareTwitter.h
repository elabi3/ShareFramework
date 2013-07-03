//
//  CompartirTwitter.h
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 @Class ShareTwitter
 @Description clase encargada de establecer la comunicacion con el SocialFramework de Apple concretamente para gestionar el acceso a Twitter
 @Method getInstance
 @Method postToTwitterText
 @Method postToTwitterBackgroundWithAccount
 @Method startObtainingAccounts
 @Method openSettingsTwitter
 @Method getAccounts
 @Method getAccountFromUserName
 **/
@class ACAccount;
@interface ShareTwitter : NSObject 

+(ShareTwitter *) getInstance;

-(void) postToTwitterText:(NSString *) stringText  foto:(UIImage*) foto  urlString:(NSString *) stringURL  viewController:(UIViewController *) viewController;
-(void) postToTwitterBackgroundWithAccount:(ACAccount *) account text:(NSString *)stringText foto:(UIImage *)foto video:(NSString *)video latitud:(NSString *)latitud longitud:(NSString *) longitud urlString:(NSString *)stringURL;
-(void) startObtainingAccounts;


-(void) openSettingsTwitter:(UIViewController *) viewController;


-(NSArray *) getAccounts;
-(ACAccount *) getAccountFromUserName: (NSString *) userName;

@end
