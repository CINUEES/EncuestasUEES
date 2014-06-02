//
//  ueesControllerCrearEncuestas.h
//  Aplicacion de encuestas
//
//  Created by Centro de Investigaciones on 14/11/13.
//  Copyright (c) 2013 Centro de Investigaciones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ueesControllerCrearEncuestas : UIViewController<UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


//Variables Generales de creación de encuestas
@property NSString *nombre_enc;
@property NSString *descrip_enc;
@property int tema_enc;
@property NSString *msj_inicio_enc;
@property NSString *msj_fin_enc;
@property NSArray *tipos_preg_enc;
@property int num_pregunta_enc;


@property (nonatomic,weak) IBOutlet UIView *viewInicial;
@property (nonatomic,weak) IBOutlet UILabel *numPregLB;
@property (nonatomic,weak) IBOutlet UIPickerView *tipoPregunta;
@property (nonatomic,weak) IBOutlet UIButton *nuevoElemento;
@property (nonatomic,weak) IBOutlet UIButton *pregAnterior;
@property (nonatomic,weak) IBOutlet UIButton *pregSiguiente;
@property (nonatomic,weak) IBOutlet UIButton *finalizarEncuesta;

@property NSString *titulo;
@property NSString *numPregunta;
@property UIColor *color;


#pragma mark - texto

@property (nonatomic,weak) IBOutlet UIView *viewTexto;
@property (nonatomic,weak) IBOutlet UITextField *tituloPreg;
@property (nonatomic,weak) IBOutlet UITextField *hintPreg;
@property (nonatomic,weak) IBOutlet UISegmentedControl *obligatoria;


#pragma mark - texto párrafo

@property (nonatomic,weak) IBOutlet UIView *viewTextoP;
@property (nonatomic,weak) IBOutlet UITextField *tituloPregP;
@property (nonatomic,weak) IBOutlet UITextField *hintPregP;
@property (nonatomic,weak) IBOutlet UITextView *respuestaP;
@property (nonatomic,weak) IBOutlet UISegmentedControl *obligatoriaP;


#pragma mark - Lista

@property (nonatomic,weak) IBOutlet UIView *viewLista;
@property (nonatomic,weak) IBOutlet UIButton *anadir;
@property (nonatomic,weak) IBOutlet UITextField *tituloPregL;
@property (nonatomic,weak) IBOutlet UITextField *hintPregL;
@property (nonatomic,weak) IBOutlet UITextField *resp1L;
@property (nonatomic,weak) IBOutlet UITextField *resp2L;
@property (nonatomic,weak) IBOutlet UITextField *resp3L;
@property (nonatomic,weak) IBOutlet UITextField *resp4L;
@property (nonatomic,weak) IBOutlet UITextField *resp5L;
@property (nonatomic,weak) IBOutlet UITextField *resp6L;
@property (nonatomic,weak) IBOutlet UITextField *resp7L;
@property (nonatomic,weak) IBOutlet UITextField *resp8L;
@property (nonatomic,weak) IBOutlet UITextField *resp9L;
@property (nonatomic,weak) IBOutlet UITextField *resp10L;
@property (nonatomic,weak) IBOutlet UITextField *resp11L;
@property (nonatomic,weak) IBOutlet UILabel *resp1LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp2LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp3LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp4LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp5LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp6LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp7LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp8LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp9LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp10LBL;
@property (nonatomic,weak) IBOutlet UILabel *resp11LBL;
@property (nonatomic,weak) IBOutlet UISegmentedControl *obligatoriaL;

@end
