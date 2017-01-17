// minim_sound_effect_sample1

import ddf.minim.*;

Minim minim;
AudioSample punch, whiff;

int xPunchBtn, yPunchBtn, dPunchBtn;
int xWhiffBtn, yWhiffBtn, dWhiffBtn;

void setup() {
  size( 300, 200 );
  smooth();

  xPunchBtn = int( width * (1.0/4) );
  yPunchBtn = int( height * (1.0/2) );
  dPunchBtn = 50;

  xWhiffBtn = int( width * (3.0/4) );
  yWhiffBtn = int( height * (1.0/2) );
  dWhiffBtn = 50;

  minim = new Minim( this );

  punch = minim.loadSample( "punch.wav" );
  whiff = minim.loadSample( "whiff.wav" );
}

void draw() {
  background( 0 );

  ellipseMode( RADIUS );
  fill( 0, 0, 255 );
  ellipse( xPunchBtn, yPunchBtn, dPunchBtn, dPunchBtn );
  fill( 0, 255, 255 );
  ellipse( xWhiffBtn, yWhiffBtn, dWhiffBtn, dWhiffBtn );
}

void mouseClicked() {
  if ( dist( mouseX, mouseY, xPunchBtn, yPunchBtn ) < dPunchBtn ) {
    punch.trigger();
  }
  if ( dist( mouseX, mouseY, xWhiffBtn, yWhiffBtn ) < dWhiffBtn ) {
    whiff.trigger();
  }
}

void stop() {
  punch.close();
  whiff.close();

  minim.stop();

  super.stop();
}