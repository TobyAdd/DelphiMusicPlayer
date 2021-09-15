unit SonStream;

interface

uses Bass,SysUtils;

const
  CHORUS=1;
  COMPRESSOR=2;
  DISTORTION=3;
  ECHO=4;
  FLANGER=5;
  GARGLE=6;
  PARAMEQLOW=7;
  PARAMEQMED=8;
  PARAMEQHIGH=9;
  REVERB=10;
  MAX_EFFET=10;

  FREQUENCE_INITIAL = 44100 ;
  FREQUENCE_MIN = 100;
  FREQUENCE_MAX = 100000;

  PAN_INI = 0;
  PAN_MAX = 100;
  PAN_MIN = -100;

  VOLUME_INI = 75;
  VOLUME_MAX = 100;
  VOLUME_MIN = 0;


  CHORUS_MIN_WET_DRY_MIX=0.0;
  CHORUS_INI_WET_DRY_MIX=0.0;
  CHORUS_MAX_WET_DRY_MIX = 100.0;

  CHORUS_MIN_DEPTH=0.0;
  CHORUS_INI_DEPTH=25.0;
  CHORUS_MAX_DEPTH=100.0;

  CHORUS_MIN_FEEDBACK=-99.0;
  CHORUS_INI_FEEDBACK=0.0;
  CHORUS_MAX_FEEDBACK=99.0;

  CHORUS_MIN_FREQUENCY=0.0;
  CHORUS_INI_FREQUENCY=0.0;
  CHORUS_MAX_FREQUENCY=10.0;

  CHORUS_MIN_DELAY=0.0;
  CHORUS_INI_DELAY=0.0;
  CHORUS_MAX_DELAY=20.0;


  FLANGER_MIN_WET_DRY_MIX=0.0;
  FLANGER_INI_WET_DRY_MIX=0.0;
  FLANGER_MAX_WET_DRY_MIX = 100.0;

  FLANGER_MIN_DEPTH=0.0;
  FLANGER_INI_DEPTH=25.0;
  FLANGER_MAX_DEPTH=100.0;

  FLANGER_MIN_FEEDBACK=-99.0;
  FLANGER_INI_FEEDBACK=0.0;
  FLANGER_MAX_FEEDBACK=99.0;

  FLANGER_MIN_FREQUENCY=0.0;
  FLANGER_INI_FREQUENCY=0.0;
  FLANGER_MAX_FREQUENCY=10.0;

  FLANGER_MIN_DELAY=0.0;
  FLANGER_INI_DELAY=0.0;
  FLANGER_MAX_DELAY=4.0;

  COMPRESSOR_MAX_GAIN=60.0;
  COMPRESSOR_INI_GAIN=0.0;
  COMPRESSOR_MIN_GAIN=-60.0;

  PARAMEQ_MAX_GAIN=15.0;
  PARAMEQ_MIN_GAIN=-15.0;
  PARAMEQ_INI_GAIN=0.0;

  DISTORTION_MIN_GAIN=-60.0;
  DISTORTION_INI_GAIN=0.0;
  DISTORTION_MAX_GAIN=0.0;

  DISTORTION_MIN_EDGE=0.0;
  DISTORTION_INI_EDGE=50.0;
  DISTORTION_MAX_EDGE=100.0;

  DISTORTION_MIN_POST_EQ_CENTER_FREQUENCY=100.0;
  DISTORTION_INI_POST_EQ_CENTER_FREQUENCY=4000.0;
  DISTORTION_MAX_POST_EQ_CENTER_FREQUENCY=8000.0;

  DISTORTION_MIN_POST_EQ_BANDWITH=100.0;
  DISTORTION_INI_POST_EQ_BANDWITH=4000.0;
  DISTORTION_MAX_POST_EQ_BANDWITH=8000.0;

  DISTORTION_MIN_PRE_LOWPASS_CUT_OFF=100.0;
  DISTORTION_INI_PRE_LOWPASS_CUT_OFF=4000.0;
  DISTORTION_MAX_PRE_LOWPASS_CUT_OFF=8000.0;

  GARGLE_MIN_DW_RATE_HZ=1;
  GARGLE_INI_DW_RATE_HZ=15;
  GARGLE_MAX_DW_RATE_HZ=1000;

