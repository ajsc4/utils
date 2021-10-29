


using Images

import Plots; using Plots
pyplot()

import Statistics; using Statistics
import TiffImages; using TiffImages

#stack = TiffImages.load("multispec_newsetup2.tif", mmap = true)
filename = "C:/Users/Alexander Collins/Desktop/Code/Data00005.tif"
stack = TiffImages.load(filename, mmap = true)


function plotimagemean(stack)
	N = length(stack[1,1,:])

	[Float64(sum(stack[:,:,i]) / length(stack[:,:,1])) for i in 1:N]
end

meanvals = plotimagemean(stack)

plot(1:length(stack[1,1,:]), meanvals ./ maximum(meanvals), xlabel = "Frame", ylabel = "Normalised Average Intensity", legend = false, dpi = 300, grid = false)

#savefig("C:\\Users\\Alexander Collins\\Desktop\\Code\\counts.png")
