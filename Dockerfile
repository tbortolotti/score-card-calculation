FROM rocker/r-ver:4.3.2

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libcairo2-dev \
    libjpeg-dev \
    libxt-dev \
    && rm -rf /var/lib/apt/lists/*

# Install 'plumber' package and clear any cached files
RUN R -e "install.packages('plumber', repos = 'https://cloud.r-project.org')"

# Copy your app into the container
COPY . /app
WORKDIR /app

# Expose port 8000
EXPOSE 8000

# Start the plumber API
CMD ["Rscript", "start.R"]
