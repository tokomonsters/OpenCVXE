unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ocv.highgui_c,
  ocv.core_c,
  ocv.core.types_c,
  ocv.comp.types,
  ocv.imgproc_c,
  ocv.cls.core,
  ocv.cls.highgui,
  ocv.imgproc.types_c, ocv.comp.View, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ocvView1: TocvView;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var
  lvV:TocvImage;
  image: pIplImage ;
begin
  image:= cvLoadImage('C:\Test image\c02.jpg') ;




 // lvV:=TocvImage.Create(cvLoadImage('C:\Test image\c02.jpg')) as TocvImage;
 // ocvView1.DrawImage(lvV);


 // cvReleaseImage(lvV);
 // lvV:=TocvImage.Create(;
 // lvV.LoadFormFile('C:\Test image\c02.jpg');

  //lvV.IplImage :=  cvLoadImage('C:\Test image\c02.jpg');
 // ocvView1.DrawImage(lvV);
  //lvV.Free;
  //ocvView1.DrawImage(TocvImage(cvLoadImage('C:\Test image\c02.jpg')));
end;

procedure TForm1.Button2Click(Sender: TObject);
Var
  image: pIplImage ;
  M: IMat;
  ii:integer;
begin
  try
    ReportMemoryLeaksOnShutdown := True;
    for ii := 0 to 100 do begin
      image := cvLoadImage('C:\Test image\c02.jpg');
      M := TMat.Create(image);
      M := nil;
     // ocvView1.DrawImage(image);

      showmessage('');
      cvReleaseImage(image);
    end;
  except
    on E: Exception do
      showmessage(E.ClassName+ ': '+ E.Message);
  end;
  showmessage('ok');


end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Mat:IMat;
  image: pIplImage ;
  lvV:TocvImage;
  BMP:TBitmap;
begin
  Mat := imread('C:\Test image\c02.jpg');
  image := cvLoadImage('C:\Test image\c02.jpg');
  lvV:=TocvImage.Create(image) as TocvImage;
  BMP := lvV.AsBitmap;
  if BMP<>nil then begin
   BMP.SaveToFile('C:\Test image\c02.bmp');
  end;
  BMP.Free;
  lvV.Free;
  image := nil;
 // ocvView1.DrawImage(lvV);


end;

procedure TForm1.Button4Click(Sender: TObject);
var
  sor_th,dst_th: pIplImage;
  lvV:TocvImage;
   BMP:TBitmap;
begin
  sor_th := cvLoadImage('C:\Test image\r2.jpg',CV_LOAD_IMAGE_GRAYSCALE);
  dst_th := cvCreateImage(cvGetSize(sor_th), IPL_DEPTH_8U, 1);
 // dst_th := cvCreateImage(cvSize(sor_th.width,sor_th.height),sor_th.depth,sor_th.nChannels);
 //以下示範threshold()的用法，將灰階值小於150的設為0，大於150的設為255：
  //cvThreshold(sor_th, dst_th, 90, 255, CV_THRESH_BINARY);
  cvAdaptiveThreshold(sor_th, dst_th, 255, CV_ADAPTIVE_THRESH_GAUSSIAN_C, CV_THRESH_BINARY, 101, 0);
  lvV:=TocvImage.Create(dst_th) as TocvImage;
  ocvView1.DrawImage(lvV);
  BMP :=  lvV.AsBitmap;
  if BMP<>nil then begin
   BMP.SaveToFile('C:\Test image\result.bmp');
   BMP.Free;
  end;
    // grayImage = cvCreateImage(cvGetSize(image), IPL_DEPTH_8U, 1);//1代表灰階圖
 // cvReleaseImage(dst_th);
end;

procedure TForm1.Button5Click(Sender: TObject);
const
  filename = 'C:\Test image\r2.jpg';
  SaveFN = 'C:\Test image\Save.jpg';
  SaveFN2 = 'C:\Test image\Save2.jpg';
var
  src: pIplImage ;
  dst: pIplImage ;
  dst2: pIplImage;
  AcvRect:TcvRect;

begin
  try
    // 瀁鋹欑樦 罻貗鴈膧
    src := cvLoadImage(filename, CV_LOAD_IMAGE_GRAYSCALE);
   // showmessage(Format('[i] image: %s', [filename]));
    // 瀁罻緪?鳿鍕譇緪膻?    cvNamedWindow('original', CV_WINDOW_AUTOSIZE);
    cvShowImage('original', src);
    dst := cvCreateImage(cvSize(src^.width, src^.height), IPL_DEPTH_8U, 1);
    dst2 := cvCreateImage(cvSize(src^.width, src^.height), IPL_DEPTH_8U, 1);

    cvThreshold(src, dst, 150, 255, CV_THRESH_BINARY);
    cvAdaptiveThreshold(src, dst2, 255, CV_ADAPTIVE_THRESH_GAUSSIAN_C, CV_THRESH_BINARY, 155, 1);


    cvNamedWindow('cvThreshold', CV_WINDOW_AUTOSIZE);
    cvShowImage('cvThreshold', dst);
   // cvSaveImage(SaveFN ,dst);


    cvNamedWindow('cvAdaptiveThreshold', CV_WINDOW_AUTOSIZE);
    cvShowImage('cvAdaptiveThreshold', dst2);
       // cvSetImageROI(dst2,  cvRect(20,0,0,0) );
        cvSetImageROI(dst2, ocv.core.types_c.cvRect(0,0,dst2.width,200));
        cvSetZero(dst2);
        cvResetImageROI(dst2);

        cvSetImageROI(dst2, ocv.core.types_c.cvRect(0,370,dst2.width,dst2.height));
        cvSetZero(dst2);
        cvResetImageROI(dst2);




        cvSaveImage(SaveFN ,dst2);
        cvSetImageROI(dst, ocv.core.types_c.cvRect(0,0,dst.width,200));
        cvSetZero(dst);
        cvResetImageROI(dst);

        cvSetImageROI(dst, ocv.core.types_c.cvRect(0,370,dst.width,dst2.height));
        cvSetZero(dst);
        cvResetImageROI(dst);




        cvSaveImage(SaveFN2 ,dst);

    // 緛賄 縺糈蠂 膹飶儑?
   // cvWaitKey(0);

    // 蟃碭搿緛馲?謥c鶇c?
    cvReleaseImage(src);
    cvReleaseImage(dst);
    cvReleaseImage(dst2);
    // 鵫鳪樦 鍧縺
    cvDestroyAllWindows;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end;

end.
