FROM rocker/plumber

# Install any extra packages you need
RUN R -e "install.packages(c('plumber'))"

# Copy your API files into the image
COPY . /app
WORKDIR /app

# Expose port
EXPOSE 8000

# Command to run your API
CMD ["Rscript", "start.R"]