package utils;

class RandomLCG {
	public static final RANDOMLCG_MAX:UInt = (1 << 31) - 1;

	var seed:UInt = 0;

	public function new(seed:UInt = 0) {
		this.seed = seed;
	}

	public function randBSD():UInt {
		seed = (seed * 1_103_515_245u32 + 12_345u32) & RANDOMLCG_MAX;
		return seed;
	}

	public function randMS():UInt {
		seed = (seed * 214_013u32 + 2_531_011u32) & RANDOMLCG_MAX;
		return seed >> 16;
	}

	public function rand16():UInt {
		seed = (seed * 101_427u32 + 321u32) % RANDOMLCG_MAX;
		return seed >> 16;
	}

	public static function randomizedSeed():UInt {
		return Math.round(Math.random() * RANDOMLCG_MAX);
	}
}