type

  TSonStream = class(TObject)
  private
      nom:string;
      nomComplet : string;
      volume,frequence,pan : integer;

      //stream : HSTREAM;

      ch : BASS_FXCHORUS;
      co:  BASS_FXCOMPRESSOR;
      di:  BASS_FXDISTORTION;
      ec:  BASS_FXECHO;
      fl:  BASS_FXFLANGER;
      ga:  BASS_FXGARGLE;
      pq:  BASS_FXPARAMEQ;
      rv:  BASS_FXREVERB;

      fx : array [1..MAX_EFFET] of HFX;

      procedure SetAttributes(volume,frequence,pan:integer);

  public
      constructor Create;
      destructor Destroy;override;
      {
         ========================================================================
                    --  Fonctions générales --
         ========================================================================
      }

      procedure Charger(name:string);
      procedure Lire(AuDebut:boolean);
      procedure Stopper;
      procedure Pause;

      function GetNom:string;
      function GetNomComplet:string;

      function PositionEnCours:dword;
      procedure ChangerPosition(NouvellePosition:dword);
      function LongueurTotal:dword;

      function GetTempsTotal : float;
      function GetTempsEnCours : float;

      procedure SetVolume(NewVolume : integer);
      function GetVolume:integer;

      function GetVolumeMax:integer;
      function GetVolumeMin:integer;

      procedure SetPan(NewPan:integer);
      function GetPan:integer;

      function GetPanMax:integer;
      function GetPanMin:integer;
      function GetPanIni:integer;

      procedure SetFrequence(NewFrequence:integer);
      function GetFrequence:integer;

      function GetFrequenceMax:integer;
      function GetFrequenceIni:integer;
      function GetFrequenceMin:integer;



      {
         ========================================================================
                    --  Procedures pour (des)activer les effets --
         ========================================================================
      }
      procedure AppliquerChorus;
      procedure RetirerChorus;

      procedure AppliquerCompressor;
      procedure RetirerCompressor;

      procedure AppliquerDistortion;
      procedure RetirerDistortion;

      procedure AppliquerEcho;
      procedure RetirerEcho;

      procedure AppliquerFlanger;
      procedure RetirerFlanger;

      procedure AppliquerGargle;
      procedure RetirerGargle;

      procedure AppliquerParamEQLow;
      procedure RetirerParamEQLow;

      procedure AppliquerParamEQMed;
      procedure RetirerParamEQMed;

      procedure AppliquerParamEQHigh;
      procedure RetirerParamEQHigh;

      procedure AppliquerReverb;
      procedure RetirerReverb;

      {
         ========================================================================
                    --  Procedures pour gerer plus profondement les effets --
         ========================================================================
      }
      procedure SetCompressor(fGain:float);

      procedure SetParamEQLow(fGain:float);
      procedure SetParamEQMed(fGain:float);
      procedure SetParamEQHigh(fGain:float);

      procedure SetFlanger(fWetDryMix:float;fDepth:float;fFeedback:float;
      fFrequency:float;lWaveform:Dword;fDelay:float;lPhase:Dword);

      procedure SetChorus(fWetDryMix:float;fDepth:float;fFeedback:float;
                          fFrequency:float;lWaveform:DWORD;fDelay:float;lPhase:DWORD);

      procedure SetDistortion(fGain:float;fEdge:float;fPostEQCenterFrequency:float;
                          fPostEQBandwidth:float;fPreLowpassCutoff:float);

     procedure SetGargle(dwRateHz:Dword;dwWaveShape:DWORD);


      {
         =================================================================================
                    --  function pour retrouver les valeurs MAX/MIN/INI des effets --
         =================================================================================
      }

      function GetMaxChorusWetDryMix:float;
      function GetMaxChorusDepth:float;
      function GetMaxChorusFeedback:float;
      function GetMaxChorusFrquency:float;
      function GetMaxChorusDelay:float;

      function GetMinChorusWetDryMix:float;
      function GetMinChorusDepth:float;
      function GetMinChorusFeedback:float;
      function GetMinChorusFrquency:float;
      function GetMinChorusDelay:float;

      function GetIniChorusWetDryMix:float;
      function GetIniChorusDepth:float;
      function GetIniChorusFeedback:float;
      function GetIniChorusFrquency:float;
      function GetIniChorusDelay:float;

      function GetMaxFlangerWetDryMix:float;
      function GetMaxFlangerDepth:float;
      function GetMaxFlangerFeedback:float;
      function GetMaxFlangerFrquency:float;
      function GetMaxFlangerDelay:float;

      function GetMinFlangerWetDryMix:float;
      function GetMinFlangerDepth:float;
      function GetMinFlangerFeedback:float;
      function GetMinFlangerFrquency:float;
      function GetMinFlangerDelay:float;

      function GetIniFlangerWetDryMix:float;
      function GetIniFlangerDepth:float;
      function GetIniFlangerFeedback:float;
      function GetIniFlangerFrquency:float;
      function GetIniFlangerDelay:float;

      function GetMaxCompressorGain:float;
      function GetMinCompressorGain:float;
      function GetIniCompressorGain:float;

      function GetMaxParamEQGain:float;
      function GetMinParamEQGain:float;
      function GetIniParamEQGain:float;

      function GetMaxDistortionGain:float;
      function GetMaxDistortionEdge:float;
      function GetMaxDistortionPostEqCenterFrequency:float;
      function GetMaxDistortionPostEqBandwith:float;
      function GetMaxDistortionPreLowpassCutOff:float;

      function GetMinDistortionGain:float;
      function GetMinDistortionEdge:float;
      function GetMinDistortionPostEqCenterFrequency:float;
      function GetMinDistortionPostEqBandwith:float;
      function GetMinDistortionPreLowpassCutOff:float;

      function GetIniDistortionGain:float;
      function GetIniDistortionEdge:float;
      function GetIniDistortionPostEqCenterFrequency:float;
      function GetIniDistortionPostEqBandwith:float;
      function GetIniDistortionPreLowpassCutOff:float;

      function GetMaxGargleDwRateHz:DWORD;
      function GetMinGargleDwRateHz:DWORD;
      function GetIniGargleDwRateHz:DWORD;
  end;

