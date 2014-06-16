//
//  JW2013ViewController.m
//  hackpress-ios-client
//
//  Created by Zhe Wang on 6/14/14.
//  Copyright (c) 2014 jw2013. All rights reserved.
//

#import "JW2013ViewController.h"

@interface JW2013ViewController ()

- (void)requestDataAndUpateView:(NSString*)url;
- (void)updateWebView:(NSDictionary*)json;
@end

@implementation JW2013ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self requestDataAndUpateView:@"http://hackxpress.herokuapp.com/question/random.json"];
}

- (void)requestDataAndUpateView:(NSString*)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               __block NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:nil];
                               [self updateWebView:json];
                           }];
}

- (void)updateWebView:(NSDictionary*)json
{
    NSMutableString *html = [NSMutableString stringWithString: @""];
    [html appendString: @"<h2>"];
    [html appendString: json[@"title"]];
    [html appendString: @"</h2>"];
    [html appendString: @"<div>"];
    [html appendString: json[@"content"]];
    [html appendString: @"</div>"];
    [html appendString: @"<h2>Answer:</h2>"];
    [html appendString: @"<div>"];
    [html appendString: json[@"answer"]];
    [html appendString: @"</div>"];
    [self.HtmlView loadHTMLString:[html description] baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed {
    [self requestDataAndUpateView:@"http://hackxpress.herokuapp.com/question/random.json"];
}
@end
