//
//  PrincipalViewController.m
//  MenuContextual
//
//  Created by Rafael Brigagão Paulino on 26/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()

-(void)mudarParaAmarelo;
-(void)mudarParaPreto;
-(void)mudarParaBranco;

@end

@implementation PrincipalViewController

//por padrao, o view controller nao pode ser firstRespodeer, porém se ele nao for, nao poderemos fazer o menu aparecer
//portanto permitiremos atraves do metoso abaixo que ele possa ser um first responder
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

//meotodo acionado quando a tela perde o foco
-(BOOL)resignFirstResponder
{
   //sempre quando a tela perder o foco, ou seja, o menu personalizado sumir, iremos retirar todos os botoes que tinhamos colocado dentro do menu
    [super resignFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    [menu setMenuItems:nil];
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //o menu que aparece é um singleton, ou seja, existe apenas uma instancia dele para aparecer em todos os lugares
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible)
    {
        [menu setMenuVisible:NO animated:YES];
    }
    else
    {
        UITouch *toque = [touches anyObject];
        
        CGPoint toqueNaTela = [toque locationInView:self.view];
        
        //criar os botoes que irao aparecer no menu
        UIMenuItem *btn1 = [[UIMenuItem alloc] initWithTitle:@"Amarelo" action:@selector(mudarParaAmarelo)];
        UIMenuItem *btn2 = [[UIMenuItem alloc] initWithTitle:@"Preto" action:@selector(mudarParaPreto)];
        UIMenuItem *btn3 = [[UIMenuItem alloc] initWithTitle:@"Branco" action:@selector(mudarParaBranco)];
        
        NSArray *arrayBotoes = [NSArray arrayWithObjects:btn1,btn2,btn3, nil];
        
        [menu setMenuItems:arrayBotoes];
        
        //para o menu aparecer, precisamos setar o VC como o sendo o foco
        [self becomeFirstResponder];
        
        //indicar onde o menu vai parecer
        [menu setTargetRect:CGRectMake(toqueNaTela.x, toqueNaTela.y, 1, 1) inView:self.view];
        
        //caso queira mudar a direcao da seta
        //[menu setArrowDirection:UIMenuControllerArrowRight];
        
        [menu setMenuVisible:YES animated:YES];
    }
    
}

-(void)mudarParaAmarelo
{
    self.view.backgroundColor = [UIColor yellowColor];
}
-(void)mudarParaPreto
{
   self.view.backgroundColor = [UIColor blackColor];
}
-(void)mudarParaBranco
{
   self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