var
stream : HSTREAM;

implementation

{
  Ini de BASS
}
constructor TSonStream.Create;
begin
     Bass_Init(-1,FREQUENCE_INITIAL,0,0,nil);
     volume:=VOLUME_INI; // par defaut vol a 3/4
     pan := PAN_INI; // son centré
     frequence := FREQUENCE_INITIAL;
end;

{
  Libere Bass
  Libere le stream
}
destructor TSonStream.Destroy;
begin
  Bass_StreamFree(stream);
  Bass_Free;
  inherited;
end;
{
  Si le stream a deja ete charge ( stream <> 0 ) on le libere puis le re-charge
  affectation de nom et nomComplet
}
procedure TSonStream.Charger(name:string);
begin
  if(stream<>0) then Bass_StreamFree(stream);// un son est chargé
  stream := BASS_StreamCreateFile(False, PChar(name), 0, 0, 0);
  if(stream=0) then exit;
  nom := ExtractFileName(name);
  nomComplet:=name;
end;

{
         ========================================================================
                    --  Fonctions générales --
         ========================================================================
}
procedure TSonStream.Lire(AuDebut:boolean);
begin
  SetAttributes(volume,frequence,pan);
  Bass_ChannelPlay(stream,AuDebut);
end;

procedure TSonStream.Stopper;
begin
  Bass_ChannelStop(stream);
end;

procedure TSonStream.Pause;
begin
  Bass_ChannelPause(stream);
end;

function TSonStream.GetNom:string;
begin
  result:=nom;
end;

function TSonStream.GetNomComplet:string;
begin
  result:=nomComplet;
end;

function TSonStream.LongueurTotal:dword;
begin
  result:=BASS_ChannelGetLength(stream);
end;

function TSonStream.GetTempsTotal : float;
begin
  result:=BASS_ChannelBytes2Seconds(stream,LongueurTotal);
end;

function TSonStream.GetTempsEnCours : float;
begin
   result:=BASS_ChannelBytes2Seconds(stream,PositionEnCours);
