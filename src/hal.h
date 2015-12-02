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

#ifndef _HAL_H_
#define _HAL_H_

#ifdef RFCAT_CHRONOS
  #define LED 			P1_0
  #define LED_MASK		0x01
  #define USB_ENABLE		P1_1
  #define USB_MASK		0x02
  #define CC1111CHRONOS_PIN_DC 	P2_2
#endif

#ifdef RFCAT_DONSDONGLE
  #define LED 			P1_1
  #define LED_MASK		0x02
  #define USB_ENABLE		P1_0
  #define USB_MASK		0x01
  #define CC1111EM_BUTTON 	P1_2
#endif

#ifdef RFCAT_YARDSTICKONE
  #define LED1 			P1_1
  #define LED2 			P1_2
  #define LED3 			P1_3
  #define LED_MASK		0x0E
  #define USB_ENABLE		P1_0
  #define USB_MASK		0x01
  #define CC1111YSONE_PIN_DC	P2_2
  #define TX_AMP_EN		P2_0
  #define RX_AMP_EN		P2_4
  #define AMP_BYPASS_EN		P2_3
#endif

#ifdef RFCAT_SRFSTICK
  #define LED1 			P1_5
  #define LED2 			P1_6
  #define LED3 			P1_7
  #define LED_MASK		((1<<7)|(1<<6)|(1<<5))
  #define USB_ENABLE		P2_0
  #define USB_MASK		0x01
#endif

void setup_led();
void led_on();
void led_off();
void setup_button();
void setup_gpio();

void usb_up();
void usb_down();

#define BUTTON_PRESSED  	0
#define GROUNDED		0
#endif // _HAL_H_
