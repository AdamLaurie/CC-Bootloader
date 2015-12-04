/*
 * CC Bootloader - Hardware Abstraction Layer 
 *
 * Fergus Noble (c) 2011
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
 */

#include "cc1111.h"
#include "hal.h"

void setup_led() {
  // Setup LED and turn it off
  P1DIR |= LED_MASK;
  led_off();
}

void setup_button() {
#ifdef RFCAT_DONSDONGLE
  P1DIR &= ~4;
#endif
#ifdef RFCAT_CHRONOS
  P2DIR &= ~4;
#endif
#ifdef RFCAT_YARDSTICKONE
  P2DIR &= ~4;
#endif
}

// any other gpio pins
void setup_gpio() {
#ifdef RFCAT_YARDSTICKONE
  // amplifer configuration pins
  //P0_0 input with pull-up (antenna port power off)
  P0DIR &= ~1; // Set direction to IN (clear bit for P0_0)
  P0INP &= ~P0INP_MDP0_0_TRISTATE;  // Set as pull up/down (rather than tristate)
  P2INP &= ~P2INP_PDUP0_PULL_DOWN; // clear pull down bit (i.e. pull up)
  P2DIR |= 0x19;
  TX_AMP_EN = 0;
  RX_AMP_EN = 0;
  AMP_BYPASS_EN = 1;
#endif
}

void led_on() {
#if defined(RFCAT_YARDSTICKONE) || defined(RFCAT_SRFSTICK)
  LED1 = 1;
  LED2 = 1;
  LED3 = 1;
#else
  LED = 1;
#endif
}

void led_off() {
#if defined(RFCAT_YARDSTICKONE) || defined(RFCAT_SRFSTICK)
  LED1 = 0;
  LED2 = 0;
  LED3 = 0;
#else
  LED = 0;
#endif
}

void usb_up() {
  // Bring up the USB link
#ifdef RFCAT_SRFSTICK
  P2DIR |= USB_MASK;
#else
  P1DIR |= USB_MASK;
#endif
  USB_ENABLE = 1;
}

void usb_down() {
  // Bring down the USB link
  USB_ENABLE = 0;
#ifdef RFCAT_SRFSTICK
  P2DIR &= ~USB_MASK;
#else
  P1DIR &= ~USB_MASK;
#endif
}