end;


procedure TSonStream.ChangerPosition(NouvellePosition:dword);
begin
 BASS_ChannelSetPosition(stream,NouvellePosition);
end;

function TSonStream.PositionEnCours:dword;
begin
  result:=BASS_ChannelGetPosition(stream);
end;

procedure TSonStream.SetVolume(NewVolume : integer);
begin
  volume:=NewVolume;
  if(volume>VOLUME_MIN) AND
    (volume<VOLUME_MAX) then  SetAttributes(volume,frequence,pan);
end;

function TSonStream.GetVolume:integer;
begin
  result:=volume;
end;

function TSonStream.GetVolumeMax:integer;
begin
  result:=VOLUME_MAX;
end;

function TSonStream.GetVolumeMin:integer;
begin
  result:=VOLUME_MIN;
end;

procedure TSonStream.SetPan(NewPan:integer);
begin
  pan:=NewPan;
  if(pan>PAN_MIN) AND
    (pan<PAN_MAX) then SetAttributes(volume,frequence,pan);
end;

function TSonStream.GetPan:integer;
begin
  result:=pan;
end;

function TSonStream.GetPanMax:integer;
begin
  result:=PAN_MAX;
end;

function TSonStream.GetPanMin:integer;
begin
  result:=PAN_MIN;
end;

function TSonStream.GetPanIni:integer;
begin
  result:=PAN_INI;
end;

procedure TSonStream.SetFrequence(NewFrequence:integer);
begin
  frequence:=NewFrequence;
  if(frequence>FREQUENCE_MIN) AND
    (frequence<FREQUENCE_MAX) then SetAttributes(volume,frequence,pan);
end;

function TSonStream.GetFrequence:integer;
begin
  result:=frequence;
end;

function TSonStream.GetFrequenceMax:integer;
begin
  result:=FREQUENCE_MAX;
end;

function TSonStream.GetFrequenceIni:integer;
begin
  result:=FREQUENCE_INITIAL;
end;

function TSonStream.GetFrequenceMin:integer;
begin
  result:=FREQUENCE_MIN;
end;

procedure TSonStream.SetAttributes(volume,frequence,pan:integer);
begin
  BASS_ChannelSetAttributes(stream,frequence,volume,pan);
end;

{
         ========================================================================
                    --  Procedure pour (des)activer les effets --
         ========================================================================
}
procedure TSonStream.AppliquerChorus;
begin
  fx[CHORUS]:= BASS_ChannelSetFX(stream,BASS_FX_CHORUS,0);
end;

procedure TSonStream.RetirerChorus;
begin
  BASS_ChannelRemoveFX(stream,fx[CHORUS]);
end;

procedure TSonStream.AppliquerCompressor;
begin
  fx[COMPRESSOR]:= BASS_ChannelSetFX(stream,BASS_FX_COMPRESSOR,0)
end;

procedure TSonStream.RetirerCompressor;
begin
  BASS_ChannelRemoveFX(stream,fx[COMPRESSOR]);
end;

procedure TSonStream.AppliquerDistortion;
begin
  fx[DISTORTION]:= BASS_ChannelSetFX(stream,BASS_FX_DISTORTION,0)
end;

procedure TSonStream.RetirerDistortion;
begin
  BASS_ChannelRemoveFX(stream,fx[DISTORTION]);
end;

procedure TSonStream.AppliquerEcho;
begin
  fx[ECHO]:= BASS_ChannelSetFX(stream,BASS_FX_ECHO,0)
end;

procedure TSonStream.RetirerEcho;
begin
  BASS_ChannelRemoveFX(stream,fx[ECHO]);
end;

procedure TSonStream.AppliquerFlanger;
begin
  fx[FLANGER] := BASS_ChannelSetFX(stream,BASS_FX_FLANGER,0);
end;

procedure TSonStream.RetirerFlanger;
begin
  BASS_ChannelRemoveFX(stream,fx[FLANGER]);
end;


procedure TSonStream.AppliquerGargle;
begin
  fx[GARGLE] := BASS_ChannelSetFX(stream,BASS_FX_GARGLE,0);
end;

