package myth.util 
{
	public final class PerlinNoise 
	{
		private var rand:Random;
	
		private const B:uint = 0x1000;
		private const BM:uint = 0xff;
		private const N:uint = 0x1000;
		private const NP:uint = 12;
		private const NM:uint = 0xfff;

		private const DEFAULT_SAMPLE_SIZE:int = 256;

		private const LOG_HALF:Number = Number(Math.log(0.5));

		private var p_imp:Vector.<int>;

		private var p:Vector.<int>;
		private var g3:Vector.<Vector.<Number>>;
		private var g2:Vector.<Vector.<Number>>;
		private var g1:Vector.<Number>;
		
		public function PerlinNoise(s:int) 
		{
			p_imp = new Vector.<int>(DEFAULT_SAMPLE_SIZE << 1);

			var i:int;
			var j:int;
			var k:int;
			rand = new Random(s);
			
			for (i = 0; i < DEFAULT_SAMPLE_SIZE; i++)
			{
				p_imp[i] = i;
			}

			while(--i > 0)
			{
				k = p_imp[i];
				j = int(rand.nextInt(10000) & DEFAULT_SAMPLE_SIZE);
				p_imp[i] = p_imp[j];
				p_imp[j] = k;
			}

			initPerlin1();
		}
		
		private function initPerlin1():void
		{
			var size:int = int(B) + int(B) + 2;
			p = new Vector.<int>(size);
			g3 = new Vector.<Vector.<Number>>(size);
			g2 = new Vector.<Vector.<Number>>(size);
			g1 = new Vector.<Number>(size);
			var i:int;
			var j:int;
			var k:int;
			
			for (i = 0; i < B; i++)
			{
				p[i] = i;
				
				g1[i] = Number(((rand.nextNumber() * int.MAX_VALUE) % (B + B)) - B) / B;
				
				g2[i] = new Vector.<Number>(2);
				for (j = 0; j < 2; j++ )
				{
					g2[i][j] = Number(((rand.nextNumber() * int.MAX_VALUE) % (B + B)) - B) / B;
				}
				normalize2(g2[i]);
				
				g3[i] = new Vector.<Number>(3);
				for (j = 0; j < 3; j++ )
				{
					g3[i][j] = Number(((rand.nextNumber() * int.MAX_VALUE) % (B + B)) - B) / B;
				}
				normalize3(g3[i]);
			}

			while(--i > 0)
			{
				k = p[i];
				j = int((rand.nextNumber() * int.MAX_VALUE) % B);
				p[i] = p[j];
				p[j] = k;
			}

			for (i = 0; i < B + 2; i++ )
			{
				p[B + i] = p[i];
				g1[B + i] = g1[i];
				
				if (g2[B + i] == null)
				{
					g2[B + i] = new Vector.<Number>(2);
				}
				for (j = 0; j < 2; j++)
				{
					g2[B + i][j] = g2[i][j];
				}
				
				if (g3[B + i] == null)
				{
					g3[B + i] = new Vector.<Number>(3);
				}
				for (j = 0; j < 3; j++)
				{
					g3[B + i][j] = g3[i][j];
				}
			}
		}
		
		public function normalize2(v:Vector.<Number>):void
		{
			var s:Number = Number(1 / Math.sqrt(v[0] * v[0] + v[1] * v[1]));
			v[0] *= s;
			v[1] *= s;
		}
		
		public function normalize3(v:Vector.<Number>):void
		{
			var s:Number = Number(1 / Math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]));
			v[0] *= s;
			v[1] *= s;
			v[2] *= s;
		}
		
		private function sCurve(t:Number):Number
		{
			return (t * t * (3 - 2 * t));
		}
		
		private function lerp(t:Number, a:Number, b:Number):Number
		{
			return a + t * (b - a);
		}
		
		//================================================
		//FUNCTIONS
		//================================================

		/**
		 * 1-D noise generation function using the original perlin algorithm.
		 *
		 * @param x Seed for the noise function
		 * @return The noisy output
		 */
		public function noise1(x:Number):Number
		{
			var t:Number = x + N;
			var bx0:int = (int(t)) & BM;
			var bx1:int = (bx0 + 1) & BM;
			var rx0:Number = t - int(t);
			var rx1:Number = rx0 - 1;

			var sx:Number = sCurve(rx0);

			var u:Number = rx0 * g1[p[bx0]];
			var v:Number = rx1 * g1[p[bx1]];
			return lerp(sx, u, v);
		}
		
		/**
		 * Create noise in a 2D space using the orignal perlin noise algorithm.
		 *
		 * @param x The X coordinate of the location to sample
		 * @param y The Y coordinate of the location to sample
		 * @return A noisy value at the given position
		 */
		public function noise2(x:Number, y:Number):Number
		{
			var t:Number = x + N;
			var bx0:int = (int(t)) & BM;
			var bx1:int = (bx0 + 1) & BM;
			var rx0:Number = t - int(t);
			var rx1:Number = rx0 - 1;

			t = y + N;
			var by0:int = (int(t)) & BM;
			var by1:int = (by0 + 1) & BM;
			var ry0:Number = t - int(t);
			var ry1:Number = ry0 - 1;

			var i:int = p[bx0];
			var j:int = p[bx1];
			
			var b00:int = p[i + by0];
			var b10:int = p[j + by0];
			var b01:int = p[i + by1];
			var b11:int = p[j + by1];

			var sx:Number = sCurve(rx0);
			var sy:Number = sCurve(ry0);

			var q:Vector.<Number> = g2[b00];
			var u:Number = rx0 * q[0] + ry0 * q[1];
			q = g2[b10];
			var v:Number = rx1 * q[0] + ry0 * q[1];
			var a:Number = lerp(sx, u, v);

			q = g2[b01];
			u = rx0 * q[0] + ry1 * q[1];
			q = g2[b11];
			v = rx1 * q[0] + ry1 * q[1];
			var b:Number = lerp(sx, u, v);

			return lerp(sy, a, b);
		}
	}
}