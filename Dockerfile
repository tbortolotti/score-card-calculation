FROM rocker/r-ver:4.3.2

# Install system dependencies (if needed)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install plumber
RUN R -e "install.packages('plumber', repos = 'https://cloud.r-project.org')"

# Copy your app
COPY . /app
WORKDIR /app

# Expose port 8000
EXPOSE 8000

# Start the plumber API
CMD ["Rscript", "start.R"]