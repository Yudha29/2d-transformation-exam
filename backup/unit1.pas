unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, BufDataset, DB, Forms, Controls, Graphics, Dialogs, Math,
  StdCtrls, ColorBox, ExtCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    clearbtn: TButton;
    closebtn: TButton;
    Label21: TLabel;
    drawbtn: TButton;
    translatebtn: TButton;
    scallingbtn: TButton;
    rotasibtn: TButton;
    Compositebtn: TButton;
    p1p1: TCheckBox;
    p3p2: TCheckBox;
    p3p3: TCheckBox;
    p3p4: TCheckBox;
    p4p1: TCheckBox;
    p4p2: TCheckBox;
    p4p3: TCheckBox;
    p4p4: TCheckBox;
    p1p5: TCheckBox;
    p2p5: TCheckBox;
    p3p5: TCheckBox;
    p1p2: TCheckBox;
    p4p5: TCheckBox;
    p5p1: TCheckBox;
    p5p2: TCheckBox;
    p5p3: TCheckBox;
    p5p4: TCheckBox;
    p5p5: TCheckBox;
    pivotcheckbox: TCheckBox;
    p1p3: TCheckBox;
    p1p4: TCheckBox;
    p2p1: TCheckBox;
    p2p2: TCheckBox;
    p2p3: TCheckBox;
    p2p4: TCheckBox;
    p3p1: TCheckBox;
    colorinput: TColorBox;
    Px1Input: TEdit;
    Py5Input: TEdit;
    TxInput: TEdit;
    TyInput: TEdit;
    SxInput: TEdit;
    SyInput: TEdit;
    SudInput: TEdit;
    Py1Input: TEdit;
    Px2Input: TEdit;
    Py2Input: TEdit;
    Px3Input: TEdit;
    Py3Input: TEdit;
    Px4Input: TEdit;
    Py4Input: TEdit;
    Px5Input: TEdit;
    canvas1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ScrollBox1: TScrollBox;
    procedure clearbtnClick(Sender: TObject);
    procedure closebtnClick(Sender: TObject);
    procedure CompositebtnClick(Sender: TObject);
    procedure drawbtnClick(Sender: TObject);
    procedure rotasibtnClick(Sender: TObject);
    procedure scallingbtnClick(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure translatebtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure initCanvas();
    procedure scale(Sx, Sy : Double);

  private

  public

  end;

var
  Form1: TForm1;

implementation


{$R *.lfm}

{ TForm1 }
 var
    temp : double;
    tinggi, lebar, kolomP, barisP : Integer;
    px : array[1..1000] of double;
    py : array[1..1000] of double;
    tpx : array[1..1000] of double;
    tpy : array[1..1000] of double;
    arah : array[1..1000,1..1000] of boolean;

procedure TForm1.FormShow(Sender: TObject);
begin
     tinggi := canvas1.Height;
     lebar  := canvas1.Width;
     kolomP := lebar div 2;
     barisP := tinggi div 2;
     initCanvas();
end;

procedure TForm1.initCanvas();
begin
     canvas1.Canvas.pen.color := clWhite;
     canvas1.Canvas.pen.Style := psSolid;
     canvas1.Canvas.Brush.color := clWhite;
     canvas1.Canvas.Brush.Style := bsSolid;
     canvas1.Canvas.Rectangle(0,0, lebar, tinggi);
     canvas1.Canvas.pen.color := clRed;
     canvas1.Canvas.pen.Style := psDot;
     canvas1.Canvas.MoveTo(kolomP, 0);
     canvas1.Canvas.LineTo(kolomP, tinggi);
     canvas1.Canvas.MoveTo(0, barisP);
     canvas1.Canvas.LineTo(lebar, barisP);
end;

procedure TForm1.clearbtnClick(Sender: TObject);
begin
     initCanvas();
end;

procedure TForm1.closebtnClick(Sender: TObject);
begin
     Application.Terminate;
end;

procedure TForm1.CompositebtnClick(Sender: TObject);
var
   sudut,sudutRad,Sx, Sy, Tx, Ty : Double;
   i,j: integer;
   maxX,maxY,minX,minY,pivotX,pivotY : double;
begin
     sudut := StrToFloat(SudInput.Text);
     sudutRad := sudut*pi/180;
     Sx := StrToFloat(SxInput.Text);
     Sy := StrToFloat(SyInput.Text);
     Tx := StrToFloat(TxInput.Text);
     Ty := StrToFloat(TyInput.Text);
     if pivotcheckbox.Checked=True then
     begin
        maxX:=px[1];
        minX:=px[1];
        maxY:=py[1];
        minY:=py[1];
        for i:=1 to 5 do
        begin
            maxX := Max(maxX,px[i]);
            minX:= Min(minX,px[i]);
            maxY:= Max(maxY,py[i]);
            minY:= Min(minY,py[i]);
            pivotX:=(maxX+minX)/2;
            pivotY:=(maxY+minY)/2;
        end;
        for i:=1 to 5 do
        begin
             temp:=px[i];
             px[i]:=px[i]-pivotX;
             py[i]:=py[i]-pivotY;
             px[i]:=px[i]*Sx;
             py[i]:=py[i]*Sy;
             px[i]:=px[i]+pivotX;
             py[i]:=py[i]+pivotY;
             px[i]:=(temp-pivotX)*Cos(sudutRad)-(py[i]-pivotY)*Sin(sudutRad);
             py[i]:=(temp-pivotX)*Sin(sudutRad)+(py[i]-pivotY)*Cos(sudutRad);
             px[i]:=px[i]+pivotX;
             py[i]:=py[i]+pivotY;
             px[i] := px[i] + Tx;
             py[i] := py[i] + Ty;
        end;
     end
     else
     begin
         for i:=1 to 5 do
         begin
         temp:=px[i];
         px[i]:=(temp)*Cos(sudutRad)-(py[i])*Sin(sudutRad);
         py[i]:=(temp)*Sin(sudutRad)+(py[i])*Cos(sudutRad);
         px[i]:=px[i]*Sx;
         py[i]:=py[i]*Sy;
         px[i] := px[i] + Tx;
         py[i] := py[i] + Ty;
         end;
     end;
     initCanvas();
     for i:=1 to 5 do
     begin
         canvas1.Canvas.MoveTo(Round(px[i]+kolomP),barisP - Round(py[i]));
         for j:=1 to 5 do
         begin
              if arah[i,j] = True then
              canvas1.Canvas.LineTo(Round(px[j]+kolomP),barisP - Round(py[j]));
         end;
     end;
end;

procedure TForm1.drawbtnClick(Sender: TObject);
var
    i,j:Integer;
    objcheckbox:TCheckBox;
begin
     for i:=1 to 5 do
     begin
          px[i]:= StrToFloat(TEdit(Form1.FindComponent('Px'+IntToStr(i)+'Input')).Text);
          py[i]:= StrToFloat(TEdit(Form1.FindComponent('Py'+IntToStr(i)+'Input')).Text);
     end;
     for i:=1 to 5 do
     begin
          for j:=1 to 5 do
          begin
               objcheckbox:=TCheckBox(Form1.FindComponent('p'+IntToStr(i)+'p'+IntToStr(j)));
               arah[i,j]:=objcheckbox.Checked;
          end;
     end;
     for i:=1 to 5 do
     begin
          canvas1.Canvas.MoveTo(Round(px[i]+kolomP),barisP- Round(py[i]));
          for j:=1 to 5 do
          begin
               if arah[i,j] = True then
                  canvas1.Canvas.LineTo(Round(px[j]+kolomP),barisP - Round(py[j]));
          end;
     end;
end;

procedure TForm1.rotasibtnClick(Sender: TObject);
var
   sudut, tsudut,sudutRad : Double;
   i,j: integer;
   maxX,maxY,minX,minY,pivotX,pivotY : double;
   cond: Boolean;
begin
     sudut := StrToFloat(SudInput.Text);
     tsudut := 0;
     cond := True;
     for i:=1 to 5 do
     begin
          tpx[i]:=px[i];
          tpy[i]:=py[i];
     end;
     while (cond) do
     begin
          sudutRad := tsudut*pi/180;
          if pivotcheckbox.Checked=True then
          begin
               maxX:=tpx[1];
               minX:=tpx[1];
               maxY:=tpy[1];
               minY:=tpy[1];
               for i:=1 to 5 do
               begin
                    maxX := Max(maxX,tpx[i]);
                    minX:= Min(minX,tpx[i]);
                    maxY:= Max(maxY,tpy[i]);
                    minY:= Min(minY,tpy[i]);
                    pivotX:=(maxX+minX)/2;
                    pivotY:=(maxY+minY)/2;
               end;
               for i:=1 to 5 do
               begin
                    temp:=tpx[i];
                    px[i]:=(temp-pivotX)*Cos(sudutRad)-(tpy[i]-pivotY)*Sin(sudutRad);
                    py[i]:=(temp-pivotX)*Sin(sudutRad)+(tpy[i]-pivotY)*Cos(sudutRad);
                    px[i]:=px[i]+pivotX;
                    py[i]:=py[i]+pivotY;
               end;
          end
          else
          begin
               for i:=1 to 5 do
               begin
                    temp:=tpx[i];
                    px[i]:=(temp)*Cos(sudutRad)-(tpy[i])*Sin(sudutRad);
                    py[i]:=(temp)*Sin(sudutRad)+(tpy[i])*Cos(sudutRad);
               end;
          end;
         initCanvas();
         for i:=1 to 5 do
         begin
              canvas1.Canvas.MoveTo(Round(px[i]+kolomP),barisP - Round(py[i]));
              for j:=1 to 5 do
              begin
                  if arah[i,j] = True then
                  canvas1.Canvas.LineTo(Round(px[j]+kolomP),barisP - Round(py[j]));
              end;
         end;
         sleep(10);
         canvas1.Repaint;
          if (sudut > 0) and (tsudut < sudut) then
          begin
               tsudut := tsudut + 1;
          end
          else if (sudut < 0) and (tsudut > sudut) then
          begin
               tsudut := tsudut - 1;
          end
          else
          begin
               cond := False;
          end;
     end;
end;

procedure TForm1.scallingbtnClick(Sender: TObject);
var
   i : integer;
   Sx, Sy, Tsx, Tsy : Double;
   condX, condY : Boolean;
begin
     Sx := StrToFloat(SxInput.Text);
     Sy := StrToFloat(SyInput.Text);
     Tsx := 1;
     Tsy := 1;
     condX := True;
     condY := True;
     for i:=1 to 5 do
     begin
          tpx[i]:=px[i];
          tpy[i]:=py[i];
     end;
     while condX and condY do
     begin
          scale(Tsx, Tsy);
          sleep(10);
          canvas1.Repaint;
          if (Sy > 1) and (Tsy < Sy) then
         begin
              Tsy := Tsy + 0.01;
         end
         else if (Sy < 1) and (Tsy > Sy) then
         begin
              Tsy := Tsy - 0.01;
         end
         else
         begin
              condY := False;
         end;
         if (Sx > 1) and (Tsx < Sx) then
         begin
              Tsx := Tsx + 0.01;
         end
         else if (Sx < 1) and (Tsx > Sx) then
         begin
              Tsx := Tsx - 0.01;
         end
         else
         begin
              condX := False;
         end;
     end;
end;

procedure TForm1.scale(Sx, Sy : Double);
var
  i,j : integer;
  maxX,maxY,minX,minY,pivotX,pivotY : double;
begin
    begin
         if pivotcheckbox.Checked=True then
         begin
              maxX:=tpx[1];
              minX:=tpx[1];
              maxY:=tpy[1];
              minY:=tpy[1];
              for i:=1 to 5 do
              begin
                   maxX := MAX(maxX,tpx[i]);
                   minX:= Min(minX,tpx[i]);
                   maxY:= Max(maxY,tpy[i]);
                   minY:= Min(minY,tpy[i]);
                   pivotX:=(maxX+minX)/2;
                   pivotY:=(maxY+minY)/2;
              end;
              for i:=1 to 5 do
              begin
                  px[i]:=tpx[i]-pivotX;
                  py[i]:=tpy[i]-pivotY;
                  px[i]:=px[i]*Sx;
                  py[i]:=py[i]*Sy;
                  px[i]:=px[i]+pivotX;
                  py[i]:=py[i]+pivotY;
              end;
         end
         else
         begin
              for i:=1 to 5 do
              begin
                   px[i]:=tpx[i]*Sx;
                   py[i]:=tpy[i]*Sy;
              end;
         end;
         initCanvas();
         for i:=1 to 5 do
         begin
              canvas1.Canvas.MoveTo(Round(px[i]+kolomP),barisP - Round(py[i]));
              for j:=1 to 5 do
              begin
                   if arah[i,j] = True then
                   canvas1.Canvas.LineTo(Round(px[j]+kolomP),barisP - Round(py[j]));
              end;
         end;
    end;
end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;


procedure TForm1.translatebtnClick(Sender: TObject);
var
  Tx, Ty, Ttx, Tty : Double;
  condX, condY: Boolean;
  i,j : integer;
begin
    CondX := True;
    CondY := True;
    Tx := StrToFloat(TxInput.Text);
    Ty := StrToFloat(TyInput.Text);
    Ttx := 0;
    Tty := 0;
    for i:=1 to 5 do
    begin
          tpx[i]:=px[i];
          tpy[i]:=py[i];
    end;
    while condX or condY do
    begin
         for i:=1 to 5 do
         begin
              px[i] := tpx[i] + Ttx;
              py[i] := tpy[i] + Tty;
         end;
         initCanvas();
         for i:=1 to 5 do
         begin
              canvas1.Canvas.MoveTo(Round(px[i]+kolomP),barisP- Round(py[i]));
              for j:=1 to 5 do
              begin
                   if arah[i,j] = True then
                   canvas1.Canvas.LineTo(Round(px[j]+kolomP),barisP - Round(py[j]));
              end;
         end;
         sleep(10);
         canvas1.Repaint;
         if (Ty > 0) and (Tty < Ty) then
         begin
              Tty := Tty + 1;
         end
         else if (Ty < 0) and (Tty > Ty) then
         begin
              Tty := Tty - 1;
         end
         else
         begin
              condY := False;
         end;
         if (Tx > 0) and (Ttx < Tx) then
         begin
              Ttx := Ttx + 1;
         end
         else if (Tx < 0) and (Ttx > Tx) then
         begin
              Ttx := Ttx - 1;
         end
         else
         begin
              condX := False;
         end;
    end;
end;

end.

