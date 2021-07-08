FROM with_r
USER root
#RUN apt-get install -y julia
# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_DEPOT_PATH=/opt/julia
ENV JULIA_PKGDIR=/opt/julia
ENV JULIA_VERSION=1.0.0

RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    echo "bea4570d7358016d8ed29d2c15787dbefaea3e746c570763e7ad6040f17831f3 *julia-${JULIA_VERSION}-linux-x86_64.tar.gz" | sha256sum -c - && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz
RUN ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# Show Julia where conda libraries are \
RUN mkdir /etc/julia && \
    echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    mkdir $JULIA_PKGDIR && \
    chown $NB_USER $JULIA_PKGDIR

RUN julia -e 'import Pkg; Pkg.update()' && \
    (test $TEST_ONLY_BUILD || julia -e 'import Pkg; Pkg.add("HDF5")') && \
    julia -e 'import Pkg; Pkg.add("Gadfly")' && \
    julia -e 'import Pkg; Pkg.add("RDatasets")' && \
    julia -e 'import Pkg; Pkg.add("IJulia"); Pkg.add("StatsPlots");Pkg.add("Plots"); Pkg.add("StatsPlots");Pkg.add("DataFrames")'

RUN julia -e 'import Pkg; Pkg.add("Seaborn"); Pkg.add("PyPlot")'
RUN julia -e 'import Pkg;Pkg.clone("https://github.com/gsoleilhac/NSGAII.jl")'
USER jovyan
# Precompile Julia packages \
RUN sudo julia -e 'using Pkg; Pkg.add("IJulia"); using IJulia'
ADD stochastic_gd.jl .
RUN sudo julia stochastic_gd.jl

# move kernelspec out of home \
# mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/ && \
# chmod -R go+rx $CONDA_DIR/share/jupyter && \
# rm -rf $HOME/.local && $JULIA_PKGDIR $CONDA_DIR/share/jupyter