procedure TSonStream.RetirerGargle;
begin
  BASS_ChannelRemoveFX(stream,fx[GARGLE]);
end;

procedure TSonStream.AppliquerParamEQLow;
begin
  fx[PARAMEQLOW] := BASS_ChannelSetFX(stream,BASS_FX_PARAMEQ,0);
  BASS_FXGetParameters(fx[PARAMEQLOW], @pq);
      pq.fGain:=0;
      pq.fCenter:=80;
      pq.fBandwidth:=30;
  BASS_FXSetParameters(fx[PARAMEQLOW], @pq);

end;

procedure TSonStream.RetirerParamEQLow;
begin
  BASS_ChannelRemoveFX(stream,fx[PARAMEQLOW]);
end;

procedure TSonStream.AppliquerParamEQMed;
begin
  fx[PARAMEQMED] := BASS_ChannelSetFX(stream,BASS_FX_PARAMEQ,0);
  BASS_FXGetParameters(fx[PARAMEQMED], @pq);
      pq.fGain:=0;
      pq.fCenter:=5000;
      pq.fBandwidth:=30;
  BASS_FXSetParameters(fx[PARAMEQMED], @pq);
end;

procedure TSonStream.RetirerParamEQMed;
begin
  BASS_ChannelRemoveFX(stream,fx[PARAMEQMED]);
end;

procedure TSonStream.AppliquerParamEQHigh;
begin
  fx[PARAMEQHIGH] := BASS_ChannelSetFX(stream,BASS_FX_PARAMEQ,0);
  BASS_FXGetParameters(fx[PARAMEQHIGH], @pq);
      pq.fGain:=0;
      pq.fCenter:=12000;
      pq.fBandwidth:=30;
  BASS_FXSetParameters(fx[PARAMEQHIGH], @pq);
end;

procedure TSonStream.RetirerParamEQHigh;
begin
  BASS_ChannelRemoveFX(stream,fx[PARAMEQHIGH]);
end;

procedure TSonStream.AppliquerReverb;
begin
  fx[REVERB] := BASS_ChannelSetFX(stream,BASS_FX_REVERB,0);
end;

procedure TSonStream.RetirerReverb;
begin
  BASS_ChannelRemoveFX(stream,fx[REVERB]);
end;
{
         ========================================================================
                    --  Procedures pour gerer plus profondement les effets --
         ========================================================================
}
{
  NB : On va se servir des Constantes pour regarder si l'utilisateur ne depasse pas les valeurs
       Normalement si il utilise mon systeme de constante GetMax ... et GetMin ... il n'y a pas
       de problemes
}
procedure TSonStream.SetFlanger(fWetDryMix:float;fDepth:float;fFeedback:float;
      fFrequency:float;lWaveform:Dword;fDelay:float;lPhase:Dword);
begin
  BASS_FXGetParameters(fx[FLANGER], @fL);
     if(fWetDryMix>FLANGER_MIN_WET_DRY_MIX) AND
       (fWetDryMix<FLANGER_MAX_WET_DRY_MIX) then  fL.fWetDryMix:=fWetDryMix;
     if(fDepth>FLANGER_MIN_DEPTH) AND
       (fDepth<FLANGER_MAX_DEPTH) then  fl.fDepth:=fDepth;
     if(fFeedback>FLANGER_MIN_FEEDBACK) AND
       (fFeedback<FLANGER_MAX_FEEDBACK) then  fl.fFeedback:=fFeedback;

     if(fFrequency>FLANGER_MIN_FEEDBACK) AND
       (fFrequency<FLANGER_MAX_FEEDBACK) then  fl.fFrequency:=fFrequency;
     fl.lWaveform :=lWaveform;
     if(fDelay>FLANGER_MIN_DELAY) AND
       (fDelay<FLANGER_MAX_DELAY) then  fl.fDelay:=fDelay;
     fl.lPhase:=lPhase;
  BASS_FXSetParameters(fx[FLANGER], @fL);
end;

procedure TSonStream.SetCompressor(fGain:float);
begin
  BASS_FXGetParameters(fx[COMPRESSOR], @co);
  if(fGain>COMPRESSOR_MIN_GAIN) AND
    (fGain<COMPRESSOR_MAX_GAIN) then    co.fGain:=fGain;
  BASS_FXSetParameters(fx[COMPRESSOR], @co);
