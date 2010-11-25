import javax.sound.midi.*;

Synthesizer synthesizer = null;

boolean StartSynth()
{
  try 
  {
    synthesizer = MidiSystem.getSynthesizer();
    synthesizer.open();
  } 
  catch (MidiUnavailableException e) 
  { 
    println("Cannot play!"); 
    return false;
  }
  return true;
}
void StopSynth()
{
  if (synthesizer != null)
  {
    synthesizer.close();
    synthesizer = null;
  }
}

void Wait(int duration)
{
  try { Thread.sleep(duration); } catch (InterruptedException e) {}
}
void PlayNote(int noteNumber, int velocity, int duration)
{
  int channelNb = 0;
  MidiChannel[] channels = synthesizer.getChannels();
  channels[channelNb].noteOn(noteNumber, velocity);
  Wait(duration);
  channels[channelNb].noteOff(noteNumber);
}
void PlayNote(int noteNumber, int velocity, int durationOn, int durationOff)
{
  int channelNb = 2;
  MidiChannel[] channels = synthesizer.getChannels();
  channels[channelNb].noteOn(noteNumber, velocity);
  Wait(durationOn);
  channels[channelNb].noteOff(noteNumber, durationOff);
}

void stop()
{
  println("Stop");
  StopSynth();
  super.stop();
}

void setup()
{
  if (!StartSynth())
  {
    exit();
  }  
  PlayNote(72, 120, 500);
  PlayNote(60, 80, 200);
  PlayNote(68, 80, 300);
  Wait(200);
  PlayNote(48, 60, 500, 800);
  Wait(500);
  
  exit();  
}

