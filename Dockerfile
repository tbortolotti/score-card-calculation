FROM rocker/r-ver:4.3.2

# Install system dependencies, including build tools and libsodium
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libcairo2-dev \
    libjpeg-dev \
    libxt-dev \
    libsodium-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install 'sodium' first
RUN R -e "install.packages('sodium', repos = 'https://cloud.r-project.org')"

# Install 'plumber'
RUN R -e "install.packages('plumber', repos = 'https://cloud.r-project.org')"

# Copy your app into the container
COPY . /app
WORKDIR /app

# Expose port 8000
EXPOSE 8000

# Start the plumber API
CMD ["Rscript", "start.R"]