end;

procedure TSonStream.SetParamEQLow(fGain:float);
begin
  BASS_FXGetParameters(fx[PARAMEQLOW], @pq);
      if(fGain>PARAMEQ_MIN_GAIN) AND
        (fGain<PARAMEQ_MAX_GAIN) then    pq.fGain:=fGain;
      pq.fCenter:=80;
      pq.fBandwidth:=30;
  BASS_FXSetParameters(fx[PARAMEQLOW], @pq);

end;

procedure TSonStream.SetParamEQMed(fGain:float);
begin
  BASS_FXGetParameters(fx[PARAMEQMED], @pq);
      if(fGain>PARAMEQ_MIN_GAIN) AND
        (fGain<PARAMEQ_MAX_GAIN) then    pq.fGain:=fGain;
      pq.fCenter:=5000;
      pq.fBandwidth:=30;
  BASS_FXSetParameters(fx[PARAMEQMED], @pq);
end;

procedure TSonStream.SetParamEQHigh(fGain:float);
begin
  BASS_FXGetParameters(fx[PARAMEQHIGH], @pq);
      if(fGain>PARAMEQ_MIN_GAIN) AND
        (fGain<PARAMEQ_MAX_GAIN) then    pq.fGain:=fGain;
      pq.fCenter:=12000;
      pq.fBandwidth:=30;
  BASS_FXSetParameters(fx[PARAMEQHIGH], @pq);
end;

procedure TSonStream.SetChorus(fWetDryMix:float;fDepth:float;fFeedback:float;
         fFrequency:float;lWaveform:DWORD;fDelay:float;lPhase:DWORD);
begin
  BASS_FXGetParameters(fx[CHORUS],@ch);
      if(fWetDryMix>CHORUS_MIN_WET_DRY_MIX) AND
       (fWetDryMix<CHORUS_MAX_WET_DRY_MIX) then  ch.fWetDryMix:=fWetDryMix;
     if(fDepth>CHORUS_MIN_DEPTH) AND
       (fDepth<CHORUS_MAX_DEPTH) then  ch.fDepth:=fDepth;
     if(fFeedback>CHORUS_MIN_FEEDBACK) AND
       (fFeedback<CHORUS_MAX_FEEDBACK) then  ch.fFeedback:=fFeedback;

     if(fFrequency>CHORUS_MIN_FEEDBACK) AND
       (fFrequency<CHORUS_MAX_FEEDBACK) then  ch.fFrequency:=fFrequency;
     ch.lWaveform :=lWaveform;
     if(fDelay>CHORUS_MIN_DELAY) AND
       (fDelay<CHORUS_MAX_DELAY) then  ch.fDelay:=fDelay;
     ch.lPhase:=lPhase;

  BASS_FXSetParameters(fx[CHORUS], @ch);
end;
procedure TSonStream.SetDistortion(fGain:float;fEdge:float;fPostEQCenterFrequency:float;
          fPostEQBandwidth:float;fPreLowpassCutoff:float);
begin
  BASS_FXGetParameters(fx[DISTORTION],@di);
      if(fGain>DISTORTION_MIN_GAIN) AND
        (fGain<DISTORTION_MAX_GAIN)then di.fGain:=fGain;

      if(fEdge>DISTORTION_MIN_EDGE) AND
        (fEdge<DISTORTION_MAX_EDGE) then di.fEdge:=fEdge;

      if(fPostEQCenterFrequency>DISTORTION_MIN_POST_EQ_CENTER_FREQUENCY) AND
        (fPostEQCenterFrequency<DISTORTION_MAX_POST_EQ_CENTER_FREQUENCY)then di.fPostEQCenterFrequency:=fPostEQCenterFrequency;
      if(fPostEQBandwidth>DISTORTION_MIN_POST_EQ_BANDWITH) AND
        (fPostEQBandwidth<DISTORTION_MAX_POST_EQ_BANDWITH) then di.fPostEQBandwidth:=fPostEQBandwidth;
      if(fPreLowpassCutoff>DISTORTION_MIN_PRE_LOWPASS_CUT_OFF) AND
        (fPreLowpassCutoff<DISTORTION_MAX_PRE_LOWPASS_CUT_OFF) then di.fPreLowpassCutoff:=fPreLowpassCutoff;
  BASS_FXSetParameters(fx[DISTORTION],@di);
