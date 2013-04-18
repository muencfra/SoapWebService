//
//  FMSWSViewController.m
//  SoapWebService
//
//  Created by Frank Muenchow on 18.04.13.
//  Copyright (c) 2013 Frank Muenchow. All rights reserved.
//

/*
 POST /Service1.asmx HTTP/1.1
 Host: webservice.jimmix-media.de
 Content-Type: text/xml; charset=utf-8
 Content-Length: length
 SOAPAction: "http://it34/TermineDS"
 
 <?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
 <soap:Body>
 <TermineDS xmlns="http://it34/" />
 </soap:Body>
 </soap:Envelope>
 */

#import "FMSWSViewController.h"

@interface FMSWSViewController ()

@end

@implementation FMSWSViewController

@synthesize connection;
@synthesize data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
[self callWebService];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callWebService{
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\n<soap12:Body>\n<TermineDS xmlns=\"http://it34\" />\n</soap12:Body>\n</soap12:Envelope>\n"];
    
    NSURL *url = [NSURL URLWithString:@"http://webservice.jimmix-media.de/Service1.asmx"];
    
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
    
    [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Lenght"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest addValue:@"webservice.jimmix-media.de" forHTTPHeaderField:@"jimmix-media"];
    [theRequest addValue:@"http://tempuri.org/function" forHTTPHeaderField:@"http://it34/TermineDS"];
    [theRequest addValue: @"http://it34/TermineDS" forHTTPHeaderField:@"SOAPAction"];
    [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData
{
    if (data == nil) data = [[NSMutableData alloc] initWithCapacity:2048];
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    
    if(data)
    {
        NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",strData);
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] init];
        //[alert setTitle:@"Termin speichern"];
        [alert setMessage:@"Keine Internetverbindung"];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
    
    data = nil;
    connection = nil;
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSString *errorMessage = [error.localizedDescription stringByAppendingString:@"\nWebserice nicht erreichbar."];
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Keine Internetverbindung"];
    [alert setMessage:errorMessage];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"OK"];
    [alert show];
    
}


@end
