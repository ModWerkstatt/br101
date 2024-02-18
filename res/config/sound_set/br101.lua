local bbs2util = require "bbs2util"

function data()
return {
	tracks = {
		{ name = "vehicle/br101/101_stand.wav", refDist = 25.0 },
		{ name = "vehicle/br101/101_luefter.wav", refDist = 25.0 },
		{ name = "vehicle/br101/101_beschl.wav", refDist = 25.0 },
		{ name = "vehicle/br101/101_anfahrt.wav", refDist = 25.0 },
		{ name = "vehicle/br101/101_anf2.wav", refDist = 25.0 },
		{ name = "vehicle/br101/kurve.wav", refDist = 20.0 },
		{ name = "vehicle/br101/bremse_neu.wav", refDist = 25.0 },
		{ name = "vehicle/br101/101_brems.wav", refDist = 25.0 }
	},
	events =  {
		horn = { names = { "vehicle/br101/101_makro.wav" }, refDist = 25.0 }
	},

	updateFn = function (input)
		local axleRefWeight = 10.0
		
		return {
			tracks = {
				{ 
					gain = bbs2util.sampleCurve({ 
									{ .0, 0.75 },
									{ .1, .0 },
									{ 1.0, .0 } }, input.speed01),
					pitch = bbs2util.sampleCurve({ 
									{ .0, 1.0 },
									{ 1.0, 1.0 } }, input.speed01)
				},
				--luefter
				{ 
					gain = bbs2util.sampleCurve({ 
									{ .0, .0 },
									{ .149, .0 },
									{ 0.15, 0.8 },
									{ 1.0, 0.8 } }, input.speed01),
					pitch = bbs2util.sampleCurve({ 
									{ .0, 1.0 },
									{ 1.0, 1.0 } }, input.speed01)
				},
				--beschleunigung
				{	 
					gain = bbs2util.sampleCurve({ 
										{ 0.0, 0.0 },
										{ 0.15, 0.0 },
										{ 0.16, 0.7 },
										{ 1.0, 0.8 } }, input.power01),
					pitch = bbs2util.sampleCurve({ 
										{ 0.0, 0.0 },
										{ 0.19, 0.0 },
										{ 0.2, 0.5 },
										{ 1.0, 1.25 } }, input.speed01)
				},
				--anfahrt 1
				{ 
					gain = bbs2util.sampleCurve({ 
									{ .0, 0.0 },
									{ .01, 1.0 },
									{ 0.15, 1.0 },
									{ 0.161, 0.0 },
									{ 1.0, 0.0 }}, input.speed01),
					pitch = bbs2util.sampleCurve({ 
									{ .0, 0.9 },
									{ .05, 1.0 },
									{ .25, 1.0 },
									{ .26, 0.0 },
									{ 1.0, 0.0 } }, input.speed01)
				},		
				--anfahrt2
				{ 
					gain = bbs2util.sampleCurve({ 
									{ .0, 0.0 },
									{ .148, 0.0 },
									{ .15, 1.25 },
									{ .5, 0.0 },
									{ 1.0,0.0 } }, input.speed01),								
					pitch = bbs2util.sampleCurve({ 
									{ .0, 0.0 },
									{ .399, 0.0 },
									{ .4, 1.0 },
									{ 1.0, 1.0 } }, input.power01)
				},				

				bbs2util.squeal(input.speed, input.sideForce, input.maxSideForce),
				bbs2util.brake(input.speed, input.brakeDecel, 1.2),
				bbs2util.slow(input.speed, input.brakeDecel, 1.5)
			},
			events = {
			}
		}
	end
}
end