end;

procedure TSonStream.SetGargle(dwRateHz:Dword;dwWaveShape:DWORD);
begin
  BASS_FXGetParameters(fx[GARGLE],@ga);
      if(dwRateHz>GARGLE_MIN_DW_RATE_HZ) AND
        (dwRateHz<GARGLE_MAX_DW_RATE_HZ) then ga.dwRateHz:=dwRateHz;
      ga.dwWaveShape:=dwWaveShape;
  BASS_FXSetParameters(fx[GARGLE],@ga);
end;

{
         =================================================================================
                    --  function pour retrouver les valeurs MAX/MIN/INI des effets --
         =================================================================================
}
function TSonStream.GetMaxChorusWetDryMix:float;
begin
  result:=CHORUS_MAX_WET_DRY_MIX;
end;

function TSonStream.GetMaxChorusDepth:float;
begin
  result:=CHORUS_MAX_DEPTH;
end;

function TSonStream.GetMaxChorusFeedback:float;
begin
  result:=CHORUS_MAX_FEEDBACK;
end;

function TSonStream.GetMaxChorusFrquency:float;
begin
  result:=CHORUS_MAX_FREQUENCY;
end;

function TSonStream.GetMaxChorusDelay:float;
begin
  result:=CHORUS_MAX_DELAY;
end;

function TSonStream.GetMinChorusWetDryMix:float;
 begin
  result:=CHORUS_MIN_WET_DRY_MIX;
end;

function TSonStream.GetMinChorusDepth:float;
begin
  result:=CHORUS_MIN_DEPTH;
end;

function TSonStream.GetMinChorusFeedback:float;
begin
  result:=CHORUS_MIN_FEEDBACK;
end;

function TSonStream.GetMinChorusFrquency:float;
begin
  result:=CHORUS_MIN_FREQUENCY;
end;

function TSonStream.GetMinChorusDelay:float;
begin
  result:=CHORUS_MIN_DELAY;
end;

function TSonStream.GetIniChorusWetDryMix:float;
begin
  result:=CHORUS_INI_WET_DRY_MIX;
end;

function TSonStream.GetIniChorusDepth:float;
begin
  result:=CHORUS_INI_DEPTH;
end;

function TSonStream.GetIniChorusFeedback:float;
begin
  result:=CHORUS_INI_FEEDBACK;
end;

function TSonStream.GetIniChorusFrquency:float;
begin
  result:=CHORUS_INI_FREQUENCY;
end;

function TSonStream.GetIniChorusDelay:float;
begin
  result:=CHORUS_INI_DELAY;
end;

function TSonStream.GetMaxFlangerWetDryMix:float;
begin
  result:=FLANGER_MAX_WET_DRY_MIX;
end;

function TSonStream.GetMaxFlangerDepth:float;
begin
  result:=FLANGER_MAX_DEPTH;
end;

function TSonStream.GetMaxFlangerFeedback:float;
begin
  result:=FLANGER_MAX_FEEDBACK;
end;

function TSonStream.GetMaxFlangerFrquency:float;
begin
  result:=FLANGER_MAX_FREQUENCY;
end;

function TSonStream.GetMaxFlangerDelay:float;
begin
  result:=FLANGER_MAX_DELAY;
end;

function TSonStream.GetMinFlangerWetDryMix:float;
begin
  result:=FLANGER_MIN_WET_DRY_MIX;
end;

function TSonStream.GetMinFlangerDepth:float;
begin
  result:=FLANGER_MIN_DEPTH;
end;

function TSonStream.GetMinFlangerFeedback:float;
begin
  result:=FLANGER_MIN_FEEDBACK;
end;

function TSonStream.GetMinFlangerFrquency:float;
begin
  result:=FLANGER_MIN_FREQUENCY;
end;

function TSonStream.GetMinFlangerDelay:float;
begin
  result:=FLANGER_MIN_DELAY;
