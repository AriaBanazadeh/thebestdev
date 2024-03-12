#Use the official Ubuntu base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Add Neovim PPA (if available) and install Neovim
# For the latest instructions, always check the official Neovim GitHub or documentation
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:neovim-ppa/unstable \
    && apt-get update && apt-get install -y \
    neovim \
    git \
    tmux \
    curl \
    make \
    ripgrep \
    fd-find \
    nodejs \
    npm \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-latex-extra \
    zathura \
    python3-pip \
   # Clean up
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# Install vim-plug for Neovim
RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN pip3 install neovim
# Set up your Neovim environment
COPY config/init.vim /root/.config/nvim/
COPY config/init.vim /etc/xdg/nvim/
COPY config/.tmux.conf /root/.tmux.conf
COPY config/.bashrc /root/.bashrc
# Pre-install Neovim plugins. This step might require interactive input,
# and Docker builds are non-interactive, so we might need to adjust plugin installation scripts if necessary.
# Here, we attempt a non-interactive approach
RUN nvim --headless +PlugInstall +qall

# Set the working directory for container startup, this is where you can mount your development volume
WORKDIR /workspace

