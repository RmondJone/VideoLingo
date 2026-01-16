FROM python:3.10.11-slim

# Change software sources and install basic tools and system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends git curl sudo ffmpeg fonts-noto wget \
    && python3 --version && python3 -m pip --version

# Clean apt cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory and clone repository
WORKDIR /app
RUN git clone https://github.com/RmondJone/VideoLingo.git .

# Install PyTorch and torchaudio
#RUN pip install torch==2.0.0 torchaudio==2.0.0 --index-url https://download.pytorch.org/whl/cu118

# Clean up unnecessary files
RUN rm -rf .git

# Upgrade pip and install basic dependencies
#RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# Install dependencies
RUN  pip install --upgrade pip setuptools

COPY requirements.txt .
RUN pip install -e .

EXPOSE 8501

CMD ["streamlit", "run", "st.py"]