end;

function TSonStream.GetIniFlangerWetDryMix:float;
begin
  result:=FLANGER_INI_WET_DRY_MIX;
end;

function TSonStream.GetIniFlangerDepth:float;
begin
  result:=FLANGER_INI_DEPTH;
end;

function TSonStream.GetIniFlangerFeedback:float;
begin
  result:=FLANGER_INI_FEEDBACK;
end;

function TSonStream.GetIniFlangerFrquency:float;
begin
  result:=FLANGER_INI_FREQUENCY;
end;

function TSonStream.GetIniFlangerDelay:float;
begin
  result:=FLANGER_INI_DELAY;
end;

function TSonStream.GetMaxCompressorGain:float;
begin
  result:=COMPRESSOR_MAX_GAIN;
end;

function TSonStream.GetMinCompressorGain:float;
begin
  result:=COMPRESSOR_MIN_GAIN;
end;

function TSonStream.GetIniCompressorGain:float;
begin
  result:=COMPRESSOR_INI_GAIN;
end;

function TSonStream.GetMaxParamEQGain:float;
begin
  result:=PARAMEQ_MAX_GAIN;
end;

function TSonStream.GetMinParamEQGain:float;
begin
  result:=PARAMEQ_MIN_GAIN;
end;

function TSonStream.GetIniParamEQGain:float;
begin
  result:=PARAMEQ_INI_GAIN;
end;

function TSonStream.GetMaxDistortionGain:float;
begin
  result:=DISTORTION_MAX_GAIN;
end;

function TSonStream.GetMaxDistortionEdge:float;
begin
  result:=DISTORTION_MAX_EDGE;
end;

function TSonStream.GetMaxDistortionPostEqCenterFrequency:float;
begin
  result:=DISTORTION_MAX_POST_EQ_CENTER_FREQUENCY;
end;

function TSonStream.GetMaxDistortionPostEqBandwith:float;
begin
  result:=DISTORTION_MAX_POST_EQ_BANDWITH;
end;

function TSonStream.GetMaxDistortionPreLowpassCutOff:float;
begin
  result:=DISTORTION_MAX_PRE_LOWPASS_CUT_OFF;
end;

function TSonStream.GetMinDistortionGain:float;
begin
  result:=DISTORTION_MIN_GAIN;
end;

function TSonStream.GetMinDistortionEdge:float;
begin
  result:=DISTORTION_MIN_EDGE;
end;

function TSonStream.GetMinDistortionPostEqCenterFrequency:float;
begin
  result:=DISTORTION_MIN_POST_EQ_CENTER_FREQUENCY;
end;

function TSonStream.GetMinDistortionPostEqBandwith:float;
begin
  result:=DISTORTION_MIN_POST_EQ_BANDWITH;
end;

function TSonStream.GetMinDistortionPreLowpassCutOff:float;
begin
  result:=DISTORTION_MIN_PRE_LOWPASS_CUT_OFF;
end;

function TSonStream.GetIniDistortionGain:float;
begin
  result:=DISTORTION_INI_GAIN;
end;

function TSonStream.GetIniDistortionEdge:float;
begin
  result:=DISTORTION_INI_EDGE;
end;

function TSonStream.GetIniDistortionPostEqCenterFrequency:float;
begin
  result:=DISTORTION_INI_POST_EQ_CENTER_FREQUENCY;
end;

function TSonStream.GetIniDistortionPostEqBandwith:float;
begin
  result:=DISTORTION_INI_POST_EQ_BANDWITH;
end;

function TSonStream.GetIniDistortionPreLowpassCutOff:float;
begin
  result:=DISTORTION_INI_PRE_LOWPASS_CUT_OFF;
end;

function TSonStream.GetMaxGargleDwRateHz:DWORD;
begin
  result:=GARGLE_MAX_DW_RATE_HZ;
end;

function TSonStream.GetMinGargleDwRateHz:DWORD;
begin
  result:=GARGLE_MIN_DW_RATE_HZ;
end;

function TSonStream.GetIniGargleDwRateHz:DWORD;
begin
  result:= GARGLE_INI_DW_RATE_HZ;
end;

end.
