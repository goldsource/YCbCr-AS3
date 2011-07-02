package de.goldsource.utils
{	
	/**
	 * <p>
	 * <b>YCbCr Utility</b>
	 * </p> 
	 * <p>
	 * Use this Class to convert RGB Pixel to Component YCbCr Color Space vice versa. 
	 * <br/> 
	 * <p>
	 * <p>
	 * <b>Examples:</b>
	 * </p>
	 * <code>var ycbcrPixel:uint = YCbCr.pixelFromRGB(0x005599);</code><br/>
	 * <code>var ycbcrVector:Vector.&lt;uint&gt; = YCbCr.vectorFromRGB(0x005599);</code><br/>
	 * <code>var rgbPixel:uint = YCbCr.rgbFromPixel(ycbcrPixel);</code><br/>
	 * <code>var rgbPixelFromVector:uint = YCbCr.rgbFromVector(ycbcrVector);</code><br/>
	 * </p> 
	 * <p>
	 * <b>Algorithm</b>
	 * </p>
	 * <p> 
	 * <code>
	 * <table> 
	 * <tr align="center"><td colspan="9">Converting RGB to YCbCr</td></tr>
	 * <tr align="right"><td>Y</td>  <td></td>  <td>0</td>   <td></td>  <td>.299</td>  <td>.581</td>  <td>0.114</td>  <td></td>   <td>R</td> </tr>
	 * <tr align="right"><td>Cb</td> <td>=</td> <td>128</td> <td>+</td> <td>-.169</td> <td>-.331</td> <td>.500</td>   <td>~~</td> <td>G</td> </tr>
	 * <tr align="right"><td>Cr</td> <td></td>  <td>128</td> <td></td>  <td>.500</td>  <td>-.419</td> <td>-0.081</td> <td></td>   <td>B</td> </tr>
	 * </table>
	 * </code>
	 * </p>
	 * <p>
	 * <code>var y:uint = ( .299 ~~ r + .587 ~~ g  +  0.114 ~~ b) + 0;</code><br/>
	 * <code>var cb:uint = ( -.169 ~~ r + -.331 ~~ g +  0.500 ~~ b) + 128;</code><br/>
	 * <code>var cr:uint = ( .500 ~~ r + -.419 ~~ g +  -0.081 ~~ b) + 128;</code><br/>
	 * </p>
	 * <p> 
	 * <code>
	 * <table> 
	 * <tr align="center"><td colspan="9">Converting YCbCr to RGB</td></tr>
	 * <tr align="right"><td>R</td> <td></td>  <td>1</td> <td>0</td>     <td>1.4</td>   <td></td>  <td>y</td>      </tr> 
	 * <tr align="right"><td>G</td> <td>=</td> <td>1</td> <td>-.343</td> <td>-.711</td> <td>~~</td> <td>cb-128</td> </tr>
	 * <tr align="right"><td>B</td> <td></td>  <td>1</td> <td>1.765</td> <td>0</td>     <td></td>  <td>cr-128</td> </tr>
	 * </table>
	 * </code>
	 * </p>
	 * <p>
	 * <code>var r:uint = 1 ~~ y +  0 ~~ (cb-128)   +  1.4 ~~ (cr-128);</code><br/>
	 * <code>var g:uint = 1 ~~ y +  -.343 ~~ (cb-128)  +  -.711 ~~ (cr-128);</code><br/>
	 * <code>var b:uint = 1 ~~ y +  1.765 ~~ (cb-128)  +  0 ~~ (cr-128);</code><br/>
	 * </p>  
	 * <p>
	 * For more info visit:
	 * <br/>
	 * <a href="http://en.wikipedia.org/wiki/YCbCr">Wikipedia</a>
	 * <br/>
	 * <a href="http://www.equasys.de/colorconversion.html">Equasys</a>
	 * </p>
	 * <p>
	 * <b>License</b>
	 * <br/>
	 * <a href="http://www.opensource.org/licenses/mit-license.php">based on The MIT License (MIT)</a>
	 * </p>
	 * <p>
	 * Copyright (c) 2011 Nicholas Schreiber
	 * </p>
	 * <p>
	 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	 * </p>
	 * <p>
	 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	 * </p>
	 * <p>
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	 * </p>
	 * @author Nicholas Schreiber
	 * @see de.goldsource.utils.YCbCr.pixelFromRGB()
	 * @see de.goldsource.utils.YCbCr.vectorFromRGB()
	 * @see de.goldsource.utils.YCbCr.pixelToRGB()
	 * @see de.goldsource.utils.YCbCr.vectorToRGB()
	 **/
	public class YCbCr
	{	
		/**
		 * <p>
		 * <b>pixelFromRGB Method</b>
		 * </p> 
	 	 * <p>
		 * Converts a RGB Pixel to a YCbCr Pixel<br/>
		 * </p>
		 * @author Nicholas Schreiber
		 * @param rgb - any Integer between 0x0 and 0xFFFFFF representing the RGB value
		 * @return uint - An Integer between 0x0 and 0xFFFFFF representing the YCbCr value
		 * @see de.goldsource.utils.YCbCr
		 */
		public static function pixelFromRGB(rgb:uint):uint{
			var pixel:Vector.<uint> = new Vector.<uint>();
			var r:uint = rgb >> 16;
			var g:uint = (rgb ^ rgb >> 16 << 16) >> 8;
			var b:uint =  rgb >> 8 << 8 ^ rgb;		
			var y:uint = ((.299*r)+(.587*g)+(0.114*b));
			var cb:uint = ((-.169*r)+(-.331*g)+(0.500*b))+128;
			var cr:uint = ((.500*r)+(-.419*g)+(-0.081*b))+128;			
			return  y << 16 ^ cb << 8 ^ cr;		
		}
		
		/**
		 * <p>
		 * <b>vectorFromRGB Method</b>
		 * </p> 
	 	 * <p>
		 * Converts a RGB Pixel to a Vector containing YCbCr Components<br/>
		 * </p>
		 * @author Nicholas Schreiber
		 * @param rgb - any integer between 0x0 and 0xFFFFFF representing the RGB value
		 * @return Vector.&lt;uint&gt; - A Vector containing 3 elements of type uint [0] = y, [1] = Cb, [2] = Cr representing the YCbCr value
		 * @see de.goldsource.utils.YCbCr
		 */
		public static function vectorFromRGB(rgb:uint):Vector.<uint>{
			var pixel:Vector.<uint> = new Vector.<uint>();
			var r:uint = rgb >> 16;
			var g:uint = (rgb ^ rgb >> 16 << 16) >> 8;
			var b:uint =  rgb >> 8 << 8 ^ rgb;		
			var y:uint = ((.299*r)+(.587*g)+(0.114*b));
			var cb:uint = ((-.169*r)+(-.331*g)+(0.500*b))+128;
			var cr:uint = ((.500*r)+(-.419*g)+(-0.081*b))+128;			
			return new <uint>[y,cb,cr];		
		}
		
		/**
		 * <p>
		 * <b>vectorToRGB Method</b>
		 * </p> 
	 	 * <p>
		 * Converts a yCbCr Vector to a RGB pixel<br/>
		 * </p>
		 * @author Nicholas Schreiber
		 * @param yCbCr - a Vector containing 3 integers between 0x0 and 0xFF. [0] = y, [1] = Cb, [2] = Cr representing the YCbCr value
		 * @return uint - An Integer between 0x0 and 0xFFFFFF representing the RGB value
		 * @see de.goldsource.utils.YCbCr
		 */
		public static function vectorToRGB(yCbCr:Vector.<uint>):uint{					
			var r:uint = (yCbCr[0])+(1.4*(yCbCr[2]-128));
			var g:uint = (yCbCr[0])+(-.343*(yCbCr[1]-128))+(-.711*(yCbCr[2]-128));
			var b:uint = (yCbCr[0])+(1.765*(yCbCr[1]-128));			
			return r << 16 ^ g << 8 ^ b;	
		}
		
		/**
		 * <p>
		 * <b>pixelToRGB Method</b>
		 * </p> 
	 	 * <p>
		 * Converts a yCbCr Pixel to a RGB Pixel<br/>
		 * </p>
		 * @author Nicholas Schreiber
		 * @param yCbCr - any Integer between 0x0 and 0xFFFFFF representing the YCbCr value
		 * @return uint - An Integer between 0x0 and 0xFFFFFF representing the RGB value
		 * @see de.goldsource.utils.YCbCr
		 */
		public static function pixelToRGB(yCbCr:uint):uint{	
			var y:uint = yCbCr >> 16;
			var cb:uint = (yCbCr ^ yCbCr >> 16 << 16) >> 8;
			var cr:uint =  yCbCr >> 8 << 8 ^ yCbCr;		
			var r:uint = (y)+(1.4*(cb-128));
			var g:uint = (y)+(-.343*(cb-128))+(-.711*(cr-128));
			var b:uint = (y)+(1.765*(cb-128));			
			return r << 16 ^ g << 8 ^ b;	
		}
	}
}