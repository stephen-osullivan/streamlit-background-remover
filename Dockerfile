# Use a lightweight Python image
FROM python:3.9-slim

# Install system dependencies for wget and Python libraries
RUN apt-get update && apt-get install -y wget && apt-get clean

# Create a directory for model weights
RUN mkdir -p /app/models
# Download the model weights
RUN wget -O /app/models/u2net.onnx https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx
# Set the environment variable to use the custom weights directory
ENV U2NET_HOME=/app/models

# Install dependencies
COPY requirements.txt .
RUN pip install -U pip && pip install --no-cache-dir -r requirements.txt

# Copy app and models
WORKDIR /app
COPY . .

# Expose Streamlit port
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]