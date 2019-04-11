println("reminder to Russell")
println("to install packages use")
println("launch julia using sudo")
println("try to import module first using, 'using'")
println("include('ml.jl')")
#println("Pkg.add('PyCall')")
println("\n\n\n\n\n\n")
using Pkg

function trypy()
	try
        ENV["PYTHON"] = "/opt/conda/bin/python"
        Pkg.rm("PyCall")
        Pkg.build("PyCall")
        Pkg.test("PyCall")
        plt = pyimport("matplotlib.pyplot")
        x = range(0;stop=2*pi,length=1000); y = sin.(3*x + 4*cos.(2*x));
        plt.plot(x, y, color="red", linewidth=2.0, linestyle="--")
        #plt.show()

		#return unreliable_connect()
	catch ex
        ENV["PYTHON"] = "/anaconda3/bin/python"
        Pkg.rm("PyCall")
        Pkg.build("PyCall")
        Pkg.test("PyCall")

        math = pyimport("math")
        Pkg.test("PyCall")
        plt = pyimport("matplotlib.pyplot")
        x = range(0;stop=2*pi,length=1000); y = sin.(3*x + 4*cos.(2*x));
        plt.plot(x, y, color="red", linewidth=2.0, linestyle="--")

        math.sin(math.pi / 4) # returns ≈ 1/√2 = 0.70710678...
	   end
end
Pkg.add("StatsPlots")
Pkg.add("PyCall")
Pkg.add("GR")
Pkg.add("IJulia");
Pkg.add("Plots");
Pkg.add("StatsPlots"); #to install the StatPlots package.
Pkg.add("DataFrames");
Pkg.add("Seaborn")
Pkg.add("PyPlot")
Pkg.add("Knet")
using DataFrames
#    using IJulia
using Knet
using Plots;
using StatsPlots;
using PyCall;
println("done")
