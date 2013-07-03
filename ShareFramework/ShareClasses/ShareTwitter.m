//
//  CompartirTwitter.m
//  webTablon
//
//  Created by Laboratorio Ingeniería Software on 26/11/12.
//  Copyright (c) 2012 Laboratorio Ingeniería Software. All rights reserved.
//

#import "ShareTwitter.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

static ShareTwitter *instance;
static NSArray *arrayOfAccounts;

@implementation ShareTwitter

+(ShareTwitter *) getInstance {
    if (instance == nil) {
        instance = [[ShareTwitter alloc] init];
    }
    return instance;
}

-(NSArray *) getAccounts {
    return arrayOfAccounts;
}

-(void) postToTwitterText:(NSString *) stringText  foto:(UIImage*) foto  urlString:(NSString *) stringURL  viewController:(UIViewController *) viewController {
    // Creamos la ventana de envio del tweet
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // Establecemos parametros de la ventana
    if (stringText) {
        [composeController setInitialText:stringText];
    }
    
    if (foto) {
        [composeController addImage:foto];
    }
    
    if (stringURL) {
        [composeController addURL: [NSURL URLWithString:stringURL]];
    }

    // Abrimos la ventana de envio sobre el viewController indicado para ese proposito
    [viewController presentViewController:composeController animated:YES completion:nil];
}

-(void) postToTwitterBackgroundWithAccount:(ACAccount *) account text:(NSString *)stringText foto:(UIImage *)foto video:(NSString *)video latitud:(NSString *)latitud longitud:(NSString *) longitud urlString:(NSString *)stringURL {
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    typedef void (^AccountReturnBlock) (BOOL, NSError *);
        
    // Bloque que se ejecuta si hemos accedido a la cuenta de Twitter del sistema
    AccountReturnBlock resultblock = ^(BOOL granted, NSError *error) {
        if (granted == YES) { //tenemos acceso a las cuentas de Twitter configuradas en el sistema
            NSArray *arrayOfAccounts = [accountStore accountsWithAccountType:accountType]; // iniciamos el array con todas las cuentas disponibles
            
            if ([arrayOfAccounts count] > 0) { // comprobamos que al menos ubiera una cuenta
                BOOL encontrada = NO;
            
                for (ACAccount *acc in arrayOfAccounts) { // buscamos la cuenta desde la que queremos enviar para comprobar que aun esta configurada
                    if ([account.identifier isEqualToString:acc.identifier]) {
                        encontrada = YES;
                        // Preparamos el mensaje
                        NSDictionary *message = [self createMessageWithText:stringText latitud:latitud longitud:longitud urlString:stringURL];
                        // Preparamos el request y enviamos el tweet
                        [self sendTweetWithAccount:acc message:message foto:foto];
                        break;
                    }
                }
                
                if (!encontrada) { // Lanzamos error si no la hemos encontrado entre las del sistema
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"AlertViewTwitterTitle", nil) message:NSLocalizedString(@"AlertViewTwitterMessage", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"AlertViewTwitterAccept", nil) otherButtonTitles:nil, nil];
                    [alert show];
                }

            }
            
        }
    };
    
    // Acceso a la cuenta de Twitter configurada en el sistema (esto ejecuta al bloque declarado arriba)
    [accountStore requestAccessToAccountsWithType:accountType options:nil
                                  completion:resultblock];
}

-(NSDictionary *) createMessageWithText:(NSString *) stringText latitud:(NSString *)latitud longitud:(NSString *)longitud urlString:(NSString *)stringURL {
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    
    if (stringText) {
        [dictionary setObject:stringText forKey:@"status"];
    }
    
    if (stringURL) {
        
    }
    
    if (latitud && longitud) {
        [dictionary setObject:latitud forKey:@"lat"];
        [dictionary setObject:longitud forKey:@"long"];
        
        [dictionary setObject:@"true" forKey:@"display_coordinates"];
    }
    
    return [[NSDictionary alloc] initWithDictionary:dictionary];
}


-(void) sendTweetWithAccount:(ACAccount *) account  message:(NSDictionary *) message  foto:(UIImage *) foto {
    // Establecemos la url a la que se enviara el mensaje
    NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/update.json"];
    
    if (foto) {// Si hay foto cambiamos la url
        requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update_with_media.json"];
    }
    
    // Creamos el request que haremos a twitter
    SLRequest *postRequest = [SLRequest
                              requestForServiceType:SLServiceTypeTwitter
                              requestMethod:SLRequestMethodPOST
                              URL:requestURL parameters:message];
    
    // indicamos la cuenta desde la que enviamos el mensaje al request
    postRequest.account = account;
    
    // Si hay foto la adjuntamos
    if (foto) {
        // Pasamos la foto a NSData (binario)
        NSData *imageData = UIImageJPEGRepresentation(foto, 1);
        // Añadimos la foto al request
        [postRequest addMultipartData:imageData withName:@"media[]" type:@"multipart/form-data" filename:@"fileName"];
    }
    
    // Enviamos la petion a twitter 
    [postRequest performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse, NSError *error) { // Codigo que ejecuta al terminar el envio
        //NSLog(@"Twitter HTTP response: %i", [urlResponse statusCode]);
        //NSLog(@"Error: %@", [urlResponse allHeaderFields]);
    }];
}

-(void) startObtainingAccounts {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    typedef void (^AccountReturnBlock) (BOOL, NSError *);
    
    // Bloque que se ejecuta si hemos accedido a la cuenta de Twitter del sistema
    AccountReturnBlock resultblock = ^(BOOL granted, NSError *error) {
        if (granted == YES) {
            arrayOfAccounts = [account accountsWithAccountType:accountType];
            // Enviamos una notificacion de que ya se han consultado las cuentas del sistema, ya que esta operacion suele ser lenta
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ArrayOfAccounts" object:nil];
        }
    };
    
    // Acceso a la cuenta de Twitter configurada en el sistema
    [account requestAccessToAccountsWithType:accountType options:nil
                                  completion:resultblock];
}

-(ACAccount *) getAccountFromUserName: (NSString *) userName {
    for (ACAccount * account in arrayOfAccounts) {
        if ([account.username isEqualToString:userName]) {
            return account;
        }
    }
    return nil;
}

-(void) openSettingsTwitter:(UIViewController *) viewController {
    // Iniciamos la ventana de envio de un tweet del sistema
    SLComposeViewController *composeController = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    // Eliminadmos las subviews 
    for (UIView *view in [[composeController view] subviews])
        [view removeFromSuperview];
    
    // Hacemos que aparezca sobre el viewController indicado
    [viewController presentViewController:composeController animated:YES completion:nil];
}

@end
