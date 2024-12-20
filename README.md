# Atari 7800 Color Demo

## A note from the programmmer:

November 30, 2024

I can't believe that this program is twenty-three years old.  This program, color.asm was written and released in 2001.
In 2020, I had decided to do one last archival look on a (very) old computer to see if I could find anything of value,
and was surprised to find this old program.  I decided I wanted to open-source it so as to preserve it.

Coming back to it four years later, I decided that whatever utility exists in this source code is far obsolete and in
need of some major cleanup.  Old "hacks" to get things to work from 2001 are no longer needed, as the tools have more
than caught up with the time.  It's this program that fell behind, hence it was worthy of updates.

There's also a Makefile, but due to my limited coding environment, it just runs for Mac users.  There is no Windows
support at this time.

The code itself is a very simple color demo that allows a user to move the joystick in order to change the background
color of their Atari 7800.  It's not that exciting, but back in 2001, there were very few utilities available.
In fact, Atari 7800 encyrpytion had not yet been cracked, and the source code for encrypting games was still not yet
located.  It would eventually be found on an old Atari hard drive, and would become the a7800sign program.

To work around the problem, some amazing coders created "backdoor" in 1999, (with a refresh in 2000).  My color demo
leverages this project heavily.  All of the heavy lifting was done by that program, and I am indebted to those
programmers who went before me to figure things out.

In the 23 years since the release of this demo, the scene of Atari 7800 programming has changed a LOT.
We now have the ability to sign our own cartridges, use new exciting tutorials, and even program in BASIC.
Still, I think it's worth heading back through the annals of time on occasion to remember the past.

The only place that I can remember that I released the binaries for this code was here:
https://atariage.com/forums/topic/153178-some-of-the-demos-i-was-developing-6-years-ago/?tab=comments#comment-1875410

I decided it would be worth creating a github mirror that contains the source code.

Enjoy!
  -John

## Requirements:

DASM 2.12.04 or greater (to support the 'incbin' directive)

Additonally, in order to compile the 2001 version of this code properly, you must take the last 4K of Tomcat F-14 for
the Atari 7800 and create a file called TOMCAT4K.BIN.  This is the only way this will compile.  Note that for legal
reasons, I am not including this file, especially since it is now obsolete in the current source code.

You will also need an Atari 7800 emulator to be able to run the program.

## Getting started

If you are using a Mac computer:

1. Open "Terminal"
1. Go to a directory of your choice (e.g. mkdir ~/atari ; cd ~/atari)
1. git clone https://github.com/johnkharvey/color7800/
1. cd color7800
1. make setup
1. make
1. make run

Windows compilation is not yet supported.

## Questions?

If you have questions, feel free to reach out to me on Atari Age, user @Propane13